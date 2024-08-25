main = interact $ show . primosN . (read :: String -> Int)

primos :: [Int] -> [Int]
primos [x] = [x]
primos (x:xs)
  | length [y | y <- xs, y `mod` x /= 0] /= length xs = primos xs
  | otherwise = x:xs

primosN :: Int -> [Int]
primosN n = primos [1..n]