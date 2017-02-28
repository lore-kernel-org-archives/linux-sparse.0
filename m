From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Sparse-LLVM issue compiling NULL pointers
Date: Tue, 28 Feb 2017 06:20:43 +0000
Message-ID: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38080 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdB1Gxm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 01:53:42 -0500
Received: by mail-it0-f48.google.com with SMTP id y135so3653522itc.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 22:53:35 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I am trying to debug a failure in sparse-llvm when compiling following:

struct mytype {
 int *foo;
};
extern void init_mytype(struct mytype *mt);
void init_mytype(struct mytype *mt) {
 mt->foo = (void *)0;
}

I am new to sparse so do not fully understand how it works, hence my
explanation below could be wrong.

As far as I understand, an integer constant 0 is converted to a value
pseudo in linearize_expression(). As a value pseudo only has a value
and no type the LLVM IR generator does not have enough information to
ensure that the correct type is used when it encounters the value
pseudo.

While trying to work out how to resolve this issue, I also found
following potential additional issues.

When handling (void*) 0, in the function evaluate_cast() in
evaluate.c, the expression type is changed to NULL type. However this
changed type is not returned.

 if (!(t1->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
     !as1 && (target->flags & Int_const_expr)) {
  if (t1->ctype.base_type == &C->S->void_ctype) {
   if (is_zero_constant(C, target)) {
    /* NULL */
    expr->type = EXPR_VALUE;
    expr->ctype = &C->S->null_ctype;
    expr->value = 0;
    return ctype;
   }
  }
 }

Should this be instead:

 if (!(t1->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
     !as1 && (target->flags & Int_const_expr)) {
  if (t1->ctype.base_type == &C->S->void_ctype) {
   if (is_zero_constant(C, target)) {
    /* NULL */
    expr->type = EXPR_VALUE;
    expr->ctype = &C->S->null_ctype;
    expr->value = 0;
    return expr->ctype;
   }
  }
 }

A related question is around the expansion of cast expressions in
cast_value() function in expand.c. The code snippet I was looking at
is this:

 if (old_size == new_size) {
  expr->value = old->value;
  return;
 }

Should this be changed to:

 if (old_size == new_size) {
  expr->value = old->value;
  expr->ctype = oldtype;
  return;
 }

The two changes above appear to help ensure that a VALUE expression's
type shows correctly that the expression is a NULL pointer. Assuming
this is correct then in value_pseudo() function in lineariez.c, it
would be possible to distinguish between integer constants and a NULL
pointer.

My question is this: should a value pseudo have type information also?
This seems like a necessity for LLVM backend.

Thanks and Regards
Dibyendu
