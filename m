From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Possible linearizer issue
Date: Tue, 21 Mar 2017 00:59:24 +0100
Message-ID: <20170320235923.w5sdofxvbi66d24o@macpro.local>
References: <CACXZuxeuav4vrT=xKxLcV7RpUET8NM7VLuviTNr4N_XfGQxmHQ@mail.gmail.com>
 <CACXZuxdw6ifjMUWv4TDh+0KCTvaG-AK14=78mdPcPN7eqk4MHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36607 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754873AbdCTX73 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 19:59:29 -0400
Received: by mail-wr0-f180.google.com with SMTP id u108so102292610wrb.3
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 16:59:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdw6ifjMUWv4TDh+0KCTvaG-AK14=78mdPcPN7eqk4MHg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 20, 2017 at 11:43:33PM +0000, Dibyendu Majumdar wrote:
> On 18 March 2017 at 11:41, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> > I am investigating a failure in one of the tests. The generated
> > linearized code has instructions such as:
> >
> > .L363:
> >  br          VOID, .L366, .L439
> > .L366:
> >  load.32     %r413 <- 44[%arg1]
> >  br          %r413, .L368, .L369
> > .L368:
> >  load.64     %r415 <- 0[s7813er]
> >  call.32     %r416 <- printf, %r415, $2
> >  br          .L369
> > .L369:
> >  phisrc.32   %phi97(rc) <- $2
> >  br          .L439
> > .L439:
> >  phi.32      %r557 <- %phi95(rc), VOID, %phi97(rc), VOID, VOID, VOID
> >
> > The test program is here:
> >
> > https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/set1/cq2.c
> >

It's quite old as there is several instance of very similar code that
are quite OK and just this last one is wrong.
I'll look at it tomorrow.
 
> It seems that the issue is occurring in simplify_flow(). If I disable
> the call to this, then the program compiles successfully and also
> runs. None of my other tests fail with this step disabled.
> 
> Any clues what might be going wrong?

I suspect an issue with the tracking of pseudo usage.
 
> Does disabling simplify_flow() have any other effect except for missed
> optimizations?

It should not.

-- Luc
