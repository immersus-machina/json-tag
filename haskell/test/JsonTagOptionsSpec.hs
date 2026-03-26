module JsonTagOptionsSpec (spec) where

import Data.Aeson (sumEncoding, SumEncoding(..), constructorTagModifier)
import Test.Hspec
import Data.JsonTag (jsonTagOptions, jsonTagOptionsWith)

spec :: Spec
spec = describe "jsonTagOptions" $ do

  it "default_usesHashTypeAsTagFieldName" $ do
    -- Assert
    case sumEncoding jsonTagOptions of
      TaggedObject { tagFieldName = name } -> name `shouldBe` "#type"
      _ -> expectationFailure "expected TaggedObject encoding"

  it "default_preservesConstructorNames" $ do
    -- Assert
    constructorTagModifier jsonTagOptions "Circle" `shouldBe` "Circle"

  it "jsonTagOptionsWith_appliesCustomTagNameMapping" $ do
    -- Arrange
    let customOptions = jsonTagOptionsWith (\name -> if name == "Foo" then "Bar" else name)
    -- Assert
    constructorTagModifier customOptions "Foo" `shouldBe` "Bar"
    constructorTagModifier customOptions "Other" `shouldBe` "Other"

  it "jsonTagOptionsWith_preservesHashTypeAsTagFieldName" $ do
    -- Arrange
    let customOptions = jsonTagOptionsWith id
    -- Assert
    case sumEncoding customOptions of
      TaggedObject { tagFieldName = name } -> name `shouldBe` "#type"
      _ -> expectationFailure "expected TaggedObject encoding"
