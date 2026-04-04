{-# LANGUAGE DeriveGeneric #-}
module Shapes
  ( Shape(..)
  , generateRandomShape
  , getRandomShapeEdge
  ) where

import Data.Aeson (ToJSON(..), genericToJSON)
import Data.JsonTag (jsonTagOptions)
import GHC.Generics (Generic)
import System.Random (randomRIO)

data Shape
  = Circle { diameter :: Int }
  | Rectangle { width :: Int, height :: Int }
  | Triangle { edgeA :: Int, edgeB :: Int, edgeC :: Int }
  deriving (Show, Generic)

instance ToJSON Shape where
  toJSON = genericToJSON jsonTagOptions

getRandomShapeEdge :: IO Int
getRandomShapeEdge = randomRIO (80, 120)

generateRandomShape :: IO Shape
generateRandomShape = do
  variant <- randomRIO (0 :: Int, 2)
  case variant of
    0 -> Circle <$> getRandomShapeEdge
    1 -> Rectangle <$> getRandomShapeEdge <*> getRandomShapeEdge
    _ -> Triangle <$> getRandomShapeEdge <*> getRandomShapeEdge <*> getRandomShapeEdge
