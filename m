From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Thu, 9 Mar 2017 23:30:23 +0000
Message-ID: <CACXZuxfjjCZuq-zDNEgoJcVj6ERPKMqU+nPZjbBHD_Dk+pVBCQ@mail.gmail.com>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
 <20170307064436.qtcscbwbjsrjoyko@macpro.local> <CACXZuxcC-VPjB9CD0E9zUXp6XNS8v1DdvPUZ1vc88jqwYdFUhA@mail.gmail.com>
 <20170308065337.vwrebdlo4poc4da4@macpro.local> <CACXZuxcbDJAeRBN_wpTRPRk7efOM2vLytke=k_0f4=C0dOQtrA@mail.gmail.com>
 <CACXZuxeQO4p+J5MyggZhWJF9FfwnXHdG_wxx34jF3NFXqgd4Yg@mail.gmail.com> <20170309143513.pe7y5kuclabndyzu@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:35500 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdCIXa0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Mar 2017 18:30:26 -0500
Received: by mail-it0-f43.google.com with SMTP id m27so78824980iti.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Mar 2017 15:30:24 -0800 (PST)
In-Reply-To: <20170309143513.pe7y5kuclabndyzu@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 9 March 2017 at 14:35, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Mar 09, 2017 at 01:50:16AM +0000, Dibyendu Majumdar wrote:
>>
>> I think by combining the symbol's identifier and address a unique
>> reference can be created - thus whenever we encounter a symbol that is
>> not extern or toplevel we should create a local object using the
>> symbol's name + address as the LLVM identifier.
>
> That's more or less the idea, of course.
> And you need to consider all objects that you don't need to
> allocate because they are always in a (pseudo-) register.
>

This is my initial attempt at a fix. In the function pseudo_to_value()
I modified the handling of PSEUDO_SYM. Note that I needed to add a new
field 'priv' in the symbol structure (type void *) to hold the
allocated value - there is an 'aux' field already for the backend to
use but this is already used, so I wasn't sure whether there would be
a conflict if I tried to reuse that field.

 case PSEUDO_SYM: {
  struct symbol *sym = pseudo->sym;
  struct expression *expr;
  assert(sym->bb_target == NULL);
  expr = sym->initializer;
  if (expr) {
    ...
  } else {
   const char *name = show_ident(sym->ident);
   LLVMTypeRef type = symbol_type(fn->module, sym);
   if (LLVMGetTypeKind(type) == LLVMFunctionTypeKind) {
    result = LLVMGetNamedFunction(fn->module, name);
    if (!result)
     result = LLVMAddFunction(fn->module, name, type);
   } else {
    char localname[256] = { 0 };
    if (is_extern(sym) || is_toplevel(sym)) {
     result = LLVMGetNamedGlobal(fn->module, name);
     if (!result)
      result = LLVMAddGlobal(fn->module, type, name);
    }
    else {
     result = (LLVMValueRef)sym->priv;
     if (!result) {
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
   }
  }
  break;
 }

Of course I hit the next issue - which is that when calling functions,
array parameters need to degenerate to pointers - I haven't resolved
this yet. Perhaps, the cached value should be converted to a pointer
immediately so that any references see the pointer rather than the
array, or there needs to be a conversion when an array is passed to a
function.

Anyway to workaround this issue. I added a cast to the simple test program:

extern void init(int *v);
int main(const char *argv[]) {

 int n = 0;
 {
  int x[5];
  init((int *)x);
  n += x[0];
 }
 {
  int x[6];
  init((int *)x);
  n += x[0];
 }
 return n;
}

With that the LLVM IR I get looks like this:

define i32 @main(i8**) {
L0:
  %x_0000020C5D05B2E8 = alloca [6 x i32]
  %x_0000020C5D05AF68 = alloca [5 x i32]
  %R2 = bitcast [5 x i32]* %x_0000020C5D05AF68 to i32*
  call void @init(i32* %R2)
  %1 = bitcast [5 x i32]* %x_0000020C5D05AF68 to i32*
  %2 = bitcast i32* %1 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 0
  %4 = bitcast i8* %3 to i32*
  %load_target = load i32, i32* %4
  %R9 = bitcast [6 x i32]* %x_0000020C5D05B2E8 to i32*
  call void @init(i32* %R9)
  %5 = bitcast [6 x i32]* %x_0000020C5D05B2E8 to i32*
  %6 = bitcast i32* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 0
  %8 = bitcast i8* %7 to i32*
  %load_target1 = load i32, i32* %8
  %R13 = add i32 %load_target, %load_target1
  ret i32 %R13
}
declare void @init(i32*)
