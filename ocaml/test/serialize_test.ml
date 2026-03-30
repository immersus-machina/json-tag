(* Interop JSON — identical strings used across all 12 language libraries *)
let circle_json = {|{"#type":"Circle","radius":4}|}
let rectangle_json = {|{"#type":"Rectangle","width":10,"height":5}|}
let car_json = {|{"#type":"Car","make":"Toyota"}|}
let truck_json = {|{"#type":"Truck","payloadTons":5}|}

(* Yojson emits .0 for float values *)
let yojson_circle_json = {|{"#type":"Circle","radius":4.0}|}
let yojson_rectangle_json = {|{"#type":"Rectangle","width":10.0,"height":5.0}|}
let yojson_truck_json = {|{"#type":"Truck","payloadTons":5.0}|}

let tests =
  [
    Alcotest.test_case
      "encode, when serializing circle, matches interop format" `Quick
      (fun () ->
        (* Act *)
        let json =
          Test_types.encode_shape Json_tag.encode (Test_types.Circle { radius = 4.0 })
          |> Yojson.Safe.to_string
        in
        (* Assert *)
        Alcotest.(check string) "circle json" yojson_circle_json json);
    Alcotest.test_case
      "encode, when serializing rectangle, matches interop format" `Quick
      (fun () ->
        (* Act *)
        let json =
          Test_types.encode_shape Json_tag.encode (Test_types.Rectangle { width = 10.0; height = 5.0 })
          |> Yojson.Safe.to_string
        in
        (* Assert *)
        Alcotest.(check string) "rectangle json" yojson_rectangle_json json);
    Alcotest.test_case
      "encode, when serializing car, matches interop format" `Quick
      (fun () ->
        (* Act *)
        let json =
          Test_types.encode_vehicle Json_tag.encode (Test_types.PersonalVehicle { make = "Toyota" })
          |> Yojson.Safe.to_string
        in
        (* Assert *)
        Alcotest.(check string) "car json" car_json json);
    Alcotest.test_case
      "encode, when serializing truck, matches interop format" `Quick
      (fun () ->
        (* Act *)
        let json =
          Test_types.encode_vehicle Json_tag.encode (Test_types.TransportationVehicle { payload_tons = 5.0 })
          |> Yojson.Safe.to_string
        in
        (* Assert *)
        Alcotest.(check string) "truck json" yojson_truck_json json);
  ]
