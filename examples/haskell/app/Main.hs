{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Control.Monad.IO.Class (liftIO)
import Data.Aeson (object, (.=))
import Shapes (generateRandomShape)
import Web.Scotty (scotty, get, json, setHeader)

main :: IO ()
main = do
  putStrLn "JSON# Haskell backend listening on port 57660"
  scotty 57660 $ do
    get "/shape" $ do
      setHeader "Access-Control-Allow-Origin" "*"
      shape <- liftIO generateRandomShape
      json $ object ["shape" .= shape, "sender" .= ("Haskell" :: String)]
