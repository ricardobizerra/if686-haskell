main = do
  x <- getLine
  y <- getLine
  print $ findDifference (map (read :: String -> Int) (words x)) (map (read :: String -> Int) (words y))

findDifference :: [Int] -> [Int] -> Maybe String
findDifference x y
  | x == y = Nothing
  | length x /= length y = Just $ show (length x) ++ " /= " ++ show (length y)
  | otherwise = firstIndexDifference x y

firstIndexDifference :: [Int] -> [Int] -> Maybe String
firstIndexDifference x y = Just $ show (head [x !! i | i <- [0..(length x - 1)], x !! i /= y !! i]) ++ " /= " ++ show (head [y !! i | i <- [0..(length y - 1)], x !! i /= y !! i])