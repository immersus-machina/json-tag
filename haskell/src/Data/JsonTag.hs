-- | JSON Tag — aeson Options for the @#type@ convention.
module Data.JsonTag
  ( jsonTagOptions
  , jsonTagOptionsWith
  ) where

import Data.Aeson (Options, SumEncoding(..), defaultOptions, sumEncoding,
                   constructorTagModifier, fieldLabelModifier)

-- | Aeson 'Options' that use @#type@ as the discriminator field.
--
-- Constructors are emitted in PascalCase (their Haskell names).
-- Fields are emitted as-is (assumed camelCase in the Haskell source).
--
-- @
-- instance ToJSON Shape where
--   toJSON = genericToJSON jsonTagOptions
-- instance FromJSON Shape where
--   parseJSON = genericParseJSON jsonTagOptions
-- @
jsonTagOptions :: Options
jsonTagOptions = defaultOptions
  { sumEncoding = TaggedObject
      { tagFieldName = "#type"
      , contentsFieldName = "contents"
      }
  , constructorTagModifier = id
  , fieldLabelModifier = id
  }

-- | Like 'jsonTagOptions', but with a custom constructor-to-tag-name mapping.
--
-- @
-- vehicleOptions :: Options
-- vehicleOptions = jsonTagOptionsWith tagName
--   where
--     tagName \"PersonalVehicle\" = \"Car\"
--     tagName \"TransportationVehicle\" = \"Truck\"
--     tagName name = name
-- @
jsonTagOptionsWith :: (String -> String) -> Options
jsonTagOptionsWith tagNameModifier = jsonTagOptions
  { constructorTagModifier = tagNameModifier
  }
