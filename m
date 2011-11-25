From: Pekka Enberg <penberg@kernel.org>
Subject: Re: suggestion for Merging LLVM
Date: Fri, 25 Nov 2011 07:52:28 +0200
Message-ID: <1322200349.1428.127.camel@jaguar>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
	 <4ECB38B1.8020803@garzik.org> <1321941674.1428.124.camel@jaguar>
	 <CANeU7Q=4e_jtdE5OXpat9VFU_KpsLrGe4LYpmy=y9L3QyBQ3sg@mail.gmail.com>
	 <4ECEFC7E.5060905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:56509 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1KYFwc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 00:52:32 -0500
In-Reply-To: <4ECEFC7E.5060905@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

> On 11/24/2011 08:45 PM, Christopher Li wrote:
> > I am using llvm 2.9, I guess my llvm is too new?

On Thu, 2011-11-24 at 21:25 -0500, Jeff Garzik wrote:
> I would guess too-old.  I use a git checkout from the LLVM repo.

We require LLVM 3.0 which hasn't been released because of this API:

https://github.com/penberg/sparse-llvm/commit/ea97bb4c5221a9be275b2d93dc90354bd6081a8c

			Pekka

