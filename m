From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Fri, 3 Mar 2017 04:03:06 +0000
Message-ID: <CACXZuxcd6q6c5VzsYME01nzUhKzLjzvxTDt3juSbNB226APTTg@mail.gmail.com>
References: <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local> <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local> <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxdr9ubL6S8PEzAHtOt9AT=PjYcv_8EotLD8_Cagc7ZGPw@mail.gmail.com>
 <20170302171842.xuk535w6wrfxke3b@macpro.local> <20170302200916.4agmd5jihtkzyvp5@macpro.local>
 <CACXZuxfNkXS2qaLW+GoeOZ6TK57jJMzpRNdVCr418Bac-U7=MA@mail.gmail.com> <CACXZuxfSUVhOis7449hLZPrFvoTy_cV5UTJSS3VVtTGKDZy64Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:37940 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdCCEML (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 23:12:11 -0500
Received: by mail-it0-f53.google.com with SMTP id m27so6302451iti.1
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 20:10:22 -0800 (PST)
In-Reply-To: <CACXZuxfSUVhOis7449hLZPrFvoTy_cV5UTJSS3VVtTGKDZy64Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 3 March 2017 at 03:01, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> Next problem:
>>
>> The following fails.
>>
>> typedef unsigned long long size_t;
>> struct buffer_type_st {
>>  struct buffer_type_st    *next_buffer;
>>  char           *buffer;
>> };
>> typedef struct buffer_type_st buffer_type_t;
>> struct link_st {
>>  struct link_st           *next;
>> };
>> typedef struct link_st link_t;
>> struct allocator_st {
>>  buffer_type_t    *buffer_list;
>>  link_t           *free_list;
>>  char           *next_avail;
>>  char           *last;
>>  size_t          size;
>>  size_t          n;
>> };
>> typedef struct allocator_st allocator;
>> extern void *
>> alloc_node(allocator * a);
>> extern void
>> grow_allocator(allocator * a);
>> void *
>> alloc_node(allocator * a)
>> {
>>  link_t           *tmp;
>>  tmp = a->free_list;
>>  return (void *) tmp;
>> }
>>
>>
>> I get LLVM assertion failure for following instruction:
>>
>> insn cast.64     %r4 <- (64) %r2
>>
>> Assertion failed: isa<X>(Val) && "cast<Ty>() argument of incompatible
>> type!", file C:\d\llvm-3.9.0.src\include\llvm/Support/Casting.h, line
>> 237
>>
>> I think this is because the linearize is outputting an integer cast
>> rather than pointer cast so LLVM is not happy.
>>
>
> Simpler example:
>
> void *
> alloc_node(void)
> {
>  char *tmp;
>  tmp = (void *)0;
>  return tmp;
> }

I tried the following fix in sparse-llvm.c. It handles pointer casts
in output_op_cast. While this fixes the simpler example I get a
different error now on the larger sample.

static void output_op_cast(struct dmr_C *C, struct function *fn,
struct instruction *insn, LLVMOpcode op)
{
 LLVMValueRef src, target;
 char target_name[64];
 src = insn->src->priv;
 if (!src)
  src = pseudo_to_value(C, fn, insn, insn->src);
 pseudo_name(C, insn->target, target_name);
 assert(!symbol_is_fp_type(C, insn->type));
 if (LLVMGetTypeKind(LLVMTypeOf(src)) == LLVMPointerTypeKind) {
  target = LLVMBuildBitCast(fn->builder, src, insn_symbol_type(C,
fn->module, insn), target_name);
 }
 else {
  if (insn->size < LLVMGetIntTypeWidth(LLVMTypeOf(src)))
   target = LLVMBuildTrunc(fn->builder, src, insn_symbol_type(C,
fn->module, insn), target_name);
  else
   target = LLVMBuildCast(fn->builder, op, src, insn_symbol_type(C,
fn->module, insn), target_name);
 }
 insn->target->priv = target;
}
