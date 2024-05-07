addPairs2 :: [(Int, Int)] -> [Int]
addPairs2 l = [ x + y | (x,y) <- l, x < y]

todosPares :: [Int] -> Bool
todosPares l = l == [ x | x <- l, mod x 2 == 0]

comprimentoListaInt :: [Int] -> Int
comprimentoListaInt [] = 0
comprimentoListaInt (x: xs) = 1 + comprimentoListaInt xs