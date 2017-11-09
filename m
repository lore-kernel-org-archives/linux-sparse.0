From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Thu, 9 Nov 2017 22:26:10 +0100
Message-ID: <20171109212607.4lnd6aedr63c5ta2@ltop.local>
References: <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org>
 <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <1509476260.4553.45.camel@kernel.org>
 <CANeU7Qm8YHpYLLW8O=y=m9m6kRAD_5MiTnS79N5ffCk-PVcxFQ@mail.gmail.com>
 <20171101141705.aqn5gnwvuohkapp3@ltop.local>
 <CANeU7Qm4+DWdcDrMytWqxTELrwuyMEkhs2hFGj6599ghetBE8A@mail.gmail.com>
 <20171105165751.iqqlaxz6yu27nouj@ltop.local>
 <CANeU7Qk=pg0kWEoT6KUK_+6PVEjfAJeh+-_=dB_LqT-Bh+88CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51915 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbdKIV0O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 16:26:14 -0500
Received: by mail-wm0-f66.google.com with SMTP id b9so20541068wmh.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 13:26:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk=pg0kWEoT6KUK_+6PVEjfAJeh+-_=dB_LqT-Bh+88CQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 10, 2017 at 05:10:48AM +0800, Christopher Li wrote:
> On Mon, Nov 6, 2017 at 12:57 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Much better!
> > Now you can give it a try at 'make CFLAGS=-O3 selfcheck'.
> >
> The selfcheck on sparse-llvm.sc is independent of the CFLAGS changes.

On the contrary, it's very much at the core of the way the
different CFLAGS variable are used.

Everywhere you will use something like:
   <sometarget>.o: <some CFLAGS variant> += <something>
you will also need to add <sometarget>.sc
It's the way you solve the problem and it may seems to you 
independent of the CFLAGS changes and yet in my version of
the CFLAGS changes this bug was solved automatically by how
the CFLAGS were used (I discovered the bug while writting the
patch; you know this "ohoh, this can't possibly be correct").

But well, more than enough time have already spend on these CFLAGS.

-- Luc
