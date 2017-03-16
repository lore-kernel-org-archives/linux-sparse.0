From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm functions must be cast to correct type before calling
Date: Thu, 16 Mar 2017 20:58:25 +0000
Message-ID: <CACXZuxcmizMoxj=xGAJYbbEbCHQC=4E7spC4MUqT1=0d+-NiAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37539 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdCPVF0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 17:05:26 -0400
Received: by mail-it0-f46.google.com with SMTP id g138so3538341itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 14:05:25 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

The following test (adapted from snippet posted by Linus) fails in sparse-llvm:

typedef unsigned int (*binop_t)(int, int);
typedef unsigned int (*unop_t)(int);
extern int printf(const char *, ...);
#define BINOP 0
#define UNOP 1
static unsigned int execute(int type, void *fn, int arg1, int arg2)
{
 if (type == BINOP)
  return ((binop_t)fn)(arg1,arg2);
 return ((unop_t)fn)(arg1);
}
static unsigned int unary(int arg1)
{
 return arg1+3;
}
int main(void)
{
 return execute(UNOP, unary, 3, 10) == 6 ? 0 : 1;
}

To resolve this before calling a function we need to cast it to the
expected type. This can be done like this in output_op_call():

 struct symbol *ftype = get_function_basetype(insn->fntype);

...

 LLVMTypeRef function_type = symbol_type(C, fn->module, ftype);
 LLVMTypeRef fptr_type = LLVMPointerType(function_type, 0);
 LLVMTypeRef bytep = LLVMPointerType(LLVMInt8Type(), 0);
 target = LLVMBuildBitCast(fn->builder, func, bytep, name);
 target = LLVMBuildBitCast(fn->builder, target, fptr_type, name);
 target = LLVMBuildCall(fn->builder, target, args, n_arg, name);
 insn->target->priv = target;


Thanks and Regards
Dibyendu
