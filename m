From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Wed, 23 Nov 2016 09:39:57 +0100
Message-ID: <87a8cqlhcy.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
        <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
        <20161123040528.GA74337@macpro.local>
        <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36475 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933790AbcKWIkA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 03:40:00 -0500
Received: by mail-wj0-f193.google.com with SMTP id jb2so489855wjb.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 00:40:00 -0800 (PST)
In-Reply-To: <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
        (Christopher Li's message of "Wed, 23 Nov 2016 14:49:17 +0800")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

Hi Christopher,

Christopher Li <sparse@chrisli.org> writes:

> On Wed, Nov 23, 2016 at 12:05 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> But, quoting the beginning of 6.6/6:
>>     An integer constant expression shall have integer type and shall
>>     only have operands that are integer constants, enumeration constants,
>>     character constants, sizeof expressions whose results are integer
>>     constants, and **floating constants** that are the immediate operands
>>     of casts.
>>
>> and the part '(float) 0' is none of these.
>
> I see, thanks for pointing it out.
>
>>> +       [(int)(float)0.] = 0,   // KO
>>> +
>>> +       [(int)(void*)0] = 0,    // KO
>>> Also this one should be fine?
>>
>> same for '(void *) 0'.
>>
>
> Good to know
>
> Another question:
> Is there any real reason to distinguish between "const enum/char" and
> "const integer"?
> Can we roll "const enum/char" as one type of "const integer" as well?

(void*)'a' doesn't qualify as an address constant, (void *)0 does.

So while we certainly won't need to distinguish enum and char constants
(literals), we have to do so for integer constants (literals) vs
enum/char constants (literals).

Maybe it suffices to simply tag the latter as "integer constant
expression" though. I will have a look on whether the standard allows
character/enum constants at places where it forbids the use of integer
constant expressions.


> I think the patch can be simpler. The dance of CONSTEXPR_SET and MASK etc is
> really messy.
>
> The way I see it, there are three basic type of const elements.
> Int ( including enum/char), Float, Address.
>
> Either of which does not has any overlap with each other.
>
> Then each of the matching requirement is just a sets consist of the
> above element.

Sorry, I don't understand that last sentence. "Set" in the mathematical
sense? How would that look like?


> I am not sure there is need to distinguish integer const expression vs arthritic
> const expression. (Example please?) If it does, add one more bit as
> arthritic operations.

An example would be initialization with designators as shown in the
testcase you quoted above. C.f. 6.7.8(6): only integer constant
expressions are allowed there, but not arithmetic ones.


> I think the real messy part of the original patch is that,
> CONSTEXPR_FLAG_INT_CONST_EXPR
> and CONSTEXPR_FLAG_ARITH_CONST_EXPR are two separate bit need to be maintained.
> It does not need to be if we treat them as set of the elements.
>
> We only need to keep track of "Int_const_expr, Float_literal, Addr_const_expr"
> three bits. May be Arthritic_const_expr if we have need for that.
> This patch series really make a difference on adding the "Addr_const_expr".
>
> I am working on a patch on top of the patch series to test it out.

Prove me wrong, but AFAICS, in the context of error catching, the
standard mandates that we need to distinguish between

- integer literals
- (maybe char/enum integer constants)
- floating point literals
- integer constant expressions
- arithmetic constant expressions
- address constants

somehow...


Thanks,

Nicolai
