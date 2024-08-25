main = do
  a <- readLn
  b <- readLn
  print (mdc (a :: Int) (b :: Int))

mdc :: Int -> Int -> Int
mdc a b
  | b == 0 = a
  | otherwise = mdc b (a `mod` b)