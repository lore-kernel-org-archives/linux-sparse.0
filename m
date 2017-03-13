From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Mon, 13 Mar 2017 11:16:40 +0000
Message-ID: <CACXZuxeGTrPGUqsyXGR3t_kh3YHjejGC+MHTZNms8pTi4VPUSw@mail.gmail.com>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38269 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbdCMLQm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 07:16:42 -0400
Received: by mail-it0-f49.google.com with SMTP id m27so29038829iti.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 04:16:41 -0700 (PDT)
In-Reply-To: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 7 March 2017 at 00:08, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> int main(const char *argv[]) {
>  int values[5];
>  values[0] = 9;
>  values[1] = 8;
>  values[2] = 7;
>  values[3] = 6;
>  values[4] = 5;
>  int *p = &values[4];
>  return (*p == 5) ? 0 : 1;
> }
>

The latest version of the changes I made are given below. This appears
to help also with simple assignments, and fixes another issue I
reported when accessing the data from a string.

Changes to symbol:

I added a field in the symbol structure for the backend to save the
LLVM instruction that creates / allocates the symbol.

struct symbol {
 ...
 void *priv;
};

The remaining changes are in sparse-llvm.c. (Apologies for showing
extracts here from my modified codebase but this should translate
easily to sparse).

Firstly in pseudo_to_value() the changes are to do with handling of PSEUDO_SYM:

 case PSEUDO_SYM: {
  struct symbol *sym = pseudo->sym;
  struct expression *expr;
  result = (LLVMValueRef)sym->priv;
  if (result)
   return result;
  assert(sym->bb_target == NULL);
  expr = sym->initializer;
  if (expr) {
   switch (expr->type) {
   case EXPR_STRING: {
    const char *s = expr->string->data;
    LLVMValueRef indices[] = { LLVMConstInt(LLVMInt64Type(), 0, 0),
LLVMConstInt(LLVMInt64Type(), 0, 0) };
    LLVMValueRef data;
    data = LLVMAddGlobal(fn->module, LLVMArrayType(LLVMInt8Type(),
strlen(s) + 1), ".str");
    LLVMSetLinkage(data, LLVMPrivateLinkage);
    LLVMSetGlobalConstant(data, 1);
    char *scopy = allocator_allocate(&C->byte_allocator, strlen(s) + 1);
    strcpy(scopy, s);
    LLVMSetInitializer(data, LLVMConstString(scopy, strlen(scopy) + 1, true));
    result = LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
    sym->priv = result;
    break;
   }
   case EXPR_SYMBOL: {
    assert(0 && "unresolved symbol reference");
    struct symbol *sym = expr->symbol;
    result = LLVMGetNamedGlobal(fn->module, show_ident(C, sym->ident));
    assert(result != NULL);
    break;
   }
   case EXPR_VALUE:
    result = LLVMConstInt(symbol_type(C, fn->module, sym), expr->value, 1);
    sym->priv = result;
    break;
   case EXPR_FVALUE:
    result = LLVMConstReal(symbol_type(C, fn->module, sym), expr->fvalue);
    sym->priv = result;
    break;
   default:
    assert(0);
   }
  }
  else {
   const char *name = show_ident(C, sym->ident);
   LLVMTypeRef type = symbol_type(C, fn->module, sym);
   if (LLVMGetTypeKind(type) == LLVMFunctionTypeKind) {
    result = LLVMGetNamedFunction(fn->module, name);
    if (!result)
     result = LLVMAddFunction(fn->module, name, type);
    sym->priv = result;
   }
   else if (is_extern(sym) || is_toplevel(sym)) {
    result = LLVMGetNamedGlobal(fn->module, name);
    if (!result)
     result = LLVMAddGlobal(fn->module, type, name);
    sym->priv = result;
   }
   else {
    char localname[256] = { 0 };
    /* insert alloca into entry block */
    /* LLVM requires allocas to be at the start */
    LLVMBasicBlockRef entrybbr = LLVMGetEntryBasicBlock(fn->fn);
    /* Use temporary Builder as we don't want to mess the function builder */
    LLVMBuilderRef tmp_builder = LLVMCreateBuilder();
    LLVMValueRef firstins = LLVMGetFirstInstruction(entrybbr);
    if (firstins)
     LLVMPositionBuilderBefore(tmp_builder, firstins);
    else
     LLVMPositionBuilderAtEnd(tmp_builder, entrybbr);
    /* Since multiple locals may have same name but in different scopes we
       append the symbol's address to make each variable unique */
    snprintf(localname, sizeof localname, "%s_%p", name, sym);
    result = LLVMBuildAlloca(tmp_builder, type, localname);
    LLVMDisposeBuilder(tmp_builder);
    /* Store the alloca instruction for references to the value later on.
       TODO - should we convert this to pointer here? */
    sym->priv = result;
   }
  }
  break;
 }

Secondly in output_data() I added support for floating types and also
ensured that the sym->priv is set.

static LLVMValueRef output_data(struct dmr_C *C, LLVMModuleRef module,
struct symbol *sym)
{
 struct expression *initializer = sym->initializer;
 LLVMValueRef initial_value;
 LLVMValueRef data;
 const char *name;
 if (initializer) {
  switch (initializer->type) {
  case EXPR_VALUE:
   initial_value = LLVMConstInt(symbol_type(C, module, sym),
initializer->value, 1);
   break;
  case EXPR_FVALUE:
   initial_value = LLVMConstReal(symbol_type(C, module, sym),
initializer->fvalue);
   break;
  case EXPR_SYMBOL: {
   struct symbol *sym = initializer->symbol;
   initial_value = LLVMGetNamedGlobal(module, show_ident(C, sym->ident));
   if (!initial_value)
    initial_value = output_data(C, module, sym);
   break;
  }
  case EXPR_STRING: {
   const char *s = initializer->string->data;
   char *scopy = allocator_allocate(&C->byte_allocator, strlen(s) + 1);
   strcpy(scopy, s);
   initial_value = LLVMConstString(scopy, strlen(scopy) + 1, true);
   break;
  }
  default:
   assert(0);
  }
 } else {
  LLVMTypeRef type = symbol_type(C, module, sym);
  initial_value = LLVMConstNull(type);
 }
 name = show_ident(C, sym->ident);
 data = LLVMAddGlobal(module, LLVMTypeOf(initial_value), name);
 LLVMSetLinkage(data, data_linkage(C, sym));
 if (sym->ctype.modifiers & MOD_CONST)
  LLVMSetGlobalConstant(data, 1);
 if (sym->ctype.modifiers & MOD_TLS)
  LLVMSetThreadLocal(data, 1);
 if (sym->ctype.alignment)
  LLVMSetAlignment(data, sym->ctype.alignment);
 if (!(sym->ctype.modifiers & MOD_EXTERN))
  LLVMSetInitializer(data, initial_value);
 sym->priv = data;
 return data;
}
