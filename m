From: Christopher Li <sparse@chrisli.org>
Subject: Re: RFC: One strange idea inspired by the SSSA
Date: Mon, 21 Aug 2017 13:42:59 -0400
Message-ID: <CANeU7Qmh5HjMykETwV24o0a4EEaVKqdGUgqSiu9Bc1txq2b+NQ@mail.gmail.com>
References: <CANeU7Qn2zyruhC5r1bMM8uOzCvk_6xvezQCWdV_U6jAxQiVuDg@mail.gmail.com>
 <CAMHZB6EuyzzTiJdwPC5p727628uDhyt1aRQFdg+Yj6V3hmDozw@mail.gmail.com>
 <CANeU7QkZD4OFjdpTH3Dz5Yq6XMxRvi=+L=G2K5soxFTycDxi_Q@mail.gmail.com> <CAMHZB6H9VAT8STaXSuR=waaS3rggky4DE+QRtF6S0vYKWLuRLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35589 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbdHURnA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 13:43:00 -0400
Received: by mail-yw0-f171.google.com with SMTP id s187so10092962ywf.2
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 10:43:00 -0700 (PDT)
In-Reply-To: <CAMHZB6H9VAT8STaXSuR=waaS3rggky4DE+QRtF6S0vYKWLuRLA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 12:57 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> I just made a small change to the ptrmap and I'm back to slightly
> faster than rc5. With all March's pending fixes it's even a bit faster.
> We're talking of something like twice 2%.

Do you have a link for testing? I can run that on my compile server
and report back with testing my numbers.

> With smaller ptrlist it's yet another 2%.

I think the RC5 with the short cut removed is all already a low
starting point. It should be faster.  A cytron el al should be faster
than RC5 too.

> Sorry, but for my part I'll give my trust to a published and well
> received method.

I understand you don't want to think some thing that is new
and unproven. But that is all new ideas are about.

In your reasoning we might want to consider Cytron et al then.
It is published and much more well known in the field. It give
minimal SSA at smaller overhead than SSSA (if we want minimal
SSA from SSSA). It does not have the 2) problem SSSA has.

Also variance of Cytron el al has been implemented in LLVM and
gcc. Due to the 2) problem of SSSA, we might need to implement
it any way.

Chris
