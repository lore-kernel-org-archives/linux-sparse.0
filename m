From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Mon, 30 Oct 2017 05:53:49 +0800
Message-ID: <CANeU7QnQi3313pVMiv4pGTZE51XU2EUbrB3Dg=DHgM-T-7f0EA@mail.gmail.com>
References: <20171025100222.5983-1-jlayton@kernel.org> <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org> <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <20171029172809.6nlaz5lvxdcs677w@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:53210 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdJ2Vxu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Oct 2017 17:53:50 -0400
Received: by mail-yw0-f196.google.com with SMTP id w2so9918212ywa.9
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 14:53:50 -0700 (PDT)
In-Reply-To: <20171029172809.6nlaz5lvxdcs677w@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Oct 30, 2017 at 1:28 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of the initial patch, as stated by Jeff, was:
> "The fedora packaging tools want to *override* $CFLAGS when building sparse"
>
> This version doesn't allow to override CFLAGS.
> See what happens with 'make CFLAGS=-O3' for example.

The original patch proposed by Jeff does not allow usage of
"make CFLAGS=-O3" either.  I take a look at your patch, it behave
the same way in this regard. Do you mean I should change the
commit title to *append* CFLAGS instead of override?

May be Jeff can clarify the intention?

BTW, I am actually leaning toward just expose some thing like
CLI_CFLAGS to be override by package builders. I am not that
convince override CFLAGS is established stander practices from
the project that I have look at.

On the other hand, it is trivial to avoid using CFLAGS in sparse
Makefile. If Jeff really want CFLAGS instead of CLI_CFLAGS,
it is not a big a deal.

Chris
