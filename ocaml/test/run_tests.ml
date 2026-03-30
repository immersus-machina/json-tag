let () =
  Alcotest.run "json-tag"
    [
      ("serialize", Serialize_test.tests);
      ("deserialize", Deserialize_test.tests);
      ("json_tag", Json_tag_test.tests);
    ]
