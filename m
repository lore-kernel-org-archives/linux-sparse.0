From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 08:23:17 -0400
Message-ID: <CANeU7Q=4Z2BLD_KuE9PQ6LZoUGaXRsNFD8MVttzC8RnCFLQrvg@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CACXZuxdbgoYtSwsutp+FUqjb8v_yX=BpmntBiBn092eoJ-zBjg@mail.gmail.com>
 <CAExDi1SXeds8_NPa37VTVLL-fRxY=xfhTDtFj8D4rUcAeoBkig@mail.gmail.com> <CACXZuxfd074S1jJMotGzn=MK-RORU7DEe7uj_yQ7oZPeyxVF9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36282 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdHPMXT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:23:19 -0400
Received: by mail-yw0-f173.google.com with SMTP id u207so21381782ywc.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:23:19 -0700 (PDT)
In-Reply-To: <CACXZuxfd074S1jJMotGzn=MK-RORU7DEe7uj_yQ7oZPeyxVF9g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 16, 2017 at 8:16 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Is it the problem that you are constructing SSA while linearizing - so
> that you do not have the gotos resolved? Would it be a better design

That is the paper is trying to construct SSA skipping the CFG stage.
When you have goto, you can't really skip CFG any more. That is why
it is fundamental hard to resolve for this paper.

> to finish linear stream, and then run SSA conversion? The advantage of

Yes, that is just the traditional way, the way that LLVM was doing.
The paper is trying to claim having a simpler and efficient solution than
LLVM. It is not true any more with considering of "goto" and irreducible
graph input.

> this would also be that you can reuse the SSA conversion phase later
> on if some transformation of the linear stream introduced non-SSA
> constructs.

That is exactly the traditional way. You start to reason against the
method  using in this paper. :-)

Chris
