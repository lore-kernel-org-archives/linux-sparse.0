From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Wed, 23 Nov 2016 14:49:17 +0800
Message-ID: <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
References: <87lh75jh9l.fsf@gmail.com> <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
 <20161123040528.GA74337@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36583 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbcKWHJk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 02:09:40 -0500
Received: by mail-io0-f195.google.com with SMTP id k19so660671iod.3
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 23:08:09 -0800 (PST)
In-Reply-To: <20161123040528.GA74337@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Wed, Nov 23, 2016 at 12:05 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> But, quoting the beginning of 6.6/6:
>     An integer constant expression shall have integer type and shall
>     only have operands that are integer constants, enumeration constants,
>     character constants, sizeof expressions whose results are integer
>     constants, and **floating constants** that are the immediate operands
>     of casts.
>
> and the part '(float) 0' is none of these.

I see, thanks for pointing it out.

>> +       [(int)(float)0.] = 0,   // KO
>> +
>> +       [(int)(void*)0] = 0,    // KO
>> Also this one should be fine?
>
> same for '(void *) 0'.
>

Good to know

Another question:
Is there any real reason to distinguish between "const enum/char" and
"const integer"?
Can we roll "const enum/char" as one type of "const integer" as well?

I think the patch can be simpler. The dance of CONSTEXPR_SET and MASK etc is
really messy.

The way I see it, there are three basic type of const elements.
Int ( including enum/char), Float, Address.

Either of which does not has any overlap with each other.

Then each of the matching requirement is just a sets consist of the
above element.
I am not sure there is need to distinguish integer const expression vs arthritic
const expression. (Example please?) If it does, add one more bit as
arthritic operations.

I think the real messy part of the original patch is that,
CONSTEXPR_FLAG_INT_CONST_EXPR
and CONSTEXPR_FLAG_ARITH_CONST_EXPR are two separate bit need to be maintained.
It does not need to be if we treat them as set of the elements.

We only need to keep track of "Int_const_expr, Float_literal, Addr_const_expr"
three bits. May be Arthritic_const_expr if we have need for that.
This patch series really make a difference on adding the "Addr_const_expr".

I am working on a patch on top of the patch series to test it out.

Chris
