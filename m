From: Pekka Enberg <penberg@kernel.org>
Subject: Re: suggestion for Merging LLVM
Date: Tue, 22 Nov 2011 08:01:14 +0200
Message-ID: <1321941674.1428.124.camel@jaguar>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
	 <4ECB38B1.8020803@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:36386 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab1KVGBT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 01:01:19 -0500
In-Reply-To: <4ECB38B1.8020803@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 11/21/2011 09:43 PM, Christopher Li wrote:
> > I already tag the sparse 0.4.4 release in git. Just waiting
> > for getting the release directory setup on kernel.org and it
> > is ready to go.
> >
> > Now I am looking at your LLVM repository and the llvm patches.
> > I don't have a good sense for the later patch without looking at the
> > earlier changes.
> >
> > I haven't done big repository merge before, this is the first one.
> > So I am looking for suggestion what is the best practice here.
> >
> > Do we care about clean up the history and import the changes
> > step by step as patches or just a plain git merge of the LLVM
> > repository?

On Tue, 2011-11-22 at 00:52 -0500, Jeff Garzik wrote:
> I don't see any reason to import step-by-step as patches.
> 
> Either merge it as a single "add incomplete LLVM backend" commit, 
> dropping all pre-upstream history, or git merge.

Agreed.

I'd actually prefer that we keep the full history for one simple reason:
the commit changelogs. They provide valuable information on why we've
implemented the things the way we have.

> FWIW I am sorta stuck; cannot figure out how to make 'phi' operation in 
> LLVM work the way we need it to.  That is a crucial hurdle needed for 
> loops.  LLVM fundamentally should be able to do it, but I'm not sure 
> this works within the C API.  I was thinking my next step would be to 
> whine on the llvm list.
> 
> A workaround is to resuscitate unssa() call, and all that entails.

Did you check what kind of code http://llvm.org/demo/ generates for your
test case? I've noticed that LLVM is really picky sometime in what it
accepts as input. IIRC last time I looked at loops, there were some
significant differences in the asm we generate.

			Pekka

