From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm the result of expression add assign when target is a
 pointer should be a pointer
Date: Sun, 5 Mar 2017 07:29:33 +0000
Message-ID: <CACXZuxe1xK9A7PKnHzYYTemKv5Jvf1Wiam5V77inn1ReLiSQSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36654 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdCEH3f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 02:29:35 -0500
Received: by mail-io0-f169.google.com with SMTP id l7so97104890ioe.3
        for <linux-sparse@vger.kernel.org>; Sat, 04 Mar 2017 23:29:34 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am starting a new thread on this issue. When processing following
simple example:

char *incr(char *p) {
 char *tmp = p;
 tmp += 5;
 return tmp;
}

The linearizer is taking the type of the expression 'tmp += 5' from
the src operand which is unsigned long, instead of taking the type
from the target operand which is char pointer. This results in
following sequence:

incr:
.L000001CB177AD5C8:
        <entry-point>
        ptrcast.64  %r3 <- (64) %arg1
        add.64      %r4 <- %r3, $5
        cast.64     %r5 <- (64) %r4
        ret.64      %r5

However if we make the change shown below then this output is produced
which is correct I believe as in add or sub operations, if either left
or right operand is a pointer and the other operand is an int then the
result should be a pointer.

incr:
.L000001633F0BEE58:
        <entry-point>
        ptrcast.64  %r3 <- (64) %arg1
        add.64      %r4 <- %r3, $5
        ptrcast.64  %r5 <- (64) %r4
        ret.64      %r5

The change required is in linearize_assignment() function. The
suggested version is shown below.


static pseudo_t linearize_assignment(struct entrypoint *ep, struct
expression *expr)
{
  ...
  int opcode;
  struct symbol *ctype = src->ctype;
  if (!src)
   return VOID_PSEUDO;
  oldvalue = cast_pseudo(ep, oldvalue, src->ctype, expr->ctype);
  opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], src->ctype);
  if (opcode == OP_ADD || opcode == OP_SUB) {
   if (is_ptr_type(target->ctype)) {
    ctype = target->ctype;
   }
  dst = add_binary_op(ep, ctype, opcode, oldvalue, value);
  value = cast_pseudo(ep, dst, expr->ctype, ctype);
  ...
}
