{-

        FirstScript.hs
        Simon Thompson, August 2010.

######################################################### -}

module FirstScript where

--      The value size is an integer (Integer), defined to be 
--      the sum of twelve and thirteen.

size :: Integer
size = 12+13

--      The function to square an integer.

square :: Integer -> Integer
square n = n*n

--      The function to double an integer.
        
double :: Integer -> Integer
double n = 2*n

--      An example using double, square and size.
         
example :: Integer
example = double (size - square (2+2))

-- a função deve dobrar o valor da entrada e calcular o quadrado deste

doubleAndSquare :: Integer -> Integer
doubleAndSquare n = (2*n) * (2*n)

-- a função deve calcular o quadrado do valor da entrada e dobrar esse valor

squareAndDouble :: Integer -> Integer
squareAndDouble n = 2 * (n*n)

-- 3.9 Define a function
-- threeDifferent :: Integer -> Integer -> Integer -> Bool
-- so that the result of threeDifferent m n p is True only if all three of the
-- numbers m, n and p are different.
-- What is your answer for threeDifferent 3 4 3? Explain why you get the
-- answer that you do.

threeDifferent :: Integer -> Integer -> Integer -> Bool
threeDifferent m n p = (m /= n) && (m /= p) && (n /= p)

-- ANSWER: It's false, because m and p are equal in this example.

-- 3.10 This question is about the function
-- fourEqual :: Integer -> Integer -> Integer -> Integer -> Bool
-- which returns the value True only if all four of its arguments are equal.
-- Give a definition of fourEqual modelled on the definition of threeEqual
-- above. Now give a definition of fourEqual which uses the function threeEqual
-- in its definition. Compare your two answers.

fourEqual :: Integer -> Integer -> Integer -> Integer -> Bool
fourEqual a b c d = (a == b) && (a == c) && (a == d) && (b == c) && (b == d) && (c == d)

-- 3.11 Give line-by-line calculations of
-- threeEqual (2+3) 5 (11 ‘div‘ 2)
-- mystery (2+4) 5 (11 ‘div‘ 2)
-- threeDifferent (2+4) 5 (11 ‘div‘ 2)
-- fourEqual (2+3) 5 (11 ‘div‘ 2) (21 ‘mod‘ 11)

-- 3.13 Give calculations of
-- max (3-2) (3*8)
-- maxThree (4+5) (2*6) (100 ‘div‘ 7)

-- 3.14 Give definitions of the functions
-- min :: Int -> Int -> Int
-- minThree :: Int -> Int -> Int -> Int
-- which calculate the minimum of two and three integers, respectively.

manualMin :: Int -> Int -> Int
manualMin a b = if a <= b then a else b

minThree :: Int -> Int -> Int -> Int
minThree a b c = if manualMin a b == a && manualMin a c == a then a else manualMin b c