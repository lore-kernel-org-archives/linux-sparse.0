From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/2] split OP_BR between unconditional & conditional: OP_CBR
Date: Mon, 27 Feb 2017 22:22:10 +0100
Message-ID: <CAExDi1TE-uyp7QuqptQfN47OE2dZL5dfGt6v8V=Pv54JxLBH3Q@mail.gmail.com>
References: <20170218012848.27417-1-luc.vanoostenryck@gmail.com>
 <20170218012848.27417-2-luc.vanoostenryck@gmail.com> <CANeU7Q=60E+2tvn=bdjaYnZFS3U3PMiTTq0=eYS-NkPDK3aJNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35188 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdB1Ako (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 19:40:44 -0500
Received: by mail-qk0-f179.google.com with SMTP id u188so125071150qkc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 16:40:06 -0800 (PST)
In-Reply-To: <CANeU7Q=60E+2tvn=bdjaYnZFS3U3PMiTTq0=eYS-NkPDK3aJNA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Feb 27, 2017 at 4:02 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Feb 18, 2017 at 9:28 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> This could be corrected in several ways (like changing all
>> the places wheer the first test is used, use the helper
>> everywhere or never set ->cond to VOID) but the simplest
>> is to simply split them in two separated instructions:
>> OP_BR & OP_CBR, especailly given the fact that in most cases
>> the OP_BR was first selected by a switch (opcode).
>
> I think that change itself is fine. The implications is that all sparse
> back end user will need to be updated to use CBR instead of BR.

Yes, indeed.
BTW, I've often wondered about backend using sparse,
do you know any others than smatch (and I think smatch won't
be impacted here becaue it don't use the linearized code but
I can be wrong)?

> Sparse can be compiled as a lib to link against. We might want to
> have some API version for sprase to check which version of sparse
> it is.  Currently there is SPARSE_VERSION but that is a macro
> which does not reflect in the lib version of sparse.

Yes, but how useful such a macro really is?
A backend still need to be changed to be able to use it.

> That is a separate patch though.

Sure, I'll do something for it.

>> @@ -811,9 +811,10 @@ static int rewrite_parent_branch(struct basic_block *bb, struct basic_block *old
>>                 return 0;
>>
>>         switch (insn->opcode) {
>> +       case OP_CBR:
>> +               changed |= rewrite_branch(bb, &insn->bb_false, old, new);
>
> We can use some comment of fall though the case here.

Sure, I'll send a new version.
>> @@ -886,9 +887,10 @@ static void vrfy_children(struct basic_block *bb)
>>         }
>>         switch (br->opcode) {
>>                 struct multijmp *jmp;
>> +       case OP_CBR:
>> +               vrfy_bb_in_list(br->bb_false, bb->children);
>
> Same here.

Yup.

Luc
