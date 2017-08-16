From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 13:39:38 +0100
Message-ID: <CACXZuxcFHGsfhMTT-BacMkkE5vZk7jScAZdkjeaX0rT+yWiEFQ@mail.gmail.com>
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
 <CACXZuxfd074S1jJMotGzn=MK-RORU7DEe7uj_yQ7oZPeyxVF9g@mail.gmail.com> <CAMHZB6Es+y+xCGMOrd=gvsqiTVWgz3niOXOQrv3fTFzr=6akVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:32856 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdHPMjk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:39:40 -0400
Received: by mail-ua0-f173.google.com with SMTP id r9so3840957uad.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:39:39 -0700 (PDT)
In-Reply-To: <CAMHZB6Es+y+xCGMOrd=gvsqiTVWgz3niOXOQrv3fTFzr=6akVA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 16 August 2017 at 13:28, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Aug 16, 2017 at 2:16 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Is it the problem that you are constructing SSA while linearizing - so
>> that you do not have the gotos resolved? Would it be a better design
>> to finish linear stream, and then run SSA conversion?
>
> The *big* advantage of this method is that you *do not* have to first
> generate the whole thing *and then* transform it into SSA form.
> The price is a slight complication in the handling of gotos.
> The more classic approach  need special handling for gotos too.
>

It is an advantage and a disadvantage in the sense that it makes SSA
construction not reusable - or have I misunderstood? Looking at the
implementation I felt that it could be run as a second phase - is that
assumption wrong?

I am just trying to understand the issue as it seems the paper claims
it creates pruned SSA for all programs - not just reducible control
flow. Have you contacted the authors regarding the issues you are
having with gotos? Might be worth doing so.

Regards
Dibyendu
