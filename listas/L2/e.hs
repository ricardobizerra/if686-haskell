unzip:: [(a,b)] -> ([a],[b])
unzip [] = ([],[])
unzip ((a, b): xs) = (a:as, b:bs)
 where
   (as, bs) = Main.unzip xs 

main = interact $ show . unzip' . (read :: String -> [(Int,Int)])

unzip' :: [(a,b)] -> ([a], [b])
unzip' = foldr separate ([], [])
  where separate (a, b) (as, bs) = (a:as,b:bs)