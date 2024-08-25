parseInput :: Read a => String -> [a]
parseInput = map read . words
bigUncurry f [a, b, c, x] = f a b c x

maxFours m n p q = (maxFour m n p q, maxFour' m n p q, maxFour'' m n p q)

main :: IO()
main = interact $ show . bigUncurry maxFours . parseInput

maxThree :: Integer -> Integer -> Integer -> Integer
maxThree a b c
  | a >= b && a >= c = a 
  | b >= c = b
  | otherwise = c

maxFour :: Integer -> Integer -> Integer -> Integer -> Integer
maxFour a b c d = maxThree a b (maxThree b c d)

maxFour' :: Integer -> Integer -> Integer -> Integer -> Integer
maxFour' a b c d = max (max a b) (max c d)

maxFour'' :: Integer -> Integer -> Integer -> Integer -> Integer
maxFour'' a b c d = maxThree (max a b) c d