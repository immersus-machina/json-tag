let type_field = "#type"

let encode ~tag fields =
  `Assoc ((type_field, `String tag) :: fields)

let decode json =
  match json with
  | `Assoc fields ->
    let tag_value = List.assoc_opt type_field fields in
    let payload_fields = List.filter (fun (key, _) -> key <> type_field) fields in
    (match tag_value with
     | Some (`String tag_name) -> Ok (tag_name, payload_fields)
     | Some _ -> Error "\"#type\" must be a string"
     | None -> Error "missing \"#type\" field")
  | _ -> Error "expected a JSON object"

let tag_of json =
  match decode json with
  | Ok (tag_name, _) -> Some tag_name
  | Error _ -> None
