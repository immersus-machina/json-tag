open System.Text.Json
open Microsoft.AspNetCore.Builder
open Microsoft.Extensions.DependencyInjection
open JsonTag.FSharp
open JsonTag.FSharp.Example.ShapeService

let builder = WebApplication.CreateBuilder()

builder.Services.AddCors() |> ignore

builder.Services.ConfigureHttpJsonOptions(fun httpJsonOptions ->
    let jsonTagOptions = JsonTagOptions.Default
    httpJsonOptions.SerializerOptions.PropertyNamingPolicy <- jsonTagOptions.PropertyNamingPolicy
    httpJsonOptions.SerializerOptions.WriteIndented <- jsonTagOptions.WriteIndented
    httpJsonOptions.SerializerOptions.AllowOutOfOrderMetadataProperties <- jsonTagOptions.AllowOutOfOrderMetadataProperties
    for converter in jsonTagOptions.Converters do
        httpJsonOptions.SerializerOptions.Converters.Add(converter))
|> ignore

let app = builder.Build()

app.UseCors(fun policy -> policy.AllowAnyOrigin() |> ignore) |> ignore

app.MapGet("/shape", System.Func<_>(fun () ->
    {| shape = generateRandomShape (); sender = "F#" |}))
|> ignore

printfn "JSON# F# backend listening on port 57660"
app.Run("http://0.0.0.0:57660")
