let tests =
  [
    Alcotest.test_case
      "tag_of, when present, returns tag" `Quick
      (fun () ->
        (* Act *)
        let result =
          Yojson.Safe.from_string {|{"#type":"Circle","radius":4}|}
          |> Json_tag.tag_of
        in
        (* Assert *)
        Alcotest.(check (option string)) "tag" (Some "Circle") result);
    Alcotest.test_case
      "tag_of, when missing, returns none" `Quick
      (fun () ->
        (* Act *)
        let result =
          Yojson.Safe.from_string {|{"radius":4}|}
          |> Json_tag.tag_of
        in
        (* Assert *)
        Alcotest.(check (option string)) "tag" None result);
  ]
