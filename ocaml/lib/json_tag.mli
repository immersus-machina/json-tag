(** JSON Tag — encode/decode helpers for the [#type] convention. *)

val type_field : string
(** The discriminator field name: ["#type"]. *)

val encode : tag:string -> (string * Yojson.Safe.t) list -> Yojson.Safe.t
(** [encode ~tag fields] creates a JSON object with ["#type"] set to [tag]. *)

val decode : Yojson.Safe.t -> (string * (string * Yojson.Safe.t) list, string) result
(** [decode json] extracts the ["#type"] tag and payload fields. *)

val tag_of : Yojson.Safe.t -> string option
(** [tag_of json] extracts just the ["#type"] value, or [None] if absent. *)
