-- Aluno: Ricardo Bizerra de Lima Filho

import Control.Concurrent
import Control.Concurrent.STM

type Conta = TVar Int

saque :: Conta -> Int -> STM()
saque conta valor = do
  saldo <- readTVar conta
  writeTVar conta (saldo - valor)

deposito :: Conta -> Int -> STM()
deposito conta valor = saque conta (-valor)

saque2 :: Conta -> Int -> STM()
saque2 conta valor = do
  saldo <- readTVar conta
  if saldo >= valor
    then writeTVar conta (saldo - valor)
    else return ()

main = do
  conta <- atomically (newTVar 0)

  atomically $ deposito conta 100
  atomically $ saque conta 50
  atomically $ saque2 conta 70
  
  saldo <- atomically $ readTVar conta
  putStrLn (show saldo)