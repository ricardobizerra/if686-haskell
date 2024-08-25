main = do
  x <- getLine
  y <- getLine
  print $ merge (map (read :: String -> Int) (words x)) (map (read :: String -> Int) (words y))

merge :: Ord a => [a] -> [a] -> [a]
merge a b = mergesort (a ++ b)

mergesort :: Ord a => [a] -> [a]
mergesort [a] = [a]
mergesort a = mesclar (mergesort (take (div (length a) 2) a)) (mergesort (drop (div (length a) 2) a))

mesclar :: Ord a => [a] -> [a] -> [a]
mesclar [] bs = bs
mesclar as [] = as
mesclar (a:as) (b:bs)
  | a < b = a : mesclar as (b:bs)
  | otherwise = b : mesclar (a:as) bs