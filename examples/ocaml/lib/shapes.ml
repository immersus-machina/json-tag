type shape =
  | Circle of { radius : int }
  | Rectangle of { width : int; height : int }
  | Triangle of { edge_a : int; edge_b : int; edge_c : int }

let get_random_shape_edge () =
  Random.int 41 + 80

let generate_random_shape () =
  let variant = Random.int 3 in
  match variant with
  | 0 -> Circle { radius = get_random_shape_edge () }
  | 1 -> Rectangle { width = get_random_shape_edge (); height = get_random_shape_edge () }
  | _ ->
    Triangle
      { edge_a = get_random_shape_edge ()
      ; edge_b = get_random_shape_edge ()
      ; edge_c = get_random_shape_edge ()
      }

let encode_shape shape =
  match shape with
  | Circle { radius } ->
    Json_tag.encode ~tag:"Circle" [ ("radius", `Int radius) ]
  | Rectangle { width; height } ->
    Json_tag.encode ~tag:"Rectangle" [ ("width", `Int width); ("height", `Int height) ]
  | Triangle { edge_a; edge_b; edge_c } ->
    Json_tag.encode ~tag:"Triangle"
      [ ("edgeA", `Int edge_a); ("edgeB", `Int edge_b); ("edgeC", `Int edge_c) ]
