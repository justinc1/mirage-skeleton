#!/bin/bash
echo 'FIX xen ....................'
(cd _build/ && CFLAGS="-fno-stack-protector" ocamlc -c ../times2.c)

ld -d -static -nostdlib _build/main.native.o \
     -L/home/xlab/.opam/4.05.0/lib/io-page-xen -lio_page_xen_stubs\
     -L/home/xlab/.opam/4.05.0/lib\
     -L/home/xlab/.opam/4.05.0/lib/pkgconfig/../../lib/minios-xen\
     /home/xlab/.opam/4.05.0/lib/pkgconfig/../../lib/mirage-xen/libxencamlbindings.a\
     /home/xlab/.opam/4.05.0/lib/pkgconfig/../../lib/mirage-xen-ocaml/libxenasmrun.a\
     /home/xlab/.opam/4.05.0/lib/pkgconfig/../../lib/mirage-xen-ocaml/libxenotherlibs.a\
     /home/xlab/.opam/4.05.0/lib/pkgconfig/../../lib/mirage-xen-posix/libxenposix.a\
     -lopenlibm -lminios\
     -T/home/xlab/.opam/4.05.0/lib/pkgconfig/../../lib/minios-xen/libminios.lds\
 _build/times2.o \
     -m elf_x86_64 -lx86_64 -o hello_cstruct.xen1\

#
