let () =
  Random.self_init ();
  print_endline "JSON# OCaml backend listening on port 57660";
  Dream.run ~port:57660 ~interface:"0.0.0.0"
  @@ Dream.logger
  @@ Dream.router
       [ Dream.get "/shape" (fun _request ->
           let shape = Shapes.generate_random_shape () in
           let response_json =
             `Assoc
               [ ("shape", Shapes.encode_shape shape)
               ; ("sender", `String "OCaml")
               ]
           in
           let body = Yojson.Basic.to_string response_json in
           Dream.respond body
             ~headers:[ ("Content-Type", "application/json")
                      ; ("Access-Control-Allow-Origin", "*")
                      ])
       ]
