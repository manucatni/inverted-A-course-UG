import Std.Internal.Async.TCP
open Std.Net
open Std.Internal.IO.Async
open Std.Internal.IO.Async.TCP

-- Helper to extract the HTTP POST request body (separating headers from body)
def getHttpBody (req : String) : String :=
  let parts := req.splitOn "\r\n\r\n"
  if parts.length >= 2 then
    String.intercalate "\r\n\r\n" (parts.drop 1)
  else
    req

-- Run the Lean 4 compiler sandbox subprocess via Lake env
def verifyProofInLean (code : String) : IO String := do
  let tempFile := "TempProof.lean"
  
  -- We inject the module's standard imports at the top automatically
  -- so the student doesn't have to write them every time.
  let fullCode := s!"import ForallCourse\n\n{code}\n"
  IO.FS.writeFile tempFile fullCode
  
  IO.println s!"Invoking compiler sandbox for code:\n{code}"
  
  -- Dynamically select command path based on operating system family
  let cmdPath := 
    if System.Platform.isWindows then
      "C:\\Users\\Asus\\.elan\\bin\\lake.exe"
    else
      "lake"
  
  -- Invoke lake env lean to parse in the exact package context
  let out ← IO.Process.output {
    cmd := cmdPath,
    args := #["env", "lean", tempFile]
  }
  
  -- Clean up temporary proof file
  try
    IO.FS.removeFile tempFile
  catch _ =>
    pure ()
    
  let stderr := out.stderr.trimAscii.toString
  let stdout := out.stdout.trimAscii.toString
  let combinedOutput := if stderr.isEmpty then stdout else stderr
  
  IO.println s!"Compiler output:\n{combinedOutput}"
  
  -- Build the custom JSON response based on compiler diagnostics
  if out.exitCode == 0 && combinedOutput.isEmpty then
    return "{\"status\":\"success\",\"message\":\"Goals accomplished! Your proof is mathematically complete and verified.\"}"
  else if combinedOutput.contains "uses `sorry`" || combinedOutput.contains "uses 'sorry'" then
    return s!"\{\"status\":\"error\",\"error\":\"Proof is incomplete! It contains a 'sorry' placeholder: \\n{combinedOutput}\"}"
  else
    -- Escape JSON quotes and backslashes
    let escapedOutput := combinedOutput.replace "\\" "\\\\" |>.replace "\"" "\\\"" |>.replace "\n" "\\n"
    return s!"\{\"status\":\"error\",\"error\":\"{escapedOutput}\"}"

-- Recursive accept loop
partial def acceptLoop (server : Socket.Server) : IO Unit := do
  IO.println "Waiting for client connection..."
  let client ← (server.accept).block
  IO.println "Accepted connection!"
  
  -- Receive HTTP request (up to 8192 bytes for larger proofs)
  let bytes? ← (client.recv? 8192).block
  match bytes? with
  | none => 
    IO.println "Client closed socket without data."
    (client.shutdown).block
  | some bytes =>
    let requestStr := String.fromUTF8! bytes
    
    -- Debug write the raw request string to file to see its layout
    IO.FS.writeFile "RequestDebug.log" requestStr
    
    let isOptions := requestStr.startsWith "OPTIONS"
    let jsonBody ← if isOptions then
      pure ""
    else
      verifyProofInLean (getHttpBody requestStr)
    
    -- Standard HTTP CORS headers to allow browser requests from portal
    let response := s!"HTTP/1.1 200 OK\r\n" ++
                    "Access-Control-Allow-Origin: *\r\n" ++
                    "Access-Control-Allow-Methods: POST, GET, OPTIONS\r\n" ++
                    "Access-Control-Allow-Headers: Content-Type\r\n" ++
                    "Content-Type: application/json\r\n" ++
                    s!"Content-Length: {jsonBody.toUTF8.size}\r\n" ++
                    "Connection: close\r\n\r\n" ++
                    jsonBody
    
    try
      (client.send response.toUTF8).block
      (client.shutdown).block
    catch e =>
      IO.println s!"Warning: Could not send response or shutdown socket: {e}"
      
    IO.println "Closed client connection."
    
  acceptLoop server

def main : IO Unit := do
  IO.println "Initializing ∀-course-UG Lean 4 Backend Server..."
  
  let ip := IPv4Addr.ofParts 127 0 0 1
  let addr : SocketAddress := SocketAddress.v4 { addr := ip, port := 1812 }
  
  let server ← Socket.Server.mk
  server.bind addr
  server.listen 128
  
  IO.println "Server is listening on http://127.0.0.1:1812"
  
  -- Start accept loop
  acceptLoop server
