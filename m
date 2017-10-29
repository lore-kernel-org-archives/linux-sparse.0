From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Mon, 30 Oct 2017 06:48:50 +0800
Message-ID: <CANeU7Qm5MhX45crgY-oWLHqBBUHRJ5bK6RiBOKT9+8c3Ar3orA@mail.gmail.com>
References: <20171025100222.5983-1-jlayton@kernel.org> <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org> <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <20171029172809.6nlaz5lvxdcs677w@ltop.local> <CANeU7QnQi3313pVMiv4pGTZE51XU2EUbrB3Dg=DHgM-T-7f0EA@mail.gmail.com>
 <20171029221155.gqki2qshonjhyy66@s>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:52516 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdJ2Wsv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Oct 2017 18:48:51 -0400
Received: by mail-yw0-f169.google.com with SMTP id w2so9982343ywa.9
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 15:48:51 -0700 (PDT)
In-Reply-To: <20171029221155.gqki2qshonjhyy66@s>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Oct 30, 2017 at 6:11 AM, Josh Triplett <josh@joshtriplett.org> wrote:

> `make CFLAGS='-arbitrary -flags'` is quite common, and people generally
> expect it to work, though it isn't *shocking* when it breaks. Though the
> exact boundary for what should get overridden by that and what should
> remain seems a bit fuzzy. Roughly speaking, if the application normally
> wants to build with "-O2 -ffooish-bar -Wall -Wanother -I/some/path" ,
> then `make CFLAGS='-Os -arbitrary -flags'` should build with "-Os
> -arbitrary -flags -Wall -Wanother -Isome-path`. I think.

Thanks for the feed back. Yes, there is some project do that.
Those project also document it.
On the other hand, some cmake project don't use CFLAGS
at all as far as I can tell.


So I think as long as the project provide clear document for what
it expect to be override from command line, the package builder
use it consistently. That is fine.

> I think it's worth not putting anything into CFLAGS that would break the
> build if missing.
>
> For instance, git's Makefile specifically says "# CFLAGS and LDFLAGS are
> for the users to override from the command line.", and then just has
> "CFLAGS = -g -O2 -Wall". It then has additional variables like

We can do that for sparse if some one want to use it his way.
On the other hand, I think it is up to the package to decide what
to be allow to override.

The package builder should not take it for granted that very package
should work in this way. Some project don't use CFLAGS at all.

Provide the interface as needed, then document it. That seems to
be the right thing to do.

Chris
