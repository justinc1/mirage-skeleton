#!/bin/bash
echo 'FIX xen ....................'
export OPAM_DIR=$(opam config var prefix)
(cd _build/ && CFLAGS="-fno-stack-protector" ocamlc -c ../times2.c)

ld -d -static -nostdlib _build/main.native.o \
     -L$OPAM_DIR/lib/io-page-xen -lio_page_xen_stubs\
     -L$OPAM_DIR/lib\
     -L$OPAM_DIR/lib/pkgconfig/../../lib/minios-xen\
     $OPAM_DIR/lib/pkgconfig/../../lib/mirage-xen/libxencamlbindings.a\
     $OPAM_DIR/lib/pkgconfig/../../lib/mirage-xen-ocaml/libxenasmrun.a\
     $OPAM_DIR/lib/pkgconfig/../../lib/mirage-xen-ocaml/libxenotherlibs.a\
     $OPAM_DIR/lib/pkgconfig/../../lib/mirage-xen-posix/libxenposix.a\
     -lopenlibm -lminios\
     -T$OPAM_DIR/lib/pkgconfig/../../lib/minios-xen/libminios.lds\
 _build/times2.o \
     -m elf_x86_64 -lx86_64 -o hello_cstruct.xen1\

#
