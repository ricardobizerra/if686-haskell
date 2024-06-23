main = do
  a <- readLn
  b <- readLn
  print (numDiv (a :: Int) (b :: Int))

numDiv:: Integral a => a -> a -> a
numDiv a b
  | a `mod` b == 0 = 1 + numDiv (a `div` b) b
  | otherwise = 0