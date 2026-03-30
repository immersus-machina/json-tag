FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY fsharp/src/JsonTag.FSharp/ /lib/JsonTag.FSharp/
COPY examples/fsharp/JsonTag.FSharp.Example.fsproj ./
COPY examples/fsharp/*.fs ./
RUN sed -i 's|../../fsharp/src/JsonTag.FSharp/JsonTag.FSharp.fsproj|/lib/JsonTag.FSharp/JsonTag.FSharp.fsproj|' JsonTag.FSharp.Example.fsproj
RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app .
EXPOSE 57660
ENTRYPOINT ["dotnet", "JsonTag.FSharp.Example.dll"]
