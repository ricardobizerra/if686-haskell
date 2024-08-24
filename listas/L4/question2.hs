-- Aluno: Ricardo Bizerra de Lima Filho

import Control.Concurrent
import Control.Concurrent.STM
import Text.Printf

type Conta = TVar Integer

saque :: Conta -> Integer -> STM()
saque conta valor = do
  saldo <- readTVar conta
  writeTVar conta (saldo - valor)

deposito :: Conta -> Integer -> STM()
deposito conta valor = saque conta (-valor)

saque2 :: Conta -> Integer -> STM()
saque2 conta valor = do
  saldo <- readTVar conta
  if saldo >= valor
    then writeTVar conta (saldo - valor)
    else return ()

main = do
  conta <- newTVarIO 100
  forkIO $ atomically $ deposito conta 100
  forkIO $ atomically $ saque conta 50
  forkIO $ atomically $ saque2 conta 70
  forkIO $ atomically $ saque2 conta 20