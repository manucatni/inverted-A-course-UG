# Undergraduate BSc Mathematics Syllabus: Introduction to Formalized Mathematics & Theorem Proving in Lean 4

This document outlines a complete 12-week semester curriculum designed specifically for undergraduate BSc Mathematics students to learn formal proof verification and interactive theorem proving using Lean 4.

---

## Course Philosophy: "Mathematics-First"

Traditional computer science guides for Lean 4 focus heavily on programming paradigms (such as state, monads, and systems programming). This curriculum adopts a **Mathematics-First** approach:
*   **Logical Rigor**: Leverages the students' mathematical maturity to teach formal logic and type theory.
*   **Application-Oriented**: Focuses on formalizing calculus, algebra, set theory, and number theory.
*   **Skip the CS Noise**: Intentionally bypasses advanced functional programming topics (like monad transformers, parsers, and I/O) that are not relevant to proving mathematical theorems.

---

## The Three Pillars: Textbook Blending Strategy

We selectively extract content from the three primary Lean 4 resources:

1.  **Functional Programming in Lean (FPIL)**:
    *   *Cover*: Basic type syntax, inductive definitions (e.g., how the natural numbers or lists are built), and pattern-matching.
    *   *Skip*: Monads, monad transformers, I/O, parsers, and concurrency.
2.  **Theorem Proving in Lean 4 (TPIL)**:
    *   *Cover*: Propositional logic, first-order quantifiers ($\forall, \exists$), tactics, and basic type theory.
    *   *Skip*: Custom tactic writing and meta-programming.
3.  **Mathematics in Lean (MIL)**:
    *   *Cover*: **(Primary Textbook)** Real analysis, set theory, functions, relations, number theory, and abstract algebra.

---

## 📅 12-Week Semester Schedule

| Week | Mathematical Topic | Lean Tactics & Language Primitives | Reading Assignments |
| :--- | :--- | :--- | :--- |
| **Week 1** | **Introduction to Formal Systems**<br>The Peano natural numbers, equality, and basic rewrites. | `rfl`, `rw`, `induction` | **FPIL**: Chapter 1<br>**TPIL**: Chapter 2 |
| **Week 2** | **Propositional Logic**<br>Constructing proofs using And ($\land$), Or ($\lor$), and Implication ($\to$). | `intro`, `apply`, `exact`, `constructor`, `have` | **TPIL**: Chapter 3 |
| **Week 3** | **Classical vs. Constructive Logic**<br>Double negation elimination, contradiction, and case analysis. | `by_cases`, `contradiction`, `exfalso` | **TPIL**: Section 3.5 |
| **Week 4** | **First-Order Predicate Logic**<br>Working with universal ($\forall$) and existential ($\exists$) quantifiers. | `rcases`, `use`, `obtain` | **TPIL**: Chapter 4 |
| **Week 5** | **Real Numbers & Inequalities**<br>Working with real numbers ($\mathbb{R}$), bounds, and algebraic structures. | `ring`, `linarith`, `gcongr`, `positivity` | **MIL**: Chapter 2 |
| **Week 6** | **Functions & Relations**<br>Injectivity, surjectivity, composition, and inverse functions. | `dsimp`, `ext` | **MIL**: Sections 3.1 – 3.3 |
| **Week 7** | **Set Theory Foundations**<br>Unions, intersections, complements, and subset relationships. | `subset_def`, `ext`, `aesop` | **MIL**: Sections 3.4 – 3.6 |
| **Week 8** | **Equivalence Relations**<br>Reflexivity, symmetry, transitivity, and quotient structures. | `rcases`, equivalence tactics | **MIL**: Section 3.6 |
| **Week 9** | **Elementary Number Theory**<br>Divisibility, primes, GCD, and modular arithmetic on $\mathbb{Z}$. | `omega`, `dvd_add`, basic division theorems | **MIL**: Chapter 4 |
| **Week 10** | **Induction & Structural Recursion**<br>Inductive proofs over lists, trees, and custom mathematical structures. | `induction`, pattern matching, structural proofs | **FPIL**: Chapter 2<br>**MIL**: Section 4.3 |
| **Week 11** | **Abstract Algebra**<br>Monoids, groups, subgroups, and group homomorphisms. | `group` tactic, identity proofs, sub-structures | **MIL**: Chapter 6 |
| **Week 12** | **Real Analysis: Sequences & Limits**<br>Formalizing $\epsilon$-$\delta$ proofs for limits of sequences. | Advanced combinations of `linarith`, `gcongr`, and nested quantifiers | **MIL**: Section 5.1 |

---

## 🛠️ Weekly Lesson Plans & Topic Breakdown

### Week 1: Introduction to Formal Systems
*   **Math Focus**: What is a formal system? How do Peano natural numbers work?
*   **Lean Focus**: Installing Lean, navigating VS Code, the interactive "Infoview" (Proof State).
*   **Key Tactics**: `rfl` (reflexivity), `rw` (rewrite equations), `induction`.
*   **Reading**: FPIL Ch. 1, TPIL Ch. 2.

