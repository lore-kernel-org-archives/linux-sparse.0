From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 14:16:59 +0000
Message-ID: <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
 <20170311114903.zrhufw6ydneky3ya@macbook.local> <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local> <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
 <20170311141201.kptzqgn4qpu3gaic@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35802 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755660AbdCKORB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 09:17:01 -0500
Received: by mail-io0-f179.google.com with SMTP id z13so63699496iof.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 06:17:00 -0800 (PST)
In-Reply-To: <20170311141201.kptzqgn4qpu3gaic@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On 11 March 2017 at 14:12, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Mar 11, 2017 at 01:36:30PM +0000, Dibyendu Majumdar wrote:
>> > Here you're hitting the OP_SET{EQ,...} case.
>> >
>>
>> Here is my attempt to fix:
>>
>> static struct symbol *pseudo_get_type(pseudo_t pseudo) {
>>  switch (pseudo->type) {
>>  case PSEUDO_SYM:
>>  case PSEUDO_ARG:
>>   return pseudo->sym;
>>  case PSEUDO_PHI:
>>  case PSEUDO_REG:
>>   return pseudo->def->type;
>>  default:
>>   assert(0);
>>   return NULL;
>>  }
>> }
>> static void output_op_compare(struct function *fn, struct instruction *insn)
>> {
>>  LLVMValueRef lhs, rhs, target;
>>  char target_name[64];
>>  if (insn->src1->type == PSEUDO_VAL)
>>   lhs = val_to_value(fn, insn->src1->value, pseudo_get_type(insn->src2));
>>  else
>>   lhs = pseudo_to_value(fn, insn, insn->src1);
>>  if (insn->src2->type == PSEUDO_VAL)
>>   //rhs = LLVMConstInt(LLVMTypeOf(lhs), insn->src2->value, 1);
>>   rhs = val_to_value(fn, insn->src2->value, pseudo_get_type(insn->src1));
>>  else
>>   rhs = pseudo_to_value(fn, insn, insn->src2);
>>
>>
>> Does this look like the right thing to do?
>
> I didn't tested it but it looks correct and it is certainly OK for now.
> I made the patch "give a type to PSEUDO_ARGs" with this in mind.
>
> I'll take it the others ones.
>

Good news is that with this fix and by using a function pointer call
syntax that doesn't use (*f)() - I am able to successfully compile an
AVL Tree implementation. Whether the generated code is correct is
still to be checked but this is a big step forward I think - so many
thanks for the help!

> However I'm slowly looking at a more generic solution.
> For example, it would certainly be easier if there would be a
> OP_PTRCAST between a constant-value-used-as-a-pointer and its use.
> The cost would be some missing optimizations, or more complex ones
> or a sort of normalization pass.
>

I still think pseudo values should have a type - then we won't need
all the complexity!

Regards
Dibyendu
