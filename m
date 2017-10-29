From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Sun, 29 Oct 2017 18:28:10 +0100
Message-ID: <20171029172809.6nlaz5lvxdcs677w@ltop.local>
References: <20171025100222.5983-1-jlayton@kernel.org>
 <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org>
 <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53263 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdJ2R2M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Oct 2017 13:28:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id r196so12077575wmf.2
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 10:28:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Oct 29, 2017 at 07:32:39PM +0800, Christopher Li wrote:
> On Thu, Oct 26, 2017 at 8:11 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > Perhaps instead of describing it, you could roll up an alternative patch
> > that shows what you would prefer to see here?
> 
> Here it is the patch.
> 
> I push it on https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=cflags
> 
> Chris
> 
> From 9fc170ec5e5814ae858922496dea668bb80dbf34 Mon Sep 17 00:00:00 2001
> From: Christopher Li <sparse@chrisli.org>
> Date: Sun, 29 Oct 2017 19:16:44 +0800
> Subject: [PATCH] Makefile: provide CFLAGS for command line override.
> 
> Avoid assign to CFLAGS in Makefile.
> Rename BASIC_CFLAGS to COMMON_CFLAGS.
> Use PKG_CFLAGS to store external package related cflags.

The goal of the initial patch, as stated by Jeff, was:
"The fedora packaging tools want to *override* $CFLAGS when building sparse"

This version doesn't allow to override CFLAGS.
See what happens with 'make CFLAGS=-O3' for example.

-- Luc
