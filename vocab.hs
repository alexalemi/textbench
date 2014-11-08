
module Main where

import qualified Data.Map.Strict as M
import qualified Data.ByteString.Lazy.Char8 as T
import System.Environment
import Control.Monad

wordcount :: T.ByteString -> M.Map T.ByteString Int
wordcount xs = M.fromListWith (+) $ zip (T.words xs) (repeat 1)

main :: IO ()
main = do
    args <- getArgs
    when (length args == 1) $ do
        content <- T.readFile $ head args
        print $ M.toDescList $ M.filter (\v -> v > 10) $ wordcount content
