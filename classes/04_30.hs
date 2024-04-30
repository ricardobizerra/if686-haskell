tailFat :: Integer -> Integer -> Integer
tailFat 0 x = x
tailFat n x = tailFat (n-1) (n * x)