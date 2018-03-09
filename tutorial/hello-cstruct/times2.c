/*
https://caml.inria.fr/pub/docs/manual-ocaml/intfc.html#sec448
https://mirage.io/blog/modular-foreign-function-bindings
https://lists.xenproject.org/archives/html/mirageos-devel/2016-01/msg00032.html

http://roscidus.com/blog/blog/2014/07/28/my-first-unikernel/#upload-speed-on-xen
*/

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/custom.h>

#ifdef FOR_UNIX
#include <stdio.h>
#endif

#ifndef FOR_UNIX
void __stack_chk_fail() {}
#endif

int times2_real(int aa)
{
#ifdef FOR_UNIX
    fprintf(stderr, "aa=%d\n", aa);
#endif
    return aa*2;
}

CAMLprim value times2(value aa)
{
    CAMLparam1(aa);
    //CAMLlocal1(ret)
    int bb = times2_real(Int_val(aa));
    CAMLreturn(Val_int(bb));
}
