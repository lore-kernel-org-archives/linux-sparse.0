From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 13:36:30 +0000
Message-ID: <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
 <20170311114903.zrhufw6ydneky3ya@macbook.local> <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37331 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755616AbdCKNgc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 08:36:32 -0500
Received: by mail-it0-f44.google.com with SMTP id g138so10748916itb.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 05:36:31 -0800 (PST)
In-Reply-To: <20170311123039.tcpo2dcajfmxwmsm@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On 11 March 2017 at 12:30, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Mar 11, 2017 at 11:54:56AM +0000, Dibyendu Majumdar wrote:
>> PSEUDO_VAL strikes again!
>>
>> struct avl_node {
>>  struct avl_node *right;
>>  struct avl_node *left;
>> };
>> #define NULL ((void *)0)
>> static int test_null_comp(int height_changed, struct avl_node *node) {
>>  return node != NULL && height_changed;
>> }
>
> See the message of "llvm: fix translation of PSEUDO_VALs into a ValueRefs"
>     Note: while this patch improve the situation, like for example for the
>     test cases added here, it's still not correct because now we're making
>     the assumption that 'insn->type' is the type we need for the pseudo.
>     This is often true, but certainly not always.
>     For example this is not true for:
>     - OP_STORE/OP_LOAD's insn->src
>     - OP_SET{EQ,...}'s   insn->src[12]
>     - probably some  others ones
>     - in general, obviously, for any instructions where the target has
>       a different type than the operands.
>
> Here you're hitting the OP_SET{EQ,...} case.
>

Here is my attempt to fix:

static struct symbol *pseudo_get_type(pseudo_t pseudo) {
 switch (pseudo->type) {
 case PSEUDO_SYM:
 case PSEUDO_ARG:
  return pseudo->sym;
 case PSEUDO_PHI:
 case PSEUDO_REG:
  return pseudo->def->type;
 default:
  assert(0);
  return NULL;
 }
}
static void output_op_compare(struct function *fn, struct instruction *insn)
{
 LLVMValueRef lhs, rhs, target;
 char target_name[64];
 if (insn->src1->type == PSEUDO_VAL)
  lhs = val_to_value(fn, insn->src1->value, pseudo_get_type(insn->src2));
 else
  lhs = pseudo_to_value(fn, insn, insn->src1);
 if (insn->src2->type == PSEUDO_VAL)
  //rhs = LLVMConstInt(LLVMTypeOf(lhs), insn->src2->value, 1);
  rhs = val_to_value(fn, insn->src2->value, pseudo_get_type(insn->src1));
 else
  rhs = pseudo_to_value(fn, insn, insn->src2);


Does this look like the right thing to do?

Regards
Dibyendu
