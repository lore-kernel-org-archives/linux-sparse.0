From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 01:36:25 -0400
Message-ID: <CANeU7QmEqtnXgPjzjNOu9Ar0Oi7gmLLH=o_7hSNqr_O-jVKN_g@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com>
 <CAExDi1QQzTKeC1b=9sJYTANBvBDswqwqH1O1XsSED_oeYYVwnA@mail.gmail.com> <CACXZuxcOP5q8y+P5H9Xe4-KFbrLcHN4OcxVOr4-n2yj-3RHuqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33126 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdHPFg1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 01:36:27 -0400
Received: by mail-yw0-f182.google.com with SMTP id p68so16685575ywg.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 22:36:27 -0700 (PDT)
In-Reply-To: <CACXZuxcOP5q8y+P5H9Xe4-KFbrLcHN4OcxVOr4-n2yj-3RHuqg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 15, 2017 at 6:44 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I think it would be good to perform a detailed comparison / assessment
> of where the problem lies currently versus the new solution. I get the
> impression that the current problem is not well explained or
> understood.

I haven't look into the weather the new implementation does every thing
right yet. I can explain pretty well how the current implementation of SSA
is wrong. In short it is violating the SSA dominance property.
More specifically.
1) We have the "usage before define". The crazy programmer bug is
    trigger by this. Hopefully remove the single store short cut is going
    to help. My impression is that there is still more offender of "usage
    before define".

2) We don't place phi node at dominance frontier of the pseudo definition.

3) Uninitialized variable need to be treated as having implicate defined value
    of "uninitialzed" at entry point.

> Here are two known issues at present. You can see the old linearized
> output and the new linearized output - both produced with
> simplifications switched off.
>
> C code:
> https://github.com/dibyendumajumdar/dmr_c/blob/newssa/tests/bugs/simplifybug.c
>
> Old linearized output:
> https://github.com/dibyendumajumdar/dmr_c/blob/newssa/tests/bugs/simplifybug_old.lin
>
> New linearized output:
> https://github.com/dibyendumajumdar/dmr_c/blob/newssa/tests/bugs/simplifybug_new.lin

I haven't have time to take a closer look of the output.
The above 3 points should cover what is dong wrong with our SSA form.
That 3 points is also easier to reason than staring at the low level byte codes.

Chris
