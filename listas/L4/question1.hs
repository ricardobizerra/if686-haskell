-- Aluno: Ricardo Bizerra de Lima Filho

import Control.Concurrent
import Text.Printf

type ElementId = Int
data ElementType = Nut | Bolt deriving (Show)
data Element = Element ElementType ElementId deriving (Show)
data Box = Box Element Element deriving (Show)

main = do
  producedNutsQueue <- newMVar []
  producedBoltsQueue <- newMVar []

  boxes <- newMVar []
  
  controlMVar <- newMVar True

  forkIO $ producer producedNutsQueue controlMVar Nut 2000000 -- máquina de produção de porcas
  forkIO $ producer producedBoltsQueue controlMVar Bolt 1500000 -- máquina de produção de parafusos
  forkIO $ boxAssembler boxes producedNutsQueue producedBoltsQueue controlMVar 1200000 -- montador de pares de porcas e parafusos

producer :: MVar [Element] -> MVar Bool -> ElementType -> Int -> IO()
producer queue control producerType productionTime = loop 1
  where
    loop x = do
      threadDelay productionTime
      initialQueue <- takeMVar queue
      let newElement = Element producerType x
      putMVar queue (initialQueue ++ [newElement])
      ctrl <- takeMVar control
      printf "Produtor produziu %s %s\n" (show producerType) (show x)
      putMVar control ctrl
      loop (x + 1)

boxAssembler :: MVar [Box] -> MVar [Element] -> MVar [Element] -> MVar Bool -> Int -> IO()
boxAssembler boxes consumedNuts consumedBolts control assembleTime = loop 1
  where
    loop x = do
      threadDelay assembleTime
      nuts <- takeMVar consumedNuts
      bolts <- takeMVar consumedBolts
      if null nuts || null bolts then do
        ctrl <- takeMVar control
        printf "Montador esperando por, no mínimo, 1 porca e 1 parafuso\n"
        putMVar control ctrl
        putMVar consumedNuts nuts
        putMVar consumedBolts bolts
        loop x
      else do
        ctrl <- takeMVar control
        initialBoxes <- takeMVar boxes
        let (nut:nutsRest) = nuts
        let (bolt:boltsRest) = bolts
        let newBox = Box nut bolt
        putMVar boxes (initialBoxes ++ [newBox])
        printf "Montador montou %s\n" (show newBox)
        putMVar control ctrl
        putMVar consumedNuts nutsRest
        putMVar consumedBolts boltsRest
        loop (x + 1)