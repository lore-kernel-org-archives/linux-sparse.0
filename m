Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122238;
	b=vAKy1WErz+jSCNRAgyvY2JHOWJmHwsKlyOhfbQDKgji8A3/LWgJeZrF/3LpxxOKyX1eZ
	 HNgNAeit+yiKQeq/jOZMy8ALdnYs6gP/ARVIEt9TT53wZwkZiDc86+SApfO2llsA3jogf
	 HvEAq0lbWpwSNLRn/E9b2lAHKxX6++dXLCEf8NtggmMAVl7newJ7T/JUQ3WkFrDa/KV4T
	 BGsxmYBE//QQc3EffSaluKQDbWQyHXP8btq46qOt7GVVlI71IKABycSB3eWviX8tGeyXt
	 GHV7mYgxdRYKhjFSMVquzILRPHElNYNXsa7cVdolfqsTvgL6AixGjx04cJhPZ4449aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122238;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=90I65/Dz1QamvDXNasEB5EA/JB8aTuL2zGGmEUACUaE=;
	b=QGQQ2197wfhFy3LsqEDe/xtMW7zei6/wbO/Fc48JVB8CmT6lxC9Z74A5TUsFjUsStelV
	 6BO+FRQMx7khEGb2aqCFuxX2NWDAGvhyAWnA6j7sXes/Us8t/Jj0sL0ZwWbRjsG0X9WEl
	 kgE47Pn4N2qTSEEL4pjtl/pdqRvG6RIFeHTnQv4n7O78t5OeYDRzWptB1GyhcPfnIag+D
	 elesRKR3PKfF2Pg77jCjWq4Afx9FPAM8dGEeikfaPDoY6e72njz0rZwuC8a9r1wDs4GJK
	 ZZ6r2wjEYXqtmUVHmRlLAsByj+GUoIrbBsYOrxRwOCKsuC2cflEw1+nDG2ewrObML0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WriIaX2k;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812C606A32A;
	Thu, 19 Nov 2026 21:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0812C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WriIaX2k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795122238; x=1826658238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qf5f9LReJuzl61a6lPQnekjE6E43Myt/TBw5PZ8ZOq8=;
  b=WriIaX2kMsQGo3P5oq8DeanIBpNvAPzx8q2L1mHNOtTbQE9PN6vTuXoD
   9aUCKlAFR1eIUAhpRaUd6sQnLhOZ1uBXkVzr7JYGwUzRDyGsZ+0eFWpsI
   +m54pyAmabZJiQATDr+R6XnslGlgcJmYQld3TkHyKNDOcP00D4wZuMsGH
   +bVmHJDN/VCcOCsxJ+QnyWfKomY0J282x/+G+1hijyfl9KZqGXgSQe9ZB
   jNucpuLClvRHte9EUZSx7fhv10o7qHv1b+VC39WzVjFn05xK6A7lULzRo
   1ozAUQdMNaOk3mCA5+MJLeJqS1XXr/R5E6eKAMVu5tgybx6OwjQuQCnii
   g==;
X-CSE-ConnectionGUID: IuaQgbXATrGDanrRoXXXFQ==
X-CSE-MsgGUID: ahxoXkTOTdy+XHdZTp0r/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4009196"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4009196"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 13:03:58 -0800
X-CSE-ConnectionGUID: aP20gYk9RDaFKJPuc3Z2UA==
X-CSE-MsgGUID: zfSopLW4Tna2zRRRLAyh+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10617102"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 13:03:56 -0800
Date: Thu, 19 Nov 2026 23:03:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jonathan Cameron <jic23@kernel.org>, Chris Li <sparse@chrisli.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v1 1/1] bitmap: Refactor bitmap_read() and bitmap_write()
 to avoid too big shift
Message-ID: <av9kOeZtIjOtH2yp@ashevche-desk.local>
References: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
 <av9eAde6AKlAKWaH@yury>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av9eAde6AKlAKWaH@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:37:33PM -0500, Yury Norov wrote:
> On Thu, Nov 19, 2026 at 08:15:30PM +0100, Andy Shevchenko wrote:

Thanks for review, my answers below.

> > While compiling ad4691.c I have noticed the following warnings:
> > 
> >   drivers/iio/adc/ad4691.c: note: in included file:
> >   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
> >   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
> > 
> > Since the bitmap_read() is called with statically define 'start',
> > the 'space' local variable becomes equal to BITS_PER_LONG, or 64 on
> > 64-bit machines. The 'nbits' parameter is coming from the run-time
> > defined value. Static analyser doesn't see that the right shift
> > by 64-bit can't happen — the space >= nbits check guards that.
> > While Jonathan put it as false positive [1], we still can give a hint
> > to it without growing in the code (`bloat-o-meter` for above mentioned
> > driver shows no difference in size). So this is what this change does.
> 
> Jonathan put it right.
> 
> If the analyzer (assuming sparse?) throws false positives, we don't
> need to change the kernel. This is simply a wrong motivation. We need
> to improve sparse instead.
> 
> Otherwise, the kernel will become a collection of hacks for various
> poorly written tools. Let's do it the other way, please.

I agree in general. However, we can sometimes give hints without breaking the code.
Now, thinking of this, the mentioned check can be done against offset leaving code
generation and sparse happy and have no unneeded bulk.

> > For completeness, bitmap_write() is also refactored in the similar manner.
> > I have also checked a few users of it and `bloat-o-meter` showed no change.

...

> > -	if (space >= nbits)
> > +	if (space >= nbits || offset == 0)
> >  		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
> 
> So, doubling the number of conditions, and the new one duplicates the
> existing check. This version suppresses sparse false positive:
> 
>         if (offset <= BITS_PER_LONG - nbits)

Yes, you beat me up to it. I just was thinking about similar check in the above
comment.

> And even with that I'm not sure we need to touch the kernel to make
> sparse or whatever else tool happy...

It might take ages for sparse to fix even more annoying issues (if you remember
something related to cleanup or alike change in the kernel and sparse was
lagging for weeks).

...

> >  	size_t index;
> > -	unsigned long offset;
> > -	unsigned long space;
> > -	unsigned long mask;
> > -	bool fit;
> > +	unsigned long offset = start % BITS_PER_LONG;
> > +	unsigned long space = BITS_PER_LONG - offset;
> >  
> >  	if (unlikely(!nbits || nbits > BITS_PER_LONG))
> >  		return;
> 
> Initialization of local variables before the sanity check
> may become useless waste of cycles if this sanity fails.

How? they are not used and function is marked as always inline. I believe
optimisation in the compiler does the right thing.

> This is also not necessarily needed for sparse happiness,

This is to make both look similar at a glance.

> I guess... Let's keep the patch minimal?
> 
> > -	mask = BITMAP_LAST_WORD_MASK(nbits);
> > -	value &= mask;
> > -	offset = start % BITS_PER_LONG;
> > -	space = BITS_PER_LONG - offset;
> > -	fit = space >= nbits;
> 
> I don't like this 'fit' thing, and would like to drop it. But
> let's find a better motivation to do that?

Why? The fit keeps the check I want to refactor, since it makes it twice
the code with that ternary looks ugly and unreadable. This is exactly the
chance to kill two birds with one stone.

-- 
With Best Regards,
Andy Shevchenko


