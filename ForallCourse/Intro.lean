-- Introduction to Lean 4 syntax, types, and evaluation.
-- Lean is both a functional programming language and a theorem prover.

-- 1. Defining simple values and functions
def myNumber : Nat := 42

-- You can evaluate expressions using the `#eval` command.
#eval myNumber + 8

-- Functions are defined using parameters.
def addOne (x : Nat) : Nat := x + 1

#eval addOne 5

-- 2. Types are first-class in Lean
-- We can check the type of any expression using the `#check` command.
#check myNumber
#check addOne
#check "Hello, World!"

-- 3. Simple proofs of equalities
-- In Lean, proofs are written as terms of a specific proposition.
theorem one_plus_one_is_two : 1 + 1 = 2 := by
  rfl -- 'rfl' stands for reflexivity, which proves that identical expressions are equal by definition.
