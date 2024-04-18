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