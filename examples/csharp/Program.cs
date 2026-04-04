using JsonTag;
using JsonTag.Example;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors();
builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.PropertyNamingPolicy = System.Text.Json.JsonNamingPolicy.CamelCase;
    options.SerializerOptions.AllowOutOfOrderMetadataProperties = true;
    options.SerializerOptions.TypeInfoResolver = new JsonTagResolver();
});

var app = builder.Build();
app.UseCors(policy => policy.AllowAnyOrigin());

app.MapGet("/shape", () => new
{
    Shape = ShapeService.GenerateRandomShape(),
    Sender = "C#",
});

Console.WriteLine("JSON# C# backend listening on port 57660");
app.Run("http://0.0.0.0:57660");
