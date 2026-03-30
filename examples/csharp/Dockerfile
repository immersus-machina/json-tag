FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY csharp/src/JsonTag/ /lib/JsonTag/
COPY examples/csharp/JsonTag.Example.csproj ./
COPY examples/csharp/*.cs ./
RUN sed -i 's|../../csharp/src/JsonTag/JsonTag.csproj|/lib/JsonTag/JsonTag.csproj|' JsonTag.Example.csproj
RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app .
EXPOSE 57660
ENTRYPOINT ["dotnet", "JsonTag.Example.dll"]
