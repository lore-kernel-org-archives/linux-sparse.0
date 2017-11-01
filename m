From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Wed, 1 Nov 2017 15:17:07 +0100
Message-ID: <20171101141705.aqn5gnwvuohkapp3@ltop.local>
References: <20171025100222.5983-1-jlayton@kernel.org>
 <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org>
 <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <1509476260.4553.45.camel@kernel.org>
 <CANeU7Qm8YHpYLLW8O=y=m9m6kRAD_5MiTnS79N5ffCk-PVcxFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47520 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbdKAORM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 1 Nov 2017 10:17:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id r196so5100168wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 01 Nov 2017 07:17:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm8YHpYLLW8O=y=m9m6kRAD_5MiTnS79N5ffCk-PVcxFQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Oct 31, 2017 at 08:56:47PM -0400, Christopher Li wrote:
> On Tue, Oct 31, 2017 at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > As Luc and Josh pointed out, I think we want $(CFLAGS) last here. That
> > allows you to pass in options that can supersede what the makefile puts
> > in there.
> > ...other than that, I'm fine with this. Assuming you fix that, you can
> > add:
> 
> I update the patch here and git url:
> https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=cflags-v2

This is still not correct. It still doesn't allow to compile sparse
via 'make CFLAGS=<some extra flags, possibly none>'.

Visibly this hasn't been tested.

-- Luc
