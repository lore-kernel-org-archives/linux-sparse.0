From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 14:00:35 +0200
Message-ID: <CAExDi1SXeds8_NPa37VTVLL-fRxY=xfhTDtFj8D4rUcAeoBkig@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com> <CACXZuxdbgoYtSwsutp+FUqjb8v_yX=BpmntBiBn092eoJ-zBjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38380 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdHPMAh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:00:37 -0400
Received: by mail-oi0-f65.google.com with SMTP id s21so3334950oie.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:00:37 -0700 (PDT)
In-Reply-To: <CACXZuxdbgoYtSwsutp+FUqjb8v_yX=BpmntBiBn092eoJ-zBjg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 16, 2017 at 1:02 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I am trying to understand above - why should there be a special
> treatment for gotos? A goto is simply a 'br' instruction from one BB
> to another, so is there something special about it?

Very good question!

It's related to 'structured programming' vs. non-structured programming.
If you write code which do control flow only by using if-then-else,
do-while/until, while-do and C's for-loop then you know very well
at each step where the code can come from, same during the linearization
here in sparse, you know when your write the IR for the if-then-else or the loop
what parent BB's you will have, you know that no other ones will need to be
added later.
Once you use gotos, it's not true anymore: if you have a label, then you
will probably have some gotos going to this label, in other words, new parents
for the BB. With computed gotos it's even worse: any computed-goto can
possibly go to any label you have taken the address (it's GCCism, not standard
C but we have to support it).

This is not a problem for the method, just a little complication as we have then
to delay a few things until we know all the gotos have been issued, then we know
that no new parents can be added (to the BB corresponding to a label) and things
can move on. It was just that the articles, for the sake of simplicity
I suppose,
superbly ignored the question of the gotos. So it was not as simple as taking
the pseudo-code they gave and implement it, I had to find some solutions
for these gotos.

-- Luc
