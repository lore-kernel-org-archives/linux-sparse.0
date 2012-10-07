From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: "unexpected unlock" when unlocking, conditional, lock in loop
Date: Sun, 7 Oct 2012 16:30:32 -0700
Message-ID: <20121007233032.GA5508@leaf>
References: <1349552876.20963@cat.he.net>
 <20121006202102.GA28179@leaf>
 <66AC2AD6-C0FA-4F60-850A-D8C9426184B8@coraid.com>
 <20121007023946.GA30713@leaf>
 <E7D62B13-C7E3-4A4B-B579-81E773DDC641@coraid.com>
 <20121007194552.GA909@leaf>
 <E2F79A45-57FB-48C5-B8FC-27C431B1B2BB@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38536 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab2JGXaj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Oct 2012 19:30:39 -0400
Content-Disposition: inline
In-Reply-To: <E2F79A45-57FB-48C5-B8FC-27C431B1B2BB@coraid.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ed Cashin <ecashin@coraid.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

On Sun, Oct 07, 2012 at 04:28:16PM -0500, Ed Cashin wrote:
> On Oct 7, 2012, at 3:45 PM, Josh Triplett wrote:
> 
> > On Sun, Oct 07, 2012 at 07:49:25AM -0500, Ed Cashin wrote:
> ...
> >>  CC [M]  drivers/block/aoe/demo.o
> >> drivers/block/aoe/demo.c:9: warning: `context' attribute directive ignored
> >> drivers/block/aoe/demo.c:9: error: expected `,' or `;' before `{' token
> >> make[1]: *** [drivers/block/aoe/demo.o] Error 1
> >> make: *** [drivers/block/aoe/aoe.ko] Error 2
> > 
> > Oh, that complaint doesn't come from Sparse; that comes from GCC, since
> > GCC doesn't understand the context attribute.  Look at
> > include/linux/compiler.h; it has wrapper macros for the various Sparse
> > attributes, and defines them to nothing when not compiling with Sparse.
> > If you want to use the context attribute to denote a lock held through a
> > function, you need a patch like this:
> > 
> > From 0b862fc1a131a874d157420e9443f16a714596ef Mon Sep 17 00:00:00 2001
> > From: Josh Triplett <josh@joshtriplett.org>
> > Date: Sun, 7 Oct 2012 12:41:13 -0700
> > Subject: [PATCH] linux/compiler.h: Add __must_hold macro for functions called with a lock held
> 
> Ah.  OK.  So... would you like me to submit your patch to the LKML, or are you doing that?
> 
> It seems like a needed addition.

If you can confirm that it works for you, I'll send it to LKML with a
Tested-by from you.

- Josh Triplett
