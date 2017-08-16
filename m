From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 08:50:25 -0400
Message-ID: <CANeU7Qn_raZ2RaK+aK_ms6GZOxE_-vRcqfc1oZrnTm1nTN49vw@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CACXZuxdbgoYtSwsutp+FUqjb8v_yX=BpmntBiBn092eoJ-zBjg@mail.gmail.com>
 <CAExDi1SXeds8_NPa37VTVLL-fRxY=xfhTDtFj8D4rUcAeoBkig@mail.gmail.com>
 <CACXZuxfd074S1jJMotGzn=MK-RORU7DEe7uj_yQ7oZPeyxVF9g@mail.gmail.com>
 <CAMHZB6Es+y+xCGMOrd=gvsqiTVWgz3niOXOQrv3fTFzr=6akVA@mail.gmail.com> <CACXZuxcFHGsfhMTT-BacMkkE5vZk7jScAZdkjeaX0rT+yWiEFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33441 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPMu1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:50:27 -0400
Received: by mail-yw0-f177.google.com with SMTP id p68so21851043ywg.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:50:26 -0700 (PDT)
In-Reply-To: <CACXZuxcFHGsfhMTT-BacMkkE5vZk7jScAZdkjeaX0rT+yWiEFQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 16, 2017 at 8:39 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> It is an advantage and a disadvantage in the sense that it makes SSA
> construction not reusable - or have I misunderstood? Looking at the

Not sure I understand the question.

> implementation I felt that it could be run as a second phase - is that
> assumption wrong?

That assumption is correct. But not having the advantage the paper
claim any more.

>
> I am just trying to understand the issue as it seems the paper claims
> it creates pruned SSA for all programs - not just reducible control
> flow. Have you contacted the authors regarding the issues you are

Sorry I might mislead you. I said the paper solution for irreducable
graph is *not* simple *nor* efficient any more. The paper do suggest
a way to do it. But I consider that way complex (in execution time sense).
I haven't take a closer look at the code yet.

> having with gotos? Might be worth doing so.

My reading of the paper is yes. Having "goto" will interrupt that
CFG less method. It can also lead to irreducible graph. Which means
extra step to clean it up. That extra step is expensive in the O() terms.

Chris
