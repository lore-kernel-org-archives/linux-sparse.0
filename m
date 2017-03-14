From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm functions are defined with a different name due to
 multiple attempts to add same function
Date: Tue, 14 Mar 2017 13:11:17 +0000
Message-ID: <CACXZuxcD+AW_hihy=CMZps24pUYZ1LdCpH6SW=njuXNjA=YwGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:34717 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdCNNLT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 09:11:19 -0400
Received: by mail-io0-f169.google.com with SMTP id b140so9851611iof.1
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 06:11:18 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Sparse-llvm appears to ignore prototypes, and declares a function when
first seen as a pseudo. However by doing this, when the function
definition is actually encountered in the code, it declares a few
function - and LLVM gives it a new name. Thus the original function is
not defined at all.

To resolve this, firstly we should not ignore prototypes.
Secondly when defining a function we should check if the function is
already declared.
Thirdly - the definition of functions from pseudos is probably no
longer necessary if we insist on seeing function prototype or
definition prior to use.

I added following function in sparse-llvm:

static void output_prototype(struct dmr_C *C, LLVMModuleRef module,
struct symbol *sym)
{
 const char *name = show_ident(C, sym->ident);
 struct symbol *base_type = sym;
 if (sym->type == SYM_NODE)
  base_type = sym->ctype.base_type;
 LLVMTypeRef ftype = sym_func_type(C, module, base_type);
 LLVMValueRef result = LLVMGetNamedFunction(module, name);
 if (!result) {
  result = LLVMAddFunction(module, name, ftype);
  LLVMSetLinkage(result, function_linkage(C, sym));
 }
 sym->priv = result;
}

I changed compile() to call above.

  if (is_prototype(sym)) {
   output_prototype(C, module, sym);
   continue;
  }

I also changed output_fn to first check if the function has already
been declared:

 function.fn = LLVMGetNamedFunction(module, name);
 if (!function.fn) {
  function.type = LLVMFunctionType(return_type, arg_types, nr_args,
base_type->variadic);
  function.fn = LLVMAddFunction(module, name, function.type);
  LLVMSetLinkage(function.fn, function_linkage(C, sym));
  sym->priv = function.fn;
 }
 else {
  function.type = LLVMTypeOf(function.fn);
 }

Thanks and Regards
Dibyendu
