#!/bin/bash
echo 'FIX....................'
cd _build/
CFLAGS="-DFOR_UNIX" ocamlc -c ../times2.c
ocamlfind ocamlopt -g -linkpkg -g -package mirage-unix -package mirage-types-lwt -package mirage-types -package mirage-runtime -package mirage-logs -package mirage-clock-unix -package lwt -package functoria-runtime -package duration -predicates mirage_unix key_gen.cmx unikernel.cmx main.cmx -o main.native   times2.o

