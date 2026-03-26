namespace JsonTag.FSharp.Test

open System.Text.Json.Serialization

type Shape =
    | Circle of radius: float
    | Rectangle of width: float * height: float

type Vehicle =
    | [<JsonName("Car")>] PersonalVehicle of make: string
    | [<JsonName("Truck")>] TransportationVehicle of payloadTons: float

