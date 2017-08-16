From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 13:16:19 +0100
Message-ID: <CACXZuxfd074S1jJMotGzn=MK-RORU7DEe7uj_yQ7oZPeyxVF9g@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CACXZuxdbgoYtSwsutp+FUqjb8v_yX=BpmntBiBn092eoJ-zBjg@mail.gmail.com> <CAExDi1SXeds8_NPa37VTVLL-fRxY=xfhTDtFj8D4rUcAeoBkig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34964 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdHPMQU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:16:20 -0400
Received: by mail-ua0-f171.google.com with SMTP id d29so13054630uai.2
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:16:20 -0700 (PDT)
In-Reply-To: <CAExDi1SXeds8_NPa37VTVLL-fRxY=xfhTDtFj8D4rUcAeoBkig@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 16 August 2017 at 13:00, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Aug 16, 2017 at 1:02 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I am trying to understand above - why should there be a special
>> treatment for gotos? A goto is simply a 'br' instruction from one BB
>> to another, so is there something special about it?
>
> Very good question!
>
> It's related to 'structured programming' vs. non-structured programming.
> If you write code which do control flow only by using if-then-else,
> do-while/until, while-do and C's for-loop then you know very well
> at each step where the code can come from, same during the linearization
> here in sparse, you know when your write the IR for the if-then-else or the loop
> what parent BB's you will have, you know that no other ones will need to be
> added later.
> Once you use gotos, it's not true anymore: if you have a label, then you
> will probably have some gotos going to this label, in other words, new parents
> for the BB. With computed gotos it's even worse: any computed-goto can
> possibly go to any label you have taken the address (it's GCCism, not standard
> C but we have to support it).
>
> This is not a problem for the method, just a little complication as we have then
> to delay a few things until we know all the gotos have been issued, then we know
> that no new parents can be added (to the BB corresponding to a label) and things
> can move on. It was just that the articles, for the sake of simplicity
> I suppose,
> superbly ignored the question of the gotos. So it was not as simple as taking
> the pseudo-code they gave and implement it, I had to find some solutions
> for these gotos.
>

Is it the problem that you are constructing SSA while linearizing - so
that you do not have the gotos resolved? Would it be a better design
to finish linear stream, and then run SSA conversion? The advantage of
this would also be that you can reuse the SSA conversion phase later
on if some transformation of the linear stream introduced non-SSA
constructs.

Regards
Dibyendu
