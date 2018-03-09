open Mirage

let main =
  foreign
    ~packages:[package "duration"]
    "Unikernel.Hello_cstruct" (time @-> job)

let () =
  register "hello_cstruct" [main $ default_time]
