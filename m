From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Possible linearizer issue
Date: Tue, 21 Mar 2017 16:05:07 +0100
Message-ID: <20170321150506.xev7tkmbrtjgncv6@macbook.local>
References: <CACXZuxeuav4vrT=xKxLcV7RpUET8NM7VLuviTNr4N_XfGQxmHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36399 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757683AbdCUPFL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 11:05:11 -0400
Received: by mail-wm0-f41.google.com with SMTP id n11so14284864wma.1
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 08:05:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxeuav4vrT=xKxLcV7RpUET8NM7VLuviTNr4N_XfGQxmHQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Mar 18, 2017 at 11:41:26AM +0000, Dibyendu Majumdar wrote:
> Hi
> 
> I am investigating a failure in one of the tests. The generated
> linearized code has instructions such as:
> 
> .L363:
>  br          VOID, .L366, .L439
> .L366:
>  load.32     %r413 <- 44[%arg1]
>  br          %r413, .L368, .L369
> .L368:
>  load.64     %r415 <- 0[s7813er]
>  call.32     %r416 <- printf, %r415, $2
>  br          .L369
> .L369:
>  phisrc.32   %phi97(rc) <- $2
>  br          .L439
> .L439:
>  phi.32      %r557 <- %phi95(rc), VOID, %phi97(rc), VOID, VOID, VOID
> 
> The test program is here:
> 
> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/set1/cq2.c

I have looked a bit at this.
Reverting the patch (11b1a83b1 "fix OP_PHI usage in try_to_simplify_bb()")
should fix this but I'm not 100% sure about the consequence.
I'm looking for a proper solution though (but it need a bit infrastructure
code that I first need to put in place, so it will take a bit time).

-- Luc
