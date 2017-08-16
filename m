From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 12:02:04 +0100
Message-ID: <CACXZuxdbgoYtSwsutp+FUqjb8v_yX=BpmntBiBn092eoJ-zBjg@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com> <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:34049 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdHPLCG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 07:02:06 -0400
Received: by mail-ua0-f173.google.com with SMTP id q25so12443776uah.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 04:02:06 -0700 (PDT)
In-Reply-To: <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 15 August 2017 at 21:14, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> It's just too bad that the paper simply ignores gotos. The method
> is really cool, fast, simple and clean, I love it. But I had to add
> a few things, more akin to kludges than hacks IMO, to make it
> work with gotos. But as is, it works pretty well, is fast and produce
> correct SSA (also avoid few quadratic behaviours the current
> simplify_one_symbol() has).
>

I am trying to understand above - why should there be a special
treatment for gotos? A goto is simply a 'br' instruction from one BB
to another, so is there something special about it?

Regards
Dibyendu
