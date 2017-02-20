From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] arm64: traps: Mark __le16, __le32, __user variables
 properly
Date: Mon, 20 Feb 2017 22:33:45 +0100
Message-ID: <20170220213344.dqp4pzxr2dj6vbd3@macpro.local>
References: <20170217165112.17512-1-stephen.boyd@linaro.org>
 <20170219015808.2vc2kvpde7nlrey4@macbook.local>
 <148758047729.2988.16966413648865610904@sboyd-linaro>
 <20170220104947.GE9003@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34811 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdBTVdu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Feb 2017 16:33:50 -0500
Content-Disposition: inline
In-Reply-To: <20170220104947.GE9003@leverpostej>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, linux-sparse@vger.kernel.org

On Mon, Feb 20, 2017 at 10:49:47AM +0000, Mark Rutland wrote:
> On Mon, Feb 20, 2017 at 12:47:57AM -0800, Stephen Boyd wrote:
> > Quoting Luc Van Oostenryck (2017-02-18 17:58:09)
> > > On Fri, Feb 17, 2017 at 08:51:12AM -0800, Stephen Boyd wrote:
> > >  
> > > > arch/arm64/kernel/traps.c:567:10: warning: Initializer entry defined twice
> > > > arch/arm64/kernel/traps.c:568:10:   also defined here
> > > This one I find strange. Can you tell which are those two entries?
> > 
> > This is:
> > 
> >  static const char *esr_class_str[] = {
> >          [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
> >          [ESR_ELx_EC_UNKNOWN]            = "Unknown/Uncategorized",
> > 
> > where we initialize the entire array to an "unknown" value once, and
> > then fill in the known values after that. This isn't a very common
> > pattern, but it is used from time to time to avoid having lots of lines
> > to do the same thing.
> 
> FWIW, it's a fairly common trick for syscall tables, which is where I
> copied it from for the above. Certainly it's not that common elsewhere.
> 
> ...
> 
> It would be nice to make sparse aware of this somehow, even if it
> requires some annotation.
> 
> Thanks,
> Mark.

I just checked this and I'm not very sure what's best.
Sparse is very well aware of the '...' to specify a range
in an array initializer or in switch-case. The warning
is there only because those entries are later overridden
with some value.
When checking what GCC is doing in this situation is saw
that by default even in cases like:
	static in ref[] = {
		[1] = 1,
		[2] = 2,
	};
GCC doesn't issue a warning. You need to use the flag
-Woverride-init for that. But then you also have a warning
for our current case:
	static in foo[] = {
		[0 ... 3] = 1,
		[0] = 2,
	};

It's easy enough to patch sparse to not issue a warning when the
override concerns a range (which would be perfect for the situation here),
Controlled or not by a new warning flag. But I'm far from convinced
that all uses of such "ranged-initialization" is used for default values
that may be later overridden.

I'm also reluctant to introduce yet another special annotation.

Any thoughts anyone about what we woudl like?


Note: sparse is quite incomplete regarding these overridden entries
  since it issues a warning only when the override is on the first
  element of the range. In others words, the range itself is not
  taken in account. So, no warnigs for code like:
	static in foo[] = {
		[0 ... 3] = 1,
		[1] = 2,
	};


-- Luc Van Oostenryck
