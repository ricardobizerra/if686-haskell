module Main where
import Control.Concurrent
import Control.Concurrent.MVar

threadA :: MVar Float -> MVar Float -> IO ()
threadA toSend toReceive
  = do --putStrLn "threadA execution"
       --threadDelay (1000)
       putMVar toSend 72 
       --putStrLn "threadA putMVar: escreveu 72 em toSend"
       v <- takeMVar toReceive
        --putStrLn "threadA takeMVar: impressão de valor"
        --threadDelay (1000)
       putStrLn (show v)

threadB :: MVar Float -> MVar Float -> IO ()
threadB toReceive toSend
  = do --putStrLn "threadB execution"
       --threadDelay (1000)
       z <- takeMVar toReceive
        --putStrLn "threadB takeMVar: leu valor de toReceive"
       putMVar toSend (1.2 * z)
       --threadDelay (1000)
       
main :: IO ()
main = do aMVar <- newEmptyMVar
          bMVar <- newEmptyMVar
          forkIO (threadA aMVar bMVar)
          --putStrLn "threadA forked"
          forkIO (threadB aMVar bMVar)
          --putStrLn "threadB forked"
          threadDelay 1000
          --return ()

-- COMPILE COMMAND
-- ghc classes/08_15.hs -o ex1
-- ./ex1

-- [STM] Leitura e escrita devem ocorrer na mesma transação. (Exemplo do contador)