-- Propositional Logic in Lean 4
-- In Lean, logical statements are Propositions (of type `Prop`).
-- Proofs are constructed interactively using tactics in a `by` block.

namespace Student

variable (P Q R : Prop)

-- 1. Conjunction (And: ∧)
-- To prove an And statement, we can use the `constructor` tactic or `apply And.intro`.
-- To use an And hypothesis `h : P ∧ Q`, we can destructure it using `cases h` or pattern matching.

theorem and_symm (h : P ∧ Q) : Q ∧ P := by
  -- Destructure the hypothesis `h` into its components
  cases h with
  | intro hp hq =>
    -- Construct the new target Q ∧ P
    constructor
    · exact hq
    · exact hp

-- EXERCISE 1: Prove that conjunction is associative.
-- Fill in the proof by replacing 'sorry' with your tactic commands.
theorem and_assoc (h : (P ∧ Q) ∧ R) : P ∧ (Q ∧ R) := by
  sorry


-- 2. Disjunction (Or: ∨)
-- To prove an Or statement, we choose a side to prove using `left` or `right`.
-- To use an Or hypothesis, we must perform case analysis using the `cases` tactic.

theorem or_symm (h : P ∨ Q) : Q ∨ P := by
  cases h with
  | inl hp =>
    right
    exact hp
  | inr hq =>
    left
    exact hq

-- EXERCISE 2: Prove that if P holds, then P ∨ Q holds.
theorem or_intro_left (hp : P) : P ∨ Q := by
  sorry


-- 3. Implication (→)
-- Implication behaves like a function. If we have `h : P → Q` and `hp : P`, we can apply `h` to `hp` to get `Q`.
-- To prove an implication `P → Q`, we use `intro h` to assume P.

theorem modus_ponens (hp : P) (h : P → Q) : Q := by
  apply h
  exact hp

-- EXERCISE 3: Prove that implication is transitive.
theorem impl_trans (h1 : P → Q) (h2 : Q → R) : P → R := by
  sorry

end Student
