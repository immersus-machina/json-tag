(* Interop JSON — identical strings used across all 12 language libraries *)
let circle_json = {|{"#type":"Circle","radius":4}|}
let rectangle_json = {|{"#type":"Rectangle","width":10,"height":5}|}
let car_json = {|{"#type":"Car","make":"Toyota"}|}
let truck_json = {|{"#type":"Truck","payloadTons":5}|}

let tests =
  [
    Alcotest.test_case
      "decode, when deserializing circle, resolves correct type" `Quick
      (fun () ->
        (* Act *)
        let result =
          Yojson.Safe.from_string circle_json
          |> Test_types.decode_shape Json_tag.decode
        in
        (* Assert *)
        match result with
        | Ok (Test_types.Circle { radius = 4.0 }) -> ()
        | _ -> Alcotest.fail "expected Circle with radius 4.0");
    Alcotest.test_case
      "decode, when deserializing rectangle, resolves correct type" `Quick
      (fun () ->
        (* Act *)
        let result =
          Yojson.Safe.from_string rectangle_json
          |> Test_types.decode_shape Json_tag.decode
        in
        (* Assert *)
        match result with
        | Ok (Test_types.Rectangle { width = 10.0; height = 5.0 }) -> ()
        | _ -> Alcotest.fail "expected Rectangle with width 10.0 and height 5.0");
    Alcotest.test_case
      "decode, when deserializing car, resolves correct type" `Quick
      (fun () ->
        (* Act *)
        let result =
          Yojson.Safe.from_string car_json
          |> Test_types.decode_vehicle Json_tag.decode
        in
        (* Assert *)
        match result with
        | Ok (Test_types.PersonalVehicle { make = "Toyota" }) -> ()
        | _ -> Alcotest.fail "expected PersonalVehicle with make Toyota");
    Alcotest.test_case
      "decode, when deserializing truck, resolves correct type" `Quick
      (fun () ->
        (* Act *)
        let result =
          Yojson.Safe.from_string truck_json
          |> Test_types.decode_vehicle Json_tag.decode
        in
        (* Assert *)
        match result with
        | Ok (Test_types.TransportationVehicle { payload_tons = 5.0 }) -> ()
        | _ -> Alcotest.fail "expected TransportationVehicle with payloadTons 5.0");
    Alcotest.test_case
      "decode, when hash type is not first property, still deserializes" `Quick
      (fun () ->
        (* Act *)
        let result =
          Yojson.Safe.from_string {|{"radius":4,"#type":"Circle"}|}
          |> Test_types.decode_shape Json_tag.decode
        in
        (* Assert *)
        match result with
        | Ok (Test_types.Circle { radius = 4.0 }) -> ()
        | _ -> Alcotest.fail "expected Circle with radius 4.0");
    Alcotest.test_case
      "decode, when missing hash type, returns error" `Quick
      (fun () ->
        (* Act *)
        let result =
          Yojson.Safe.from_string {|{"radius":4}|}
          |> Test_types.decode_shape Json_tag.decode
        in
        (* Assert *)
        match result with
        | Error _ -> ()
        | Ok _ -> Alcotest.fail "expected error for missing #type");
  ]
