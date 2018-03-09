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

void read_int_real(int aa)
{
#ifdef FOR_UNIX
    fprintf(stderr, "aa=%d\n", aa);
#endif
    asm(""); // will prevent optimization?
    aa =  aa*2;
}

CAMLprim value read_int(value aa)
{
    CAMLparam1(aa);
    read_int_real(Int_val(aa));
    CAMLreturn(Val_unit);
}

int return_int_real()
{
    int bb = 44;
    return bb;
}

/* return_int() version 1 */
CAMLprim value return_int(value unit) /* works in xen */
{
    CAMLparam0(); // to get caml__frame declared
    int bb = return_int_real();
    CAMLreturn(Val_int(bb));
}

/* return_int() version 2 */
CAMLprim value return_int_v2(value unit) /* works in xen */
{
    int bb = return_int_real();
    return Val_int(bb);
}
