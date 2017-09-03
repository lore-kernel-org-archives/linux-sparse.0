From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Simple SSA status
Date: Sun, 3 Sep 2017 22:26:31 +0200
Message-ID: <20170903202629.bipsxi7xnmh3y3oy@ltop.local>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35953 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbdICU0f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 3 Sep 2017 16:26:35 -0400
Received: by mail-wm0-f41.google.com with SMTP id i145so10202095wmf.1
        for <linux-sparse@vger.kernel.org>; Sun, 03 Sep 2017 13:26:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Aug 22, 2017 at 10:59:54AM -0400, Christopher Li wrote:
> On Tue, Aug 22, 2017 at 10:53 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
> >>
> >
> > It will be great if the SSSA series is merged and tested a bit before
> > merging other changes.
> 
> I can create a topic branch for SSSA on sparse repository.
> 
> Merge it when it is ready?

I've put it on hold for the moment.
The conversion of purely local vars was the easy job.
The real challenge is to do it for the other loads & stores
(in simplify_symbol_usage() & simplify_memops()).
I'm working on it and have some encouraging results:
- correct phi-nodes
- pass the test-suite
- no crashes in GCC test-suite and others
- no infinite loops
- no catastrophic performance on exceptional workoads
- roughly convert as much stores & loads as currently
- good performance (within 2-5% as rc5 on some workloads)
- in some case, surprising good effect on optimization

I don't know yet if keeping the Simple SSA during linearization
will be worth to keep or not.

> Right now I do wish the SSSA has the two options I request
> before.

I don't remember what was the other option you asked but keeping
both the old and the new method is not something I'm interested in.
We know that the current method is broken. In fact, it's broken in two
different ways:
- the phi-nodes are mis-placed (they are on the use site instead of the
  meet point).
- each phi-nodes have as many sources as there are definitions for this
  variable (more or less) instead of having one for each parents.

I also recently discovered that the logic for aliases is broken.
For example, code like:
	int foo(void)
	{
		int i = 1;
		int *a;
		int **p;
		
		a = &i;
		p = &a;
		*p[0] = 0;
		return i;
	}
is mis-compiled as it always returns 1 instead of 0
(it fails to see that *p[0] is aliased to i).

What I'm interested in is, in this order:
1) produce correct IR
2) convert as much loads & stores as currently
   (but only when it's correct to do it, of course)
3) have performance that is similar as we currently have

Point 2) is needed to avoid more false warnings during
context checking (and have a very significant effect on
performance).

-- Luc
