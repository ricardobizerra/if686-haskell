main = interact $ show . perfeitos . read

perfeitos :: Integer -> [Integer]
perfeitos n = sort ([x | x <- [1..n], (sum . fatoresQuadrado . fatores) x == x] ++ [1])

primos :: Integer -> [Integer]
primos n = crivo [2..n]
  where
    crivo [] = []
    crivo (x:xs) = x : crivo [y | y <- xs, y `mod` x /= 0]

fatores :: Integer -> [Integer]
fatores n = [x | x <- primos n, n `mod` x == 0]

fatoresQuadrado :: [Integer] -> [Integer]
fatoresQuadrado = map (^2)

sort :: [Integer] -> [Integer]
sort [] = []
sort (x:xs) = 
  let maiores = sort [a | a <- xs, a >= x]
      menores = sort [a | a <- xs, a < x]
  in maiores ++ [x] ++ menores
