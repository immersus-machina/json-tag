# json-tag

Haskell support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Configures [aeson](https://hackage.haskell.org/package/aeson) to use the JSON# convention.

## Install

```bash
cabal install json-tag
```

## Usage

Define your types with Generic and use `jsonTagOptions`:

```haskell
data Shape
  = Circle { radius :: Double }
  | Rectangle { width :: Double, height :: Double }
  deriving (Show, Eq, Generic)

instance ToJSON Shape where
  toJSON = genericToJSON jsonTagOptions

instance FromJSON Shape where
  parseJSON = genericParseJSON jsonTagOptions
```

```haskell
encode (Circle { radius = 4.0 })
-- {"#type":"Circle","radius":4}
```

Custom tag names via `jsonTagOptionsWith`:

```haskell
vehicleOptions :: Options
vehicleOptions = jsonTagOptionsWith tagName
  where
    tagName "PersonalVehicle" = "Car"
    tagName "TransportationVehicle" = "Truck"
    tagName name = name

instance ToJSON Vehicle where
  toJSON = genericToJSON vehicleOptions
```

## API

| Export | Description |
|---|---|
| `jsonTagOptions` | Aeson `Options` with `#type` as discriminator |
| `jsonTagOptionsWith` | Same, with custom constructor name mapping |
