From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Mon, 30 Oct 2017 06:40:40 +0100
Message-ID: <20171030054039.4qjxtpcpxq2xnvcd@ltop.local>
References: <20171025100222.5983-1-jlayton@kernel.org>
 <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org>
 <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <20171029172809.6nlaz5lvxdcs677w@ltop.local>
 <CANeU7QnQi3313pVMiv4pGTZE51XU2EUbrB3Dg=DHgM-T-7f0EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:43494 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdJ3Fko (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 30 Oct 2017 01:40:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id m72so9213992wmc.0
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 22:40:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnQi3313pVMiv4pGTZE51XU2EUbrB3Dg=DHgM-T-7f0EA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Oct 30, 2017 at 05:53:49AM +0800, Christopher Li wrote:
> On Mon, Oct 30, 2017 at 1:28 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > The goal of the initial patch, as stated by Jeff, was:
> > "The fedora packaging tools want to *override* $CFLAGS when building sparse"
> >
> > This version doesn't allow to override CFLAGS.
> > See what happens with 'make CFLAGS=-O3' for example.
> 
> The original patch proposed by Jeff does not allow usage of
> "make CFLAGS=-O3" either.  I take a look at your patch, it behave
> the same way in this regard. Do you mean I should change the
> commit title to *append* CFLAGS instead of override?

Since for flags like -O[0123] but also for all flags like -f[no-]xxx
and all sort of others settings in GCC and in a multitude of others
programs it's the last value that matters, appending to CFLAGS *is*
the usual way to *override* previous settings.
Jeff's patch allowed that, mine too but yours not.
 
-- Luc
