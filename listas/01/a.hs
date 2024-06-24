main = do
   x <- readLn
   y <- readLn
   print (expNE (x :: Float) (y :: Int))

expNE :: Float -> Int -> Float
expNE x 0 = 1
expNE x y = x * expNE x (y - 1)