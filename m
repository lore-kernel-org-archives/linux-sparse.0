From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 16:39:38 +0000
Message-ID: <CACXZuxemR+d9J+PZN0wpUOSFS8eP+1QhzM=YiJQ13xV3hYKvJQ@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com> <20170302052124.fsqogvysufayy4to@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:36131 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbdCBQsm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 11:48:42 -0500
Received: by mail-it0-f53.google.com with SMTP id h10so121161149ith.1
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 08:48:41 -0800 (PST)
In-Reply-To: <20170302052124.fsqogvysufayy4to@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 2 March 2017 at 05:21, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Mar 01, 2017 at 02:45:03PM +0000, Dibyendu Majumdar wrote:
>> On 1 March 2017 at 10:58, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> > On 28 February 2017 at 17:03, Luc Van Oostenryck
>> > <luc.vanoostenryck@gmail.com> wrote:
>> >> On Tue, Feb 28, 2017 at 4:09 PM, Luc Van Oostenryck
>> >> <luc.vanoostenryck@gmail.com> wrote:
>> >>> There is indeed some problems regarding this, we looked a bit at this
>> >>> some weeks ago. However I firmly believe that the information about
>> >>> the type belong to the operations and not the values.
>> >>
>> >
>> > I am trying to work out how a value pseudo correct type can be
>> > determined when the pseudo is a function call argument. Would
>> > appreciate any pointers on this. The current implementation of
>> > pseudo_to_value() uses the function call instruction which is
>> > incorrect.
>> >
>>
>> I have implemented a solution that get the type information from the
>> function prototype for pseudo values when processing function
>> arguments, but not sure this is correct.
>
> You need something like:
> +struct symbol *argument_type(pseudo_t src)
> +{
> +       struct entrypoint *ep = src->def->bb->ep;
> +       struct symbol_list *args = ep->name->ctype.base_type->arguments;
> +       struct symbol *arg;
> +       int i = 0;
> +       FOR_EACH_PTR(args, arg) {
> +               if (++i == src->nr)
> +                       return arg;
> +       } END_FOR_EACH_PTR(arg);
> +
> +       assert(0);
> +}
>
>> Anyway have hit a bunch of other issues with sparse-llvm ... :-(
>
> Each day its problem (and happily its solution too!).
>

I am using the following fix. There is some noise below as this code
is from modified version.


static LLVMValueRef pseudo_val_to_value(struct dmr_C *C, struct
function *fn, LLVMTypeRef type, pseudo_t pseudo)
{
 assert(pseudo->type == PSEUDO_VAL);
 LLVMValueRef result = NULL;
 switch (LLVMGetTypeKind(type)) {
 case LLVMPointerTypeKind:
  if (pseudo->value == 0)
   result = LLVMConstPointerNull(type);
  else
   result = LLVMConstIntToPtr(
    LLVMConstInt(
     LLVMIntType(C->target->bits_in_pointer),
     pseudo->value, 1),
    type);
  break;
 case LLVMIntegerTypeKind:
  result = LLVMConstInt(type, pseudo->value, 1);
  break;
 default:
  assert(0);
 }
 // ORIGINAL result = LLVMConstInt(type, pseudo->value, 1);
 // PREVIOUS FIX result = LLVMConstInt(LLVMInt64Type(), pseudo->value, 1);
 return result;
}

static LLVMValueRef pseudo_to_value(struct dmr_C *C, struct function
*fn, struct instruction *insn, pseudo_t pseudo)
{
 ...
 case PSEUDO_VAL: {
  LLVMTypeRef type = insn_symbol_type(C, fn->module, insn);
  result = pseudo_val_to_value(C, fn, type, pseudo);
  break;
 }
 ...
}

static void output_op_call(struct dmr_C *C, struct function *fn,
struct instruction *insn)
{
 LLVMValueRef target, func;
 int n_arg = 0, i;
 struct pseudo *arg;
 LLVMValueRef *args;
 pseudo_t function_proto = insn->func;
 int n_proto_args = 0;
 struct symbol *proto_symbol = function_proto->sym->ctype.base_type;
 struct symbol *proto_arg;
 struct symbol **proto_args;
 /* count function prototype args, get prototype argument symbols */
 FOR_EACH_PTR(proto_symbol->arguments, proto_arg) {
  n_proto_args++;
 } END_FOR_EACH_PTR(proto_arg);
 proto_args = alloca(n_proto_args * sizeof(struct symbol *));
 int idx = 0;
 FOR_EACH_PTR(proto_symbol->arguments, proto_arg) {
  proto_args[idx++] = proto_arg->ctype.base_type;
 } END_FOR_EACH_PTR(proto_arg);
 n_arg = 0;
 FOR_EACH_PTR(insn->arguments, arg) {
  n_arg++;
 } END_FOR_EACH_PTR(arg);
 if (n_arg != n_proto_args) {
  fprintf(stderr, "Mismatch in function arguments\n");
  abort();
 }
 args = alloca(n_arg * sizeof(LLVMValueRef));
 i = 0;
 FOR_EACH_PTR(insn->arguments, arg) {
  if (arg->type == PSEUDO_VAL) {
   /* as value pseudo do not have type information we use the
      function prototype to decide types */
   LLVMTypeRef type = symbol_type(C, fn->module, proto_args[i]);
   args[i] = pseudo_val_to_value(C, fn, type, arg);
  }
  else {
   args[i] = pseudo_to_value(C, fn, insn, arg);
  }
  i++;
 } END_FOR_EACH_PTR(arg);
 func = pseudo_to_value(C, fn, insn, insn->func);
 target = LLVMBuildCall(fn->builder, func, args, n_arg, "");
 insn->target->priv = target;
}
