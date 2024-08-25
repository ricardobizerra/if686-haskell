main = interact $ show . potencia . (read :: String -> Lustre)

type Nome = String
type Potencia = Int
data Lampada = Compacta Nome Potencia | Incandescente Nome Potencia deriving (Read)

data Lustre = Pendente Lampada | Barra Lustre Lustre deriving (Read)

potencia :: Lustre -> Int
potencia (Pendente (Compacta _ power)) = power
potencia (Pendente (Incandescente _ power)) = power
potencia (Barra lustre1 lustre2) = potencia lustre1 + potencia lustre2