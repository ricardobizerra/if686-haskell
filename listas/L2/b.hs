main = interact $ show . (read :: String -> Lampada)

type Nome = String
type Potencia = Int
data Lampada = Compacta Nome Potencia | Incandescente Nome Potencia deriving (Read)

instance Show Lampada where
  show (Compacta nome potencia) = "Compacta " ++ nome ++ " " ++ show potencia
  show (Incandescente nome potencia) = "Incandescente " ++ nome ++ " " ++ show potencia