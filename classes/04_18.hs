-- funcao

-- identificador :: tipo
-- identificador = expressao

funcaoConstante :: Int -- comentar essa linha torna a tipagem funcaoConstante :: Integer
funcaoConstante = 32

maiorQue32 :: Bool -- mesmo comentando a linha acima, a tipagem continua sendo Bool
maiorQue32 = 34 > 32

incremento1 :: Int -> Int
incremento1 param = param + 1

exOr :: Bool -> Bool -> Bool
exOr a b = (a || b) && not (a && b)

mnot :: Bool -> Bool
mnot True = False
mnot False = True

exOr1 :: Bool -> Bool -> Bool
exOr1 True True = False
exOr1 True False = True
exOr1 False True = True
exOr1 False False = False

exOr2 :: Bool -> Bool -> Bool
exOr2 True x = not x
exOr2 False x = x

tresIguais :: Int -> Int -> Int -> Bool
tresIguais x y z = (x == y) && (y == z)