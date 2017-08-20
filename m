From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 17:12:21 +0100
Message-ID: <CACXZuxenUKprEMjScasEMZNxYDFGeSy8soPpYxbDbd+1kWHY1w@mail.gmail.com>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
 <20170820151513.ddoxdwo7iwd2nefh@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33253 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbdHTQMW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 12:12:22 -0400
Received: by mail-ua0-f182.google.com with SMTP id q40so1814003uag.0
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 09:12:21 -0700 (PDT)
In-Reply-To: <20170820151513.ddoxdwo7iwd2nefh@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 20 August 2017 at 16:15, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Aug 20, 2017 at 03:54:47PM +0100, Dibyendu Majumdar wrote:
>> I am trying to get to grips with the Sparse Linear format and the use
>> of pseudos.
>>
>> 1) A Sparse document says that pseudos are akin to SSA variables. Is
>> that a true statement - i.e. do pseudos follow the discipline that
>> only one assignment to a pseudo is allowed. As pseudos have also
>> different sub-types - does this statement apply to all pseudo types or
>> only some sub types?
>>
>> 2) In a recent conversation it was stated that the baseline Linear
>> output from Sparse is already in SSA form. That implies that all
>> pseudos used are in SSA form already. However we know that in the
>> baseline line IR phi nodes may not be present. In LLVM the initial IR
>> lacks phi nodes too - instead local stack memory and load/store
>> sequences are used. However LLVM IR is still SSA at this stage. When
>> it is said that the baseline Linear IR is already SSA is it in this
>> sense?
>
> One way to answer this with few words is to look at what's happening
> to a variable assigned in different paths in a simple example:

Thank you - it is always good to look at examples.

>
>         int f(void);
>
>         int foo(int p)
>         {
>                 int a;
>
>                 if (p) {
>                         a = 0;
>                         a++;
>                 } else {
>                         a = f();
>                 }
>
>                 return a;
>         }
>
>
> Just after linearization:
>         foo:
>         .L0:
>                 <entry-point>
>                 store.32    %arg1 -> 0[p]
>                 load.32     %r1 <- 0[p]
>                 cbr         %r1, .L1, .L2
>
>         .L1:
>                 store.32    $0 -> 0[a]
>                 load.32     %r2 <- 0[a]
>                 add.32      %r3 <- %r2, $1
>                 store.32    %r3 -> 0[a]
>                 br          .L3
>
>         .L2:
>                 call.32     %r4 <- f
>                 store.32    %r4 -> 0[a]
>                 br          .L3
>
>         .L3:
>                 load.32     %r5 <- 0[a]
>                 ret.32      %r5
>

Okay the linear output above seems SSA if we consider how it is shown
in the output. But in the code, access to 0[a] occurs via a pseudo -
of type PSEUDO_SYM. We see multiple stores happening to this pseudo.
So the question is each access generated through a different instance
of a pseudo? I see that in the code if a symbol already has a pseudo
then it is reused. So presumably then PSEUDO_SYMs are not SSA, but
PSEUDO_REGs are?

So then is it more accurate to say that PSEUDO_SYM and possibly
PSEUDO_ARG too - represent memory access, and are just a proxy for
stack allocated memory?

Regards
Dibyendu
