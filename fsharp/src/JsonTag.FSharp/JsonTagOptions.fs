module JsonTag.FSharp.JsonTagOptions

open System.Text.Json
open System.Text.Json.Serialization // JsonFSharpOptions, JsonUnionEncoding from FSharp.SystemTextJson

/// Applies the JSON# convention to existing JsonFSharpOptions.
/// Sets unionTagName to "#type" and ensures InternalTag + NamedFields encoding.
/// All other settings from the source options are preserved.
let apply (source: JsonFSharpOptions) =
    JsonFSharpOptions(
        unionEncoding = (source.UnionEncoding ||| JsonUnionEncoding.InternalTag ||| JsonUnionEncoding.NamedFields),
        unionTagName = "#type",
        unionFieldsName = source.UnionFieldsName,
        unionTagNamingPolicy = source.UnionTagNamingPolicy,
        unionFieldNamingPolicy = source.UnionFieldNamingPolicy,
        unionTagCaseInsensitive = source.UnionTagCaseInsensitive,
        allowNullFields = source.AllowNullFields,
        includeRecordProperties = source.IncludeRecordProperties,
        types = source.Types,
        allowOverride = source.AllowOverride
    )

/// Pre-configured JsonSerializerOptions with #type as the discriminator,
/// camelCase property names, and compact output.
let Default =
    let fSharpOptions =
        JsonFSharpOptions(
            unionEncoding = (JsonUnionEncoding.InternalTag ||| JsonUnionEncoding.NamedFields ||| JsonUnionEncoding.UnwrapOption ||| JsonUnionEncoding.UnwrapSingleCaseUnions ||| JsonUnionEncoding.UnwrapFieldlessTags),
            unionTagName = "#type"
        )
    let options = JsonSerializerOptions(PropertyNamingPolicy = JsonNamingPolicy.CamelCase, WriteIndented = false, AllowOutOfOrderMetadataProperties = true)
    fSharpOptions.AddToJsonSerializerOptions(options)
    options
