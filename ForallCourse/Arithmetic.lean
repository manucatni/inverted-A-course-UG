-- Natural Number Arithmetic and Induction in Lean 4
-- This module introduces mathematical induction over natural numbers (`Nat`).

namespace Student

-- 1. Induction Example: 0 + n = n
-- Since addition in Lean is defined by recursion on the second argument (n + 0 = n),
-- proving 0 + n = n requires induction.

theorem zero_add (n : Nat) : 0 + n = n := by
  induction n with
  | zero =>
    -- Base case: 0 + 0 = 0
    rfl
  | succ n ih =>
    -- Inductive step: Use Nat.add_succ to unfold the definition of addition,
    -- then rewrite using our induction hypothesis `ih`.
    rw [Nat.add_succ, ih]

-- EXERCISE 1: Prove that succ n + m = succ (n + m)
theorem succ_add (n m : Nat) : Nat.succ n + m = Nat.succ (n + m) := by
  induction m with
  | zero =>
    rfl
  | succ m ih =>
    rw [Nat.add_succ, ih, Nat.add_succ]

-- EXERCISE 2: Prove that addition is commutative.
-- (This is a harder proof! Hint: Use the theorems `zero_add` and `succ_add` that we proved above!)
theorem add_comm (n m : Nat) : n + m = m + n := by
  sorry

end Student
