module JsonTag.FSharp.Example.ShapeService

open System
open JsonTag.FSharp.Example

let private getRandomShapeEdge () =
    Random.Shared.Next(80, 121)

let generateRandomShape () =
    match Random.Shared.Next(3) with
    | 0 -> Circle(diameter = getRandomShapeEdge ())
    | 1 -> Rectangle(width = getRandomShapeEdge (), height = getRandomShapeEdge ())
    | _ -> Triangle(edgeA = getRandomShapeEdge (), edgeB = getRandomShapeEdge (), edgeC = getRandomShapeEdge ())
