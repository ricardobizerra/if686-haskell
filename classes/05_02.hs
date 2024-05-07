-- Sinônimo de tipos
-- Palavra reservada: type

type Nome = String
type Idade = Int
type Pessoa = (Nome, Idade)

nome :: Pessoa -> Nome
nome (n, i) = n