From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Handling of -specs in cgcc
Date: Tue, 22 Jul 2008 11:03:52 -0700
Message-ID: <1216749832.4485.30.camel@josh-work.beaverton.ibm.com>
References: <f19298770807201128s3688702fm3f8b2f42edb198fc@mail.gmail.com>
	 <f19298770807221000o5905fefw44b0f420787baf9e@mail.gmail.com>
	 <118833cc0807221020m44938f77l70324a548baa4551@mail.gmail.com>
	 <f19298770807221028x4f2dca08l36a31a9c381bf4f3@mail.gmail.com>
	 <118833cc0807221043n215f5378pa3f97bdf75452d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42718 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbYGVSEE (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Jul 2008 14:04:04 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6MI6PEx029962
	for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 14:06:25 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m6MI3nuB206800
	for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 14:03:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m6MI3mrK003923
	for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 14:03:48 -0400
In-Reply-To: <118833cc0807221043n215f5378pa3f97bdf75452d0a@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <mwelinder@gmail.com>
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>, linux-sparse@vger.kernel.org, Morten Welinder <terra@gnome.org>

On Tue, 2008-07-22 at 13:43 -0400, Morten Welinder wrote:
> > But won't gcc fail in such case?
> 
> It will not fail, as gcc does not see any of it.  But since the defines might
> not match what gcc runs with, you might get interesting effects.
> 
> > Maybe we should not remove, but replace it
> > with a unique option to specify for which architecture sparse should check?
> 
> That's certainly possible, but I would wait for an actual problem showing
> up before fixing anything.  Right now, we can use -specs to get an idea
> what sparse would find for a different arch without actually having a gcc
> around that can cross compile.

In general, it seems questionable to have cgcc handle an option named
identically to one in GCC but have it behave differently than GCC.

That said, I do think Sparse should handle different architectures
without requiring compilation of a "cross-Sparse"; it really just needs
a specs-equivalent for each architecture.

- Josh Triplett


