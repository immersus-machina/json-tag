{-# LANGUAGE DeriveGeneric #-}
module TestTypes where

import Data.Aeson (FromJSON(..), ToJSON(..), Options, genericToJSON, genericParseJSON)
import GHC.Generics (Generic)
import Data.JsonTag (jsonTagOptions, jsonTagOptionsWith)

data Shape
  = Circle { radius :: Double }
  | Rectangle { width :: Double, height :: Double }
  deriving (Show, Eq, Generic)

instance ToJSON Shape where
  toJSON = genericToJSON jsonTagOptions

instance FromJSON Shape where
  parseJSON = genericParseJSON jsonTagOptions

data Vehicle
  = PersonalVehicle { make :: String }
  | TransportationVehicle { payloadTons :: Double }
  deriving (Show, Eq, Generic)

vehicleTagName :: String -> String
vehicleTagName "PersonalVehicle" = "Car"
vehicleTagName "TransportationVehicle" = "Truck"
vehicleTagName name = name

vehicleOptions :: Options
vehicleOptions = jsonTagOptionsWith vehicleTagName

instance ToJSON Vehicle where
  toJSON = genericToJSON vehicleOptions

instance FromJSON Vehicle where
  parseJSON = genericParseJSON vehicleOptions
