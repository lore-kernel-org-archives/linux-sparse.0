From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC] sparse SSA construction
Date: Tue, 15 Aug 2017 14:41:54 +0100
Message-ID: <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:38619 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdHONlz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Aug 2017 09:41:55 -0400
Received: by mail-ua0-f173.google.com with SMTP id y36so3032042uac.5
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 06:41:55 -0700 (PDT)
In-Reply-To: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

Hi Luc,

On 6 August 2017 at 21:26, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Since it seems to be some interest on the subject and
> to avoid duplicated work, here is a rewrite of sparse's
> construction of the SSA form.
>
> It's not using one of the classical algorithm but is
> using something newer, simpler and often faster.
> It's main advantage beyond the simplicity is that you don't
> need to first build the whole CFG & linearized code to
> to directly throw it away (or heavily transform it) as
> it builds the SSA form directly during the linearization.
>
> It's not finished code but it's working well (and is
> effectively a bit faster and use less memory).
> What's interesting for sparse now is that:
> - the phi-noes are correctly placed
> - uninitialized variables can be handled much more easily.
>
> I don't feel it's needed to patchbomb the ML for the moment
> so I'll only give the URL to the repo:
>
>   git://github.com/lucvoo/sparse.git sssa

I have merged the new SSA implementation in your sssa-mini-clean
branch - which I understand is minimal set of changes needed for the
new SSA on top of RC5 - into my project dmrC.

I have been testing the changes  - and so far I am pleased to report
that after a small set of changes (described below) - all my existing
tests pass.

a) I had to disallow struct / union types from being treated as simple types.
b) I am setting UNDEF pseudos a value of 0 in LLVM backend - this is
to ensure I can do the same in other backends.
c) I found that CBR instructions can get a PSEUDO_VAL as the condition
which was not being handled correctly in my version of LLVM backend.
Somehow this did not occur in the past so I am not yet sure how this
is related to the changes.

The new implementation does not appear to suffer from the performance
degradation we saw after removing the single store shortcut.

Finally the new code seems simpler and elegant. I would suggest adding
some comments in ssa.c - perhaps copy the pseudo code from the paper
it is based on - to better explain what is going on.

Many thanks for this great piece of work.

I do recommend submitting a patch of sssa-mini-clean - as this is the
minimal set on top of RC5. By integrating this post 0.5.1 release some
amount of time can be spent testing and validating this before other
changes are done.

Regards
Dibyendu
