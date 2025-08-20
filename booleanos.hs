-- Lambda calculus encoding of booleans in Haskell
-- Complete the missing definitions using only lambda functions
-- (no native Bool or Int)
module ChurchBool where
-- Church booleans
-- These encode boolean values as functions
true :: a -> a -> a
true = \x y -> x -- example: returns the first argument
false :: a -> a -> a
false = \x y -> y -- returns the second argument


-- ifThenElse using a Church boolean
-- It should return one of the two values depending on the boolean
ifThenElse :: (a -> a -> a) -> a -> a -> a
ifThenElse = \p x y -> p x y -- TODO: implement using only the boolean
-- Logical operations using Church booleans
-- All these should work like their logical counterparts
-- but only using functions


churchAnd :: (a -> a -> a) -> (a -> a -> a) -> a -> a -> a
-- churchAnd = \p q -> p q false (Initially, we tried to do this, which logic wise is correct, but there is type formatting issues)
churchAnd = \p q -> \x y -> p (q x y) y


churchOr :: (a -> a -> a) -> (a -> a -> a) -> a -> a -> a
--churchOr = \p q -> p true q (We tried this one, but it has type issues)
churchOr = \p q -> \x y -> p x (q x y) 


churchNot :: (a -> a -> a) -> a -> a -> a
--churchNot = \p -> p false true  (We tried this one, but it has type issues)
churchNot = \p x y -> p y x 


-- Converts a Church boolean to a string
-- This helps visualize the output
showBool :: (String -> String -> String) -> String
showBool b = b "True" "False"
-- Run tests
-- This should print out results using your definitions
test :: IO () 
test = do
    putStrLn $ "true AND false = " ++ showBool (churchAnd true false)
    putStrLn $ "true OR false = " ++ showBool (churchOr true false)
    putStrLn $ "NOT true = " ++ showBool (churchNot true)
    putStrLn $ "NOT false = " ++ showBool (churchNot false)
    putStrLn $ "ifThenElse true \"yes\" \"no\" = " ++ ifThenElse true "yes" "no"
    putStrLn $ "ifThenElse false \"yes\" \"no\" = " ++ ifThenElse false "yes" "no"