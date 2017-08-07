From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Sun, 6 Aug 2017 20:33:51 -0400
Message-ID: <CANeU7QnxyV2cXvvErVsX_7MivK5AO+7TEsxf=rCvX+seoOf94A@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qk3trZmFqyGuhOxBLzFBOT131o=HhNhwQrzLrHoO2PQ1Q@mail.gmail.com> <20170806234441.vcpux6zyhfsfef3c@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36102 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdHGAdw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 20:33:52 -0400
Received: by mail-pg0-f44.google.com with SMTP id v77so27344103pgb.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 17:33:52 -0700 (PDT)
In-Reply-To: <20170806234441.vcpux6zyhfsfef3c@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 7:44 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>>
>> May I ask the question that, the SSA form you are building
>> from this codes. Does it violate the SSA dominance property
>
> Of course not. Unless there is a bug, that is.

I am very glad to heard that :-)

>
>> In other word, does it produce the "usage before
>> define" IR similar to this?
>>
>>         and.32      %r3 <- %r4, $-65
>>          or.32       %r4 <- %r3, $64
>
> It gives the code as I showed as reply to Dibyendu's mail.
> For example, his code gives:
>         foo:
>         .L0:
>                 <entry-point>
>                 and.32      %r2 <- UNDEF, $-65
>                 or.32       %r3 <- %r2, $64
>                 lsr.32      %r4 <- %r3, $6
>                 cast.1      %r5 <- (32) %r4
>                 cast.32     %r6 <- (1) %r5
>                 setne.32    %r7 <- %r6, $1
>                 ret.32      %r7
>
> with UNDEF being a new type of pseudo.

OK. So far so good.

>
> On purpose, nothing is done yet with the UNDEFs.
>
>> That I am very curios how it was done. See the above
>> question.
>
> IMO, the best is to read the article. My code is
> still very close to the article's pseudo-code.
>
> Basically, it's a lazy approach. Things are done
> when possible and are delayed if not.

So you are building the SSA for the memory variable
I assume?

Directly from the linearize process?

> More specifically, you can do what is needed in a BB
> once you have all the parents, otherwise you need to
> delay things. The article call this 'BB is sealed'
> and there is a 'seal' operation that need to be called
> to process what was delayed.
> Complications arise with gotos (and the article doesn't
> talk about them) but I've added a solution for it
> (but I would like to return to it later).

I am missing the obvious. Where is this article?

>
> From what I've seen/heard this algo have been pretty well
> received. Personnaly, I'm very happy with its simplicity
> and its result.

Great!

>
> One thing that is missing is the more complex cases
> with trivial phi-nodes.

Can you clarify?

>
> Another thing I would like to change is the ptrmap
> implementation I've added: it need to be hash-table based
> (but it's only an implementation detail that matters
> for performance on really big functions).

Which ptrmap? The one used for CSE?

Chris
