From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] add support for GCC's __auto_type
Date: Wed, 25 Mar 2020 02:39:20 +0100
Message-ID: <20200325013920.ynrmmrnkcqyupdmm@ltop.local>
References: <20200324095711.84902-1-luc.vanoostenryck@gmail.com>
 <42f2b610-4a89-c4c5-2291-228610b01868@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37821 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgCYBjX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 24 Mar 2020 21:39:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id d1so812690wmb.2
        for <linux-sparse@vger.kernel.org>; Tue, 24 Mar 2020 18:39:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <42f2b610-4a89-c4c5-2291-228610b01868@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Mar 25, 2020 at 12:37:22AM +0000, Ramsay Jones wrote:
> On 24/03/2020 09:57, Luc Van Oostenryck wrote:
> > Despite the similarity with typeof, the approach taken here
> > is relatively different. A specific symbol type (SYM_TYPEOF)
> > is not used, instead a new flag is added to decl_state, another
> > one in the declared symbol and a new internal type is used:
> > 'autotype_ctype'. It's this new internal type that will be
> > resolved to the definitive type at evalution time.
> > 
> > It seems to be working pretty well, maybe because it
> > hasn't been tested well enough.
> 
> I haven't tested this (yet) either, but it looks good from what I see
> in my email client! ;-) (I deleted my Linux repo many years ago, because
> I was always over 90+% used on my disk - and I was only using it as a
> 'large' repo to test git!).

Yes, its size become interesting ;) 
But it shouldn't contain (yet) an occurence of __auto_type so
it wouldn't help here.

> BTW, I recently upgraded an 32-bit Linux Mint 18.3 to 19.2 using a
> 'nuke and pave' procedure, rather than the 'upgrade path' provided
> by Linux Mint. As part of that, I backed up my $HOME directory from
> 18.3 and 'restored' it to the new 19.2 (so far, so good). When I built
> sparse (before installing llvm), the test-suite failed all of the
> 'backend/' tests. Given that these tests should have been SKIPed, since
> sparse-llvm was disabled, I was a little surprised.
> 
> I am sure that you will have guessed by now, that I had an sparse-llvm
> executable from 18.3 laying around, ... :-D

For a moment you worried because I understood it as if it was
one in your PATH or so and this shouldn't be called from the
testsuite. But yes, it could happen if it comes from an old build
in the current directory.

> I thought about sending a patch to the Makefile to always include the
> sparse-llvm program in the clean target (it wouldn't hurt being in the
> 'rm' invocation twice), but decided that this is unlikely to happen very
> often, so ...

Mmmm, yes, it wouldn't hurt.
We could also do something like:

	ifeq ($(HAVE_LLVM),yes)
	... stuff ...
	else
	CLEAN += sparse-llvm
	endif

which has the advantage to not have to keep elsewhere the list
of extra targets for cleaning and keeping these things together.

> BTW, I noticed that we don't install 'sparse-llvm-dis' or 'sparsei' as
> part of the 'llvm programs' - should we?

I don't think so.
I only added sparse-llvm-dis to debug sparse-llvm and when sparsei
was added it also wasn't installed, for the same reason I think,
they're just dev tools. Now, if sparse-llvm would be more complete
and would more commonly used then yes, maybe.

In my opinion, none of the tools that depends on an external library
should be installed by default. Each of them should be, for the
distros, a separate package (like some distros do/did for inspect).

Keep safe,
-- Luc
