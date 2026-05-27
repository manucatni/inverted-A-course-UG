# ∀-course-UG: Lean 4 Learning Sandbox

Welcome to **`∀-course-UG`** (For-All Course for Undergraduates), an interactive environment designed to teach formalized mathematics and theorem proving using Lean 4.

This project is a self-contained, zero-cost, interactive course sandbox developed as part of an MSc dissertation.

---

## 📂 Project Structure

- **`.devcontainer/`**: Docker/Codespace configuration for instant, zero-setup cloud development.
- **`portal/`**: A high-fidelity, modular HTML/CSS/JS frontend dashboard with custom color themes (Midnight, Slate, Cyberpunk, Light Mode) and a precise slider zoom controller.
- **`exercises/`**: Standard Lean 4 syllabus modules with exercises (`sorry` proofs) covering:
  - `Intro.lean` — Syntax, `#eval`, and reflexivity (`rfl`).
  - `Logic.lean` — Propositional logic proofs (`∧`, `∨`, `→`).
  - `Arithmetic.lean` — Natural number induction (`Nat`).
- **`src/`**: Lean 4 systems programming backend server source code that receives proof snippets from the frontend portal and compiles them live to return verification goals/errors.

---

## 🚀 How to Run Locally

### 1. Build the Project
Open your terminal inside the `∀-course-UG` folder and compile the backend server and exercise library:
```bash
lake build
```

### 2. Run the Lean 4 Server Backend
Launch the backend server executable:
```bash
lake exe lean_server
```

### 3. Open the Interactive Course Portal
Open the interactive companion dashboard in any web browser:
`portal/html/index.html`
- Toggle settings on the bottom left to change color themes or scale zoom levels.
- Interact with the live simulator to verify proofs!
