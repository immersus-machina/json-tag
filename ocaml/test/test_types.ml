type shape =
  | Circle of { radius : float }
  | Rectangle of { width : float; height : float }

type vehicle =
  | PersonalVehicle of { make : string }
  | TransportationVehicle of { payload_tons : float }

(* --- Encode --- *)

let encode_shape encode = function
  | Circle { radius } ->
    encode ~tag:"Circle" [ "radius", `Float radius ]
  | Rectangle { width; height } ->
    encode ~tag:"Rectangle" [ "width", `Float width; "height", `Float height ]

let encode_vehicle encode = function
  | PersonalVehicle { make } ->
    encode ~tag:"Car" [ "make", `String make ]
  | TransportationVehicle { payload_tons } ->
    encode ~tag:"Truck" [ "payloadTons", `Float payload_tons ]

(* --- Decode --- *)

let float_of_json_number = function
  | `Float value -> Ok value
  | `Int value -> Ok (Float.of_int value)
  | _ -> Error "expected a number"

let decode_shape decode json =
  match decode json with
  | Ok ("Circle", fields) ->
    (match List.assoc_opt "radius" fields with
     | Some number ->
       (match float_of_json_number number with
        | Ok radius -> Ok (Circle { radius })
        | Error message -> Error message)
     | None -> Error "missing field: radius")
  | Ok ("Rectangle", fields) ->
    let width_result =
      match List.assoc_opt "width" fields with
      | Some number -> float_of_json_number number
      | None -> Error "missing field: width"
    in
    let height_result =
      match List.assoc_opt "height" fields with
      | Some number -> float_of_json_number number
      | None -> Error "missing field: height"
    in
    (match width_result, height_result with
     | Ok width, Ok height -> Ok (Rectangle { width; height })
     | Error message, _ | _, Error message -> Error message)
  | Ok (unknown_tag, _) -> Error (Printf.sprintf "unknown shape type: %s" unknown_tag)
  | Error message -> Error message

let decode_vehicle decode json =
  match decode json with
  | Ok ("Car", fields) ->
    (match List.assoc_opt "make" fields with
     | Some (`String make) -> Ok (PersonalVehicle { make })
     | Some _ -> Error "expected string for make"
     | None -> Error "missing field: make")
  | Ok ("Truck", fields) ->
    (match List.assoc_opt "payloadTons" fields with
     | Some number ->
       (match float_of_json_number number with
        | Ok payload_tons -> Ok (TransportationVehicle { payload_tons })
        | Error message -> Error message)
     | None -> Error "missing field: payloadTons")
  | Ok (unknown_tag, _) -> Error (Printf.sprintf "unknown vehicle type: %s" unknown_tag)
  | Error message -> Error message
