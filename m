From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: Fwd: [problem] sparse llvm loop conditions
Date: Sat, 18 May 2013 20:42:03 +0200
Message-ID: <20130518184203.GE3154@debian.debian>
References: <CAOJsxLF351XvYE6Av3hxMsqXeu2nT4vRjbLgwNAguNLEfgLQvQ@mail.gmail.com>
 <50312093.5050207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:62812 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721Ab3ERSmI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 14:42:08 -0400
Received: from mailout-de.gmx.net ([10.1.76.20]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0M06gE-1UN46c2W1U-00uKsx for
 <linux-sparse@vger.kernel.org>; Sat, 18 May 2013 20:42:06 +0200
Content-Disposition: inline
In-Reply-To: <50312093.5050207@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

Hi Jeff, Pekka,

On Sun, Aug 19, 2012 at 01:21:23PM -0400, Jeff Garzik wrote:
> Here is a testcase that should get into the mailing list archives...
> 
> 	Jeff
> 
> 
> 
> 
> -------- Original Message --------
> Subject: [problem] sparse llvm loop conditions
> Date: Wed, 23 Nov 2011 08:56:25 +0200
> From: Pekka Enberg <penberg@kernel.org>
> To: Jeff Garzik <jeff@garzik.org>
> 
> Hi Jeff,
> 
> Have you seen this already?
> 
> [penberg@tux sparse]$ cat loop.c
> struct list_node {
> 	struct list_node *next;
> };
> 
> int foo(struct list_node *node)
> {
> 	int ret = 0;
> 	while (node) {
> 		node = node->next;
> 		ret++;
> 	}
> 	return ret;
> }
> [penberg@tux sparse]$ ./sparse-llvm loop.c
> loop.c:5:5: warning: symbol 'foo' was not declared. Should it be static?
> sparse-llvm: Instructions.cpp:730: void llvm::BranchInst::AssertOK():
> Assertion `getCondition()->getType()->isIntegerTy(1) && "May only
> branch on boolean predicates!"' failed.
> Aborted
> 
>                                 Pekka

With my patchset of today, sparse-llvm compiles this code. It turned out
that struct accesses didn't work, because the address computed for
load/store instructions didn't have the right LLVM type.

[ On a side note, array access doesn't work yet. ]

regards,
Jonathan
