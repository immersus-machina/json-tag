module SerializeSpec (spec) where

import Data.Aeson (encode)
import qualified Data.ByteString.Lazy.Char8 as LBS
import Test.Hspec
import TestTypes

-- Interop JSON — identical strings used across all 12 language libraries
circleJson, rectangleJson, carJson, truckJson :: String
circleJson = "{\"#type\":\"Circle\",\"radius\":4}"
rectangleJson = "{\"#type\":\"Rectangle\",\"width\":10,\"height\":5}"
carJson = "{\"#type\":\"Car\",\"make\":\"Toyota\"}"
truckJson = "{\"#type\":\"Truck\",\"payloadTons\":5}"

-- Aeson sorts fields alphabetically, so Rectangle comes out as height,width
aesonRectangleJson :: String
aesonRectangleJson = "{\"#type\":\"Rectangle\",\"height\":5,\"width\":10}"

spec :: Spec
spec = describe "serialize" $ do

  it "encode_whenSerializingCircle_matchesInteropFormat" $ do
    -- Act
    let json = LBS.unpack (encode (Circle { radius = 4.0 }))
    -- Assert
    json `shouldBe` circleJson

  it "encode_whenSerializingRectangle_matchesInteropFormat" $ do
    -- Act
    let json = LBS.unpack (encode (Rectangle { width = 10.0, height = 5.0 }))
    -- Assert
    json `shouldBe` aesonRectangleJson

  it "encode_whenSerializingCar_matchesInteropFormat" $ do
    -- Act
    let json = LBS.unpack (encode (PersonalVehicle { make = "Toyota" }))
    -- Assert
    json `shouldBe` carJson

  it "encode_whenSerializingTruck_matchesInteropFormat" $ do
    -- Act
    let json = LBS.unpack (encode (TransportationVehicle { payloadTons = 5.0 }))
    -- Assert
    json `shouldBe` truckJson
