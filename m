From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect type when ealing with union type
Date: Tue, 14 Mar 2017 01:29:27 +0000
Message-ID: <CACXZuxe-JOU4_7wOxkmwe3ksQyOtKLop7_F8vEudjP0f7YBzRA@mail.gmail.com>
References: <CACXZuxcb=27brA9N=w-tnZ9V0StKnDYZ4y27cS6eoenA7S0ctw@mail.gmail.com>
 <CACXZuxeXy7nw8WCHfWnj72NaMxd8yn0vF4CL+EvfnJk5CNSd=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34440 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbdCNB33 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 21:29:29 -0400
Received: by mail-io0-f182.google.com with SMTP id b140so1654087iof.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 18:29:29 -0700 (PDT)
In-Reply-To: <CACXZuxeXy7nw8WCHfWnj72NaMxd8yn0vF4CL+EvfnJk5CNSd=g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 13 March 2017 at 23:44, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> I am investigating a type error in LLVM. Here is the snippet of code:
>>
>> typedef union GCObject GCObject;
>> typedef unsigned char lu_byte;
>> typedef double lua_Number;
>> typedef union {
>>  GCObject *gc;
>>  void *p;
>>  lua_Number n;
>>  int b;
>> } Value;
>> typedef struct lua_TValue {
>>  Value value;
>>  int tt;
>> } TValue;
>> typedef struct UpVal {
>>  GCObject *next;
>>  lu_byte tt;
>>  lu_byte marked;
>>  TValue *v;
>>  union {
>>   TValue value;
>>   struct {
>>    struct UpVal *prev;
>>    struct UpVal *next;
>>   } l;
>>  } u;
>> } UpVal;
>> static void close(UpVal *uv)
>> {
>>  uv->v = &uv->u.value;
>> }
>>
>> The linearized output is:
>>
>> close:
>> .L0:
>>         <entry-point>
>>         add.64      %r2 <- %arg1, $24
>>         store.64    %r2 -> 16[%arg1]
>>         ret
>>
>> The result of the add operation ends up the same type as arg1 which is
>> UpVal*. But this is then assigned to uv->v which is expected to be
>> TValue*. So LLVM doesn't like it.
>>
>> While in this case we could cast to the expected value before the
>> store - I am worried that in other cases where the value is read and
>> used somewhere it will have the wrong type.
>>
>> I see that the add instruction's type is 'void *'.
>>
>> Any suggestions on how to solve this issue?
>>
>
> For now I am casting the stored value in output_op_store():
>
>  target_in = pseudo_to_value(C, fn, insn, insn->target);
>  desttype = insn_symbol_type(C, fn->module, insn);
>
>  /* Cast to the right type - to resolve issue with union types */
>  target_in = LLVMBuildBitCast(fn->builder, target_in, desttype, "");
>  /* perform store */
>  LLVMBuildStore(fn->builder, target_in, addr);

Additionally also casting the stores to phi instructions.

Regards
