Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601661;
	b=K0Nni0kQOJLgvdWFe8ZwRS1yfTSyaT3pYRTeYCJuWZ84+df5o8Y9II4/ALRumr2n324C
	 0F16JdKJmEIblCgLreb/xzEJDFVRkqYNVINzfkPWjQWpovO6mTb+JesXn47UWAOXFCIDr
	 GYFzWCQmtkzKCXMDnkj8LJqke0uiDgL2PK8mmQ8uXdWA1kW/4pZvvkhHrF2u0Bj98Cr2R
	 eIHs6R/pJnaIRwGLIkk0vTMlowu4nuRzyooiV7wDrECM4vMgPw4eX9UnAcXCq1KYCT8fU
	 rkuKu3lMzcv8GKQgDVfhScsA8lr/Ecs4AkbRWhT/X5X6d1qfP/ZvYiuIAhtDxtQlElg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601661;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cCgIeqmwajgAENm02p0+BguGGWrXzASusocqKPOdC5I=;
	b=raA5SXDBOH2WkNSpFP1SJT2YZ4Yvg1A5l5oFzeqmsXkid9ntOTREEJjbulvedVJMHyhR
	 WOnm3QgRDnvUVoDtLk3cIDj24HRlAoefymNJcqpF5nqrzuzyxkRuGy0ai25hqaR0zOgq+
	 kJsHQMnv+jctj9+YxZDTtOxR4tGfVNWskzu3pCpiVkmlkrLoUH7Tfi7fV/m63y2ehoqcA
	 8qz6gWRFvbWolPL53I27q1GIsF2RHN8u6nTzt26B1Lz4bxkXD5XFY0KTdNpm+fxDJlWZD
	 2ITKh6XzkFFreac0A0RuRvLPzd8d1yiXWh+CBQZRZSiPiGA0Op9mKrdql86Fjr4jfbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X8TYWU3D;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02E606A31E;
	Wed, 25 Nov 2026 10:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B02E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X8TYWU3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795601661; x=1827137661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h8dygzyqBHVc00IeGQ0f5PXOPycY3S17RwceHzLTayQ=;
  b=X8TYWU3DC5enh2go+nDQNavLderf5/0yixXcaRBenOO/FznVHE1Hbb2L
   6r4m9KE3Ars7/9iURuF/cYmuCqRIK+gRercftZJ7hVZeO7OahO7i03O9D
   1EruNZHbvW1bdYwY+y8YltaYdgW1bqP76VRsou0NPHgQz1zZVLj0FqWw+
   7bjRgmOyxtEV2hjzBrZiIQ+5v6sQoYyhMQvwkngTh4l1mj4/NI+3Q3jYS
   9PCwZoxfCrRUU1BLWNgD9bQ8FjsuDjcUiow1EfkAfK9EsHgStuEAw3c01
   dbIFtT95wQJNW03ljfMSEkoKcjjIx0GhNk4P/o5sieejmjJqVoucubSXP
   Q==;
X-CSE-ConnectionGUID: JKfl2ZbRS8OKF+HRYerTkg==
X-CSE-MsgGUID: UjfAwhNpTJWk9g9uN6twkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4350558"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4350558"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:14:20 -0800
X-CSE-ConnectionGUID: r0BcEdeRTBuTHE8m44ezYA==
X-CSE-MsgGUID: 9nOvwjP9TBWxI8aOlBvf6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="13612691"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:14:17 -0800
Date: Wed, 25 Nov 2026 12:14:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jonathan Cameron <jic23@kernel.org>, Chris Li <sparse@chrisli.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v1 1/1] bitmap: Refactor bitmap_read() and bitmap_write()
 to avoid too big shift
Message-ID: <awa09y84SBNYKLhC@ashevche-desk.local>
References: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
 <av9eAde6AKlAKWaH@yury>
 <av9kOeZtIjOtH2yp@ashevche-desk.local>
 <av9ofhBTAcMJud_-@yury>
 <awAH8F_UXdcftgV6@ashevche-desk.local>
 <awBcWKvDGV8sLcGu@yury>
 <awVVRTuvDLLVmRlS@ashevche-desk.local>
 <awXABlb61Bq3NKID@yury>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awXABlb61Bq3NKID@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 03:57:25PM -0500, Yury Norov wrote:
> On Tue, Nov 24, 2026 at 11:13:41AM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 20, 2026 at 09:42:32AM -0500, Yury Norov wrote:
> > > On Fri, Nov 20, 2026 at 10:42:24AM +0200, Andy Shevchenko wrote:
> > > > On Thu, Nov 19, 2026 at 04:22:06PM -0500, Yury Norov wrote:
> > > > > On Thu, Nov 19, 2026 at 11:03:53PM +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Nov 19, 2026 at 03:37:33PM -0500, Yury Norov wrote:
> > > > > > > On Thu, Nov 19, 2026 at 08:15:30PM +0100, Andy Shevchenko wrote:

...

> > > > > > > I guess... Let's keep the patch minimal?
> > > > > > > 
> > > > > > > > -	mask = BITMAP_LAST_WORD_MASK(nbits);
> > > > > > > > -	value &= mask;
> > > > > > > > -	offset = start % BITS_PER_LONG;
> > > > > > > > -	space = BITS_PER_LONG - offset;
> > > > > > > > -	fit = space >= nbits;
> > > > > > > 
> > > > > > > I don't like this 'fit' thing, and would like to drop it. But
> > > > > > > let's find a better motivation to do that?
> > > > > > 
> > > > > > Why? The fit keeps the check I want to refactor, since it makes it twice
> > > > > > the code with that ternary looks ugly and unreadable. This is exactly the
> > > > > > chance to kill two birds with one stone.
> > > > > 
> > > > > That's what I meant regarding the motivational part and minimizing the
> > > > > patch.
> > > > 
> > > > OK. So refactoring bitmap_write() to make it look like bitmap_read() can be
> > > > done after your nice below patch.
> > > 
> > > Sure, I'll take the patch with the tags suggested.
> > 
> > In the Linux Next it uses Link instead of Closes. Perhaps you still have
> > a chance to amend that?
> 
> It's not a fix, nothing to close.

> The patch is not about comforting sparse. Mentioning it in the commit
> log is there to *highlight* the problem to sparse people, not to 'fix'
> the kernel against that false positive report.

OK!

-- 
With Best Regards,
Andy Shevchenko