### Week 2: Propositional Logic
*   **Math Focus**: Truth tables, logical connectives (And, Or, Implication).
*   **Lean Focus**: Curry-Howard isomorphism (proofs as programs, propositions as types).
*   **Key Tactics**: `intro` (assume hypothesis), `apply` (modus ponens / backward reasoning), `exact` (close goals), `constructor` (prove conjunctions), `have` (introduce intermediate steps).
*   **Reading**: TPIL Ch. 3.

### Week 3: Classical vs. Constructive Logic
*   **Math Focus**: Proof by contradiction, Law of the Excluded Middle (LEM), Double Negation.
*   **Lean Focus**: The differences between constructive logic (default) and classical math.
*   **Key Tactics**: `by_cases` (split on $P \lor \neg P$), `contradiction` (detect conflicting assumptions), `exfalso` (explosion principle).
*   **Reading**: TPIL Section 3.5.

### Week 4: First-Order Predicate Logic
*   **Math Focus**: Existential ($\exists$) and Universal ($\forall$) quantifiers in math statements.
*   **Lean Focus**: Working with dependent types where terms depend on values.
*   **Key Tactics**: `rcases` / `obtain` (unpack existentials), `use` (provide witnesses).
*   **Reading**: TPIL Ch. 4.

### Week 5: Real Numbers & Inequalities
*   **Math Focus**: Properties of $\mathbb{R}$, inequalities, and interval arithmetic.
*   **Lean Focus**: Using decision procedures (specialized automated solver tactics).
*   **Key Tactics**: `ring` (normalize polynomial rings), `linarith` (linear inequality solver), `gcongr` (congruence of inequalities), `positivity` (prove expressions are non-negative).
*   **Reading**: MIL Ch. 2.

### Week 6: Functions & Relations
*   **Math Focus**: Injectivity, surjectivity, and composition of functions.
*   **Lean Focus**: Functions as standard terms, function application, and proving function equality.
*   **Key Tactics**: `dsimp` (definitional simplification), `ext` (extensionality).
*   **Reading**: MIL Sections 3.1 – 3.3.

### Week 7: Set Theory Foundations
*   **Math Focus**: Standard operations on sets (unions, intersections, complements).
*   **Lean Focus**: Proving set equalities and set inclusions.
*   **Key Tactics**: `subset_def` (expand set membership), `aesop` (automated proof search for basic set operations).
*   **Reading**: MIL Sections 3.4 – 3.6.

### Week 8: Equivalence Relations
*   **Math Focus**: Relations, equivalence relations, equivalence classes, and quotients.
*   **Lean Focus**: Proving reflexivity, symmetry, and transitivity properties.
*   **Reading**: MIL Section 3.6.

### Week 9: Elementary Number Theory
*   **Math Focus**: Divisibility, prime numbers, greatest common divisors (GCD).
*   **Lean Focus**: Integer arithmetic and linear integer arithmetic solver tactics.
*   **Key Tactics**: `omega` (Presburger arithmetic solver for integers and naturals).
*   **Reading**: MIL Ch. 4.

### Week 10: Induction & Structural Recursion
*   **Math Focus**: Generalizing induction beyond natural numbers (e.g., trees, lists, and graphs).
*   **Lean Focus**: Defining custom inductive types and using pattern matching to define operations and verify proofs over them.
*   **Reading**: FPIL Ch. 2, MIL Section 4.3.

### Week 11: Abstract Algebra
*   **Math Focus**: Groups, rings, subgroups, cosets, and group homomorphisms.
*   **Lean Focus**: Working with Algebraic structures in Mathlib.
*   **Key Tactics**: `group` (algebraic decision procedure for groups).
*   **Reading**: MIL Ch. 6.

### Week 12: Real Analysis & Sequences
*   **Math Focus**: Formalizing limits of sequences ($\lim_{n\to\infty} a_n = L$) using the classic $\epsilon$-$N$ definition.
*   **Lean Focus**: Synthesizing all learned skills. Solving multi-quantifier mathematical proofs with combined tactics.
*   **Reading**: MIL Section 5.1.

---

## 🎓 Pedagogical Workflow & Best Practices

1.  **The Pre-Course Icebreaker**:
    Before lectures start, have students play the online **[Natural Number Game (Lean 4 Edition)](https://adam.math.hhu.de/)**. This gives them an immediate, gamified introduction to rewrites and mathematical induction without requiring any local software installation.
2.  **Active Problem Sheets**:
    Minimize slide-based lectures. Lean is learned by doing. Spend class time writing code interactively.
3.  **Continuous Integration & Autograding**:
    *   Set up homework assignments using **GitHub Classroom**.
    *   Distribute homework as `.lean` files containing the theorems with `sorry` placeholders.
    *   Use GitHub Actions to automatically run `lake build` on student submissions. If the file compiles successfully (without any active `sorry` statements), the student receives credit.
