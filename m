From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Fri, 8 Jun 2012 21:35:02 -0400
Message-ID: <AE56D25F-20CE-49E3-90F8-2D80CA8CE4C9@gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53215 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab2FIBfI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 21:35:08 -0400
Received: by yhmm54 with SMTP id m54so1717794yhm.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 18:35:07 -0700 (PDT)
In-Reply-To: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

I played with the new ->ctype in pseudo a little bit to generate LLVM IR.
It seems much easier to emit correct type at backend using ->ctype.

The code is available at:

git clone --recursive https://github.com/xiw/splay.git

Try `make' and `make check' if you have LLVM.

See example inputs in `test'.  Currently the generator works for simple
programs like md5.c (with -D_FORTIFY_SOURCE=0).

You can also find patches to sparse at:

https://github.com/xiw/sparse/compare/splay

- xi

On Jun 4, 2012, at 2:54 AM, Xi Wang wrote:

> This patchset tries to implement Chris's `counter RFC': adding ->ctype
> to pseudo, while removing ->type and ->size from instruction.  In this
> way, it provides easy access to type information for backend.
> 
> The first patch adds ->ctype to struct pseudo and doesn't touch struct
> instruction.  It could be applied alone if we really want backward
> compatibility.
> 
> The second patch does more destructive work.  It removes ->type and
> ->size from struct instruction and updates client uses.
> 
> The third patch updates sparse-llvm in a naive way, which should have
> been much simpler with the new ->ctype in pseudo.  I guess in some cases
> ->ctype is even necessary.  Consider the example below.
> 
> void foo(int x, ...);
> foo(1, 2, 3LL);
> 
> Is it possible to get the types of the 2nd and 3rd arguments in current
> code, which are simply PSEUDO_VAL?
> 
> Xi Wang (3):
>  add ->ctype to struct pseudo
>  remove ->type and ->size from struct instruction
>  sparse, llvm: sync with new struct instruction
> 
> cse.c         |    6 +--
> example.c     |   12 ++---
> flow.c        |   12 ++---
> linearize.c   |  147 +++++++++++++++++++++++++--------------------------------
> linearize.h   |   17 ++++---
> memops.c      |    4 +-
> simplify.c    |   24 +++++-----
> sparse-llvm.c |   50 ++++++++++----------
> sparse.c      |    2 +-
> unssa.c       |    3 +-
> 10 files changed, 131 insertions(+), 146 deletions(-)
> 
> -- 
> 1.7.9.5
> 

