namespace JsonTag.FSharp.Example

type Shape =
    | Circle of diameter: int
    | Rectangle of width: int * height: int
    | Triangle of edgeA: int * edgeB: int * edgeC: int
