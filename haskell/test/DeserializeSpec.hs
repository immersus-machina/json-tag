module DeserializeSpec (spec) where

import Data.Aeson (eitherDecode)
import Data.Either (isLeft)
import qualified Data.ByteString.Lazy.Char8 as LBS
import Test.Hspec
import TestTypes

-- Interop JSON — identical strings used across all 12 language libraries
circleJson, rectangleJson, carJson, truckJson :: String
circleJson = "{\"#type\":\"Circle\",\"radius\":4}"
rectangleJson = "{\"#type\":\"Rectangle\",\"width\":10,\"height\":5}"
carJson = "{\"#type\":\"Car\",\"make\":\"Toyota\"}"
truckJson = "{\"#type\":\"Truck\",\"payloadTons\":5}"

spec :: Spec
spec = describe "deserialize" $ do

  it "decode_whenDeserializingCircle_resolvesCorrectType" $ do
    -- Act
    let result = eitherDecode (LBS.pack circleJson) :: Either String Shape
    -- Assert
    result `shouldBe` Right (Circle { radius = 4.0 })

  it "decode_whenDeserializingRectangle_resolvesCorrectType" $ do
    -- Act
    let result = eitherDecode (LBS.pack rectangleJson) :: Either String Shape
    -- Assert
    result `shouldBe` Right (Rectangle { width = 10.0, height = 5.0 })

  it "decode_whenDeserializingCar_resolvesCorrectType" $ do
    -- Act
    let result = eitherDecode (LBS.pack carJson) :: Either String Vehicle
    -- Assert
    result `shouldBe` Right (PersonalVehicle { make = "Toyota" })

  it "decode_whenDeserializingTruck_resolvesCorrectType" $ do
    -- Act
    let result = eitherDecode (LBS.pack truckJson) :: Either String Vehicle
    -- Assert
    result `shouldBe` Right (TransportationVehicle { payloadTons = 5.0 })

  it "decode_whenHashTypeIsNotFirstProperty_stillDeserializes" $ do
    -- Act
    let result = eitherDecode (LBS.pack "{\"radius\":4,\"#type\":\"Circle\"}") :: Either String Shape
    -- Assert
    result `shouldBe` Right (Circle { radius = 4.0 })

  it "decode_whenUnknownTypeName_failsToDeserialize" $ do
    -- Act
    let result = eitherDecode (LBS.pack "{\"#type\":\"Hexagon\",\"sides\":6}") :: Either String Shape
    -- Assert
    result `shouldSatisfy` isLeft
