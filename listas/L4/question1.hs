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

  consumedNutsQueue <- newMVar []
  consumedBoltsQueue <- newMVar []

  boxes <- newMVar []
  
  controlMVar <- newMVar True

  forkIO $ producer producedNutsQueue controlMVar Nut -- máquina de produção de porcas
  forkIO $ consumer producedNutsQueue consumedNutsQueue controlMVar Nut -- máquina de retirada de porcas

  forkIO $ producer producedBoltsQueue controlMVar Bolt -- máquina de produção de parafusos
  forkIO $ consumer producedBoltsQueue consumedBoltsQueue controlMVar Bolt -- máquina de retirada de parafusos

  forkIO $ boxAssembler boxes consumedNutsQueue consumedBoltsQueue controlMVar -- montador de pares de porcas e parafusos

producer :: MVar [Element] -> MVar Bool -> ElementType -> IO()
producer queue control producerType = loop 1
  where
    loop x = do
      threadDelay 1383333
      initialQueue <- takeMVar queue
      let newElement = Element producerType x
      putMVar queue (initialQueue ++ [newElement])
      ctrl <- takeMVar control
      printf "Produtor produziu %s %s\n" (show producerType) (show x)
      putMVar control ctrl
      loop (x + 1)

consumer :: MVar [Element] -> MVar [Element] -> MVar Bool -> ElementType -> IO()
consumer producedQueue consumedQueue control consumerType = loop
  where
    loop = do
      threadDelay 1000000
      produced <- takeMVar producedQueue
      if null produced then do
        ctrl <- takeMVar control
        printf "Consumidor esperando por %s\n" (show consumerType)
        putMVar control ctrl
        putMVar producedQueue produced
        loop
      else do
        ctrl <- takeMVar control
        consumed <- takeMVar consumedQueue
        let (producedHead:producedRest) = produced
        putMVar consumedQueue (consumed ++ [producedHead])
        printf "Consumidor consumiu %s %s\n" (show consumerType) (show (getElementId producedHead))
        putMVar producedQueue producedRest
        putMVar control ctrl
        loop

boxAssembler :: MVar [Box] -> MVar [Element] -> MVar [Element] -> MVar Bool -> IO()
boxAssembler boxes consumedNuts consumedBolts control = loop 1
  where
    loop x = do
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

-- funções auxiliares

getElementType :: Element -> ElementType
getElementType (Element elementType _) = elementType

getElementId :: Element -> ElementId
getElementId (Element _ id) = id