From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect type when ealing with union type
Date: Mon, 13 Mar 2017 23:44:12 +0000
Message-ID: <CACXZuxeXy7nw8WCHfWnj72NaMxd8yn0vF4CL+EvfnJk5CNSd=g@mail.gmail.com>
References: <CACXZuxcb=27brA9N=w-tnZ9V0StKnDYZ4y27cS6eoenA7S0ctw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:38303 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbdCMXoO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 19:44:14 -0400
Received: by mail-it0-f47.google.com with SMTP id m27so41860502iti.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 16:44:13 -0700 (PDT)
In-Reply-To: <CACXZuxcb=27brA9N=w-tnZ9V0StKnDYZ4y27cS6eoenA7S0ctw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 13 March 2017 at 22:54, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I am investigating a type error in LLVM. Here is the snippet of code:
>
> typedef union GCObject GCObject;
> typedef unsigned char lu_byte;
> typedef double lua_Number;
> typedef union {
>  GCObject *gc;
>  void *p;
>  lua_Number n;
>  int b;
> } Value;
> typedef struct lua_TValue {
>  Value value;
>  int tt;
> } TValue;
> typedef struct UpVal {
>  GCObject *next;
>  lu_byte tt;
>  lu_byte marked;
>  TValue *v;
>  union {
>   TValue value;
>   struct {
>    struct UpVal *prev;
>    struct UpVal *next;
>   } l;
>  } u;
> } UpVal;
> static void close(UpVal *uv)
> {
>  uv->v = &uv->u.value;
> }
>
> The linearized output is:
>
> close:
> .L0:
>         <entry-point>
>         add.64      %r2 <- %arg1, $24
>         store.64    %r2 -> 16[%arg1]
>         ret
>
> The result of the add operation ends up the same type as arg1 which is
> UpVal*. But this is then assigned to uv->v which is expected to be
> TValue*. So LLVM doesn't like it.
>
> While in this case we could cast to the expected value before the
> store - I am worried that in other cases where the value is read and
> used somewhere it will have the wrong type.
>
> I see that the add instruction's type is 'void *'.
>
> Any suggestions on how to solve this issue?
>

For now I am casting the stored value in output_op_store():

 target_in = pseudo_to_value(C, fn, insn, insn->target);
 desttype = insn_symbol_type(C, fn->module, insn);

 /* Cast to the right type - to resolve issue with union types */
 target_in = LLVMBuildBitCast(fn->builder, target_in, desttype, "");
 /* perform store */
 LLVMBuildStore(fn->builder, target_in, addr);
