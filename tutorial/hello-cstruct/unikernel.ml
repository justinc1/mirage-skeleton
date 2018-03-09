open Lwt.Infix

external times2 : int -> int = "times2"
external read_int : int -> unit = "read_int"
external return_int : unit -> int = "return_int"

module Hello_cstruct (Time : Mirage_time_lwt.S) = struct

  let start _time =

    let oc = stderr in
        output_string oc "ttrt ";
        output_string oc (string_of_int 123);
        output_string oc "\n";

    let aa = 11 in
    (* let bb = (times2 aa) in *)
    let bb = (read_int aa; 33) in
    (* let bb = return_int() in *)
    let oc = stderr in
        output_string oc "bb = 2*aa = ";
        output_string oc (string_of_int bb);
        output_string oc " = 2*";
        output_string oc (string_of_int aa);
        output_string oc ";\n";

    let rec loop = function
      | 0 -> Lwt.return_unit
      | n ->
        Logs.info (fun f -> f "hello_cstruct");
        Time.sleep_ns (Duration.of_sec 1) >>= fun () ->
        loop (n-1)
    in
    loop 4

end
