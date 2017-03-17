From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Fri, 17 Mar 2017 10:48:18 +0000
Message-ID: <CACXZuxfx_s4bhStgFP9d-jWCEJDLhYmJADOGbi-A2A7_KE_jeQ@mail.gmail.com>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
 <CACXZuxeGTrPGUqsyXGR3t_kh3YHjejGC+MHTZNms8pTi4VPUSw@mail.gmail.com> <CACXZuxfJ0sTgU32u=7ks-bAy5hEHsFRqOSG3DedgJ7DH2RLBfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:36509 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdCQKsU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Mar 2017 06:48:20 -0400
Received: by mail-it0-f43.google.com with SMTP id w124so18594247itb.1
        for <linux-sparse@vger.kernel.org>; Fri, 17 Mar 2017 03:48:19 -0700 (PDT)
In-Reply-To: <CACXZuxfJ0sTgU32u=7ks-bAy5hEHsFRqOSG3DedgJ7DH2RLBfw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

Hi

I found additional issues with the handling of variables, in
particular if a variable is declared static inside a function.
Following is an updated set of changes that improve the situation.
These are against my modified code base but should translate easily to
sparse-llvm.

static LLVMValueRef build_local(struct dmr_C *C, struct function *fn,
struct symbol *sym)
{
 const char *name = show_ident(C, sym->ident);
 LLVMTypeRef type = symbol_type(C, fn->module, sym);
 LLVMValueRef result;
 char localname[256] = { 0 };
 snprintf(localname, sizeof localname, "%s_%p", name, sym);
 if (is_static(sym) || is_extern(sym) || is_toplevel(sym)) {
  result = LLVMGetNamedGlobal(fn->module, localname);
  if (!result) {
   result = LLVMAddGlobal(fn->module, type, localname);
   if (!is_extern(sym))
    LLVMSetLinkage(result, LLVMInternalLinkage);
   else
    LLVMSetLinkage(result, LLVMExternalLinkage);
  }
 }
 else {
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
  result = LLVMBuildAlloca(tmp_builder, type, localname);
  LLVMDisposeBuilder(tmp_builder);
 }
 sym->priv = result;
 return result;
}

static LLVMValueRef pseudo_to_value(struct dmr_C *C, struct function
*fn, struct instruction *insn, pseudo_t pseudo)
{
 LLVMValueRef result = NULL;
...
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
    expression_error(C, expr, "unresolved symbol reference in initializer\n");
    show_expression(C, expr);
    exit(1);
    break;
   }
   case EXPR_VALUE:
    result = build_local(C, fn, sym);
    if (is_static(sym))
     LLVMSetInitializer(result, LLVMConstInt(symbol_type(C,
fn->module, sym), expr->value, 1));
    else
     LLVMBuildStore(fn->builder, LLVMConstInt(symbol_type(C,
fn->module, sym), expr->value, 1), result);
    sym->priv = result;
    break;
   case EXPR_FVALUE:
    result = build_local(C, fn, sym);
    if (is_static(sym))
     LLVMSetInitializer(result, LLVMConstReal(symbol_type(C,
fn->module, sym), expr->fvalue));
    else
     LLVMBuildStore(fn->builder, LLVMConstReal(symbol_type(C,
fn->module, sym), expr->fvalue), result);
    sym->priv = result;
    break;
   default:
    expression_error(C, expr, "unsupported expr type in initializer:
%d\n", expr->type);
    show_expression(C, expr);
    exit(1);
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
    if (!result) {
     result = LLVMAddGlobal(fn->module, type, name);
     if (is_extern(sym))
      LLVMSetLinkage(result, LLVMExternalLinkage);
    }
    sym->priv = result;
   }
   else {
    result = build_local(C, fn, sym);
    if (is_static(sym)) {
     LLVMSetInitializer(result, LLVMConstNull(type));
    }
    sym->priv = result;
   }
  }
  break;
 }
 case PSEUDO_VAL: {
...
 return result;
}

static LLVMValueRef output_data(struct dmr_C *C, LLVMModuleRef module,
struct symbol *sym)
{
 struct expression *initializer = sym->initializer;
 LLVMValueRef initial_value = NULL;
 LLVMValueRef data = NULL;
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
   if (sym->ident)
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
   expression_error(C, initializer, "unsupported expr type in global
data initializer: %d\n", initializer->type);
   show_expression(C, initializer);
  }
  if (!initial_value)
   return NULL;
 } else {
  LLVMTypeRef type = symbol_type(C, module, sym);
  initial_value = LLVMConstNull(type);
 }
 name = show_ident(C, sym->ident);
 if (!sym->priv) {
  if (sym->ident)
   data = LLVMGetNamedGlobal(module, name);
  if (!data)
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
 }
 else {
  data = sym->priv;
  if (!(sym->ctype.modifiers & MOD_EXTERN))
   LLVMSetInitializer(data, initial_value);
 }
 return data;
}
