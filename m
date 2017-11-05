From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Sun, 5 Nov 2017 17:57:53 +0100
Message-ID: <20171105165751.iqqlaxz6yu27nouj@ltop.local>
References: <20171025100222.5983-1-jlayton@kernel.org>
 <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org>
 <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <1509476260.4553.45.camel@kernel.org>
 <CANeU7Qm8YHpYLLW8O=y=m9m6kRAD_5MiTnS79N5ffCk-PVcxFQ@mail.gmail.com>
 <20171101141705.aqn5gnwvuohkapp3@ltop.local>
 <CANeU7Qm4+DWdcDrMytWqxTELrwuyMEkhs2hFGj6599ghetBE8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47713 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKEQ55 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:57:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id r196so9595766wmf.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:57:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm4+DWdcDrMytWqxTELrwuyMEkhs2hFGj6599ghetBE8A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 05, 2017 at 08:45:53AM +0800, Christopher Li wrote:
> On Wed, Nov 1, 2017 at 10:17 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> 
> > This is still not correct. It still doesn't allow to compile sparse
> > via 'make CFLAGS=<some extra flags, possibly none>'.
> >
> > Visibly this hasn't been tested.
> 
> Sorry about that.
> 
> There is one spot I miss after solving conflict of rebase master.

You rejected the patch, wrote your own version and you had to rebase it
and you had a conflict?
 
> How about this one:
> 
> https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=cflags-v3

Much better!
Now you can give it a try at 'make CFLAGS=-O3 selfcheck'.


-- Luc Van Oostenryck 
