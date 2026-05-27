// Tab switching logic
function showPage(pageId) {
    document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.nav-item').forEach(i => i.classList.remove('active'));
    
    document.getElementById(pageId).classList.add('active');
    
    // Highlight active navigation link
    const links = document.querySelectorAll('.nav-item');
    links.forEach(link => {
        if (link.getAttribute('onclick').includes(pageId)) {
            link.classList.add('active');
        }
    });
}

// Dynamically determine the backend compiler URL (handling both localhost and secure cloud Codespace proxies)
function getBackendUrl() {
    const hostname = window.location.hostname;
    // Check if hosted inside a GitHub Codespace or Gitpod port proxy
    if (hostname.endsWith("github.dev") || hostname.endsWith("preview.app.github.dev")) {
        // Automatically map the client port proxy to our compiler backend port (1812)
        // E.g., from my-codespace-5500.app.github.dev to my-codespace-1812.app.github.dev
        return `https://${hostname.replace(/-[0-9]+/, "-1812")}`;
    }
    // Fallback to standard local loopback address
    return "http://localhost:1812/";
}

// Live Proof Simulator Compiler Pipeline (HTTP Backend Port 1812)
async function verifyProof() {
    const editor = document.getElementById('editorCode');
    const infoview = document.getElementById('infoviewState');
    const btnVerify = document.getElementById('btnVerify');
    
    const code = editor.innerText.replace(/\u00A0/g, " ").trim();
    if (!code) {
        infoview.innerHTML = `<span style="color:#f43f5e;">Error: Code area is empty.</span>`;
        return;
    }
    
    btnVerify.disabled = true;
    btnVerify.innerText = "Verifying... ⚡";
    infoview.innerHTML = `<div style="color:var(--text-secondary); font-style:italic;">Compiling and verifying theorem in Lean 4 backend...</div>`;
    
    try {
        const backendUrl = getBackendUrl();
        const response = await fetch(backendUrl, {
            method: "POST",
            headers: {
                "Content-Type": "text/plain"
            },
            body: code
        });
        
        const data = await response.json();
        btnVerify.disabled = false;
        btnVerify.innerText = "Verify Proof Live ⚡";
        
        if (data.status === "success") {
            infoview.innerHTML = `<div class="goal-header" style="color:#10b981;">🎉 Goals accomplished!</div>
            <div style="color:var(--text-secondary); margin-top:8px;">${data.message || "Your proof is verified mathematically complete in Lean 4."}</div>`;
        } else if (data.status === "goals") {
            // Render remaining goals
            let goalsHtml = `<div class="goal-header" style="color:#58a6ff;">Remaining Goals:</div>`;
            data.goals.forEach(goal => {
                goalsHtml += `<div style="margin-bottom:8px; line-height:1.4;">${goal}</div>`;
            });
            infoview.innerHTML = goalsHtml;
        } else {
            // Render syntax / compile errors
            infoview.innerHTML = `<div class="goal-header" style="color:#f43f5e;">Compilation Errors:</div>
            <pre style="background:transparent; border:none; padding:0; color:#cbd5e1; white-space:pre-wrap; font-size:0.85rem;">${data.error || "Unknown compiler error."}</pre>`;
        }
    } catch (err) {
        btnVerify.disabled = false;
        btnVerify.innerText = "Verify Proof Live ⚡";
        infoview.innerHTML = `<div class="goal-header" style="color:#f43f5e;">Connection Error:</div>
        <div style="color:var(--text-secondary); margin-top:8px;">Failed to connect to local Lean 4 server on port 1812. 
        Please verify the backend is running by executing <code>lake exe lean_server</code> in your terminal!</div>`;
    }
}

function resetSimulator() {
    const editor = document.getElementById('editorCode');
    const infoview = document.getElementById('infoviewState');
    
    editor.innerText = `theorem add_commutative (m n : Nat) : m + n = n + m := by\n  sorry`;
    infoview.innerHTML = `<div class="goal-header">1 goal</div>m n : Nat<br><span class="goal-turnstile">⊢</span> m + n = n + m`;
}

// Toggle settings popover
function toggleSettings(event) {
    event.stopPropagation();
    const popover = document.getElementById('settingsPopover');
    popover.classList.toggle('show');
}

// Close settings popover when clicking anywhere else
document.addEventListener('click', function(event) {
    const popover = document.getElementById('settingsPopover');
    const settingsBtn = document.getElementById('settingsBtn');
    if (popover && !popover.contains(event.target) && event.target !== settingsBtn && !settingsBtn.contains(event.target)) {
        popover.classList.remove('show');
    }
});

// Change theme
function changeTheme(themeName) {
    // Remove all previous theme classes
    document.documentElement.className = '';
    
    // Apply selected theme class
    if (themeName !== 'midnight') {
        document.documentElement.classList.add('theme-' + themeName);
    }
}

// Change zoom (Range Slider: 70% to 150%)
function changeZoom(scaleValue) {
    const zoomText = document.getElementById('zoomValue');
    if (zoomText) {
        zoomText.innerText = parseFloat(scaleValue).toFixed(1) + '%';
    }
    
    // Convert percentage scale to root em units (standard is 16px at 100%)
    const basePx = 16;
    const newPx = (basePx * scaleValue) / 100;
    document.documentElement.style.fontSize = newPx + 'px';
}

