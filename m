Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514465;
	b=GdLMTom0yheX6f0PXV7Sm8JCeEnBQtyjGbDIpd9xPGEx4rsecT/V/rqBhjMpOlZNpB5F
	 TYjIJmbuP8v65p5pZW4Od+NcAizl5BqQrmQ+GyBbhGBSaiPtTS1+DpMV2id+pRlssL6Ta
	 SoyB9iNTrM2SYSM1Vqaz9PQrw0F6XuQPppQ65f3dYTim1Mb8IXqq4k9ryKR6APEvkvjPM
	 S1o2ayCYrvqOWBvstiIoLurVbJujQVt2mhU8qjCv2iUQz1yj4j+0HO3hMIdoH1SRTUXHK
	 s4Nv7A93DAWtDhbICvuIJxmtJo+HvYkohQKIW+DgRGIri/4Jc7uTF8kHHL2xTrSw5+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514465;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Zf9ESEgy1Yvb0BHjTagLxMnoCOgbiLUZ3kDaGMI2aC0=;
	b=hi/3e0CVGIQtoL3cVqmlIn980MFZ50mK0eL3RpF6Hi/R3L1+p2xHc8Kf2sM6Whz735F6
	 nwrHpQftGTbe6dau5KhrI0PZNKchlYjwWQSdS5Ftvb2hM3ts0XAce5iBeEpJvrFUA+ISo
	 cMvW1fxsDQaEDvdCS3abBGcwuRwyCuKj15iKiIYhaAyTJ6ZiXO3kiUH8rm2bnzswegOON
	 yyAMQ2dmS4LGuSV0c+pRDZLPJWxeWC4Y/x5Yd6YVAQXS0NwPNwOXzrhdWJDKd5az0KUtL
	 CDUmvaugC4i07yiI5eHWdqu2uI0YZ0P7L7n7FcMxAZU9zFExLmt7yDiHMjaDE/ATLGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L3jXIWAq;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04F606A31E;
	Tue, 24 Nov 2026 10:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D04F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L3jXIWAq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795514465; x=1827050465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eltag6jOZ8zeJgwzkIWJ40VcLJAp19NlWjNiKuJ8QlY=;
  b=L3jXIWAqRYQhwOkE1/XF1eOoyoTA/Zal08pjECmpIu0BWnEaA0C+nYjL
   wMI43Dgp/DD7yfV261rP0zGv+0KNu9h9nP2ei8Xu2MWZ1vE3bOkPv3L+z
   SImbgLRMo/F1n6KcnDccIsBSqWOaT9nUk3XkjHCb/zmNxbzfsRLS1zZ29
   q/hpndiFfLE/dkZuDqQRiEu2BOoGC0Ew5Asa585NLxFyQWDH+9TV4sZWc
   5ZXfqKNlwlluoUP6peeao1BqxcA8+gACVskMn4y+3KAxI6Hs4LDGA77fv
   llVbHckpEsjgy7pFQVh7rHsZtol0D8g/iks7eLUOm6X/mek4Nom9kPqa5
   g==;
X-CSE-ConnectionGUID: S6aHRbljTIqIe1f14ixqyQ==
X-CSE-MsgGUID: n9ysHJPbSo25lB9h9WFcrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4355697"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4355697"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:13:45 -0800
X-CSE-ConnectionGUID: n61VJSvpRo2frX89+RSoZg==
X-CSE-MsgGUID: FX+CTpqaRFujgeEjWD0HRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11834755"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:13:43 -0800
Date: Tue, 24 Nov 2026 11:13:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jonathan Cameron <jic23@kernel.org>, Chris Li <sparse@chrisli.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v1 1/1] bitmap: Refactor bitmap_read() and bitmap_write()
 to avoid too big shift
Message-ID: <awVVRTuvDLLVmRlS@ashevche-desk.local>
References: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
 <av9eAde6AKlAKWaH@yury>
 <av9kOeZtIjOtH2yp@ashevche-desk.local>
 <av9ofhBTAcMJud_-@yury>
 <awAH8F_UXdcftgV6@ashevche-desk.local>
 <awBcWKvDGV8sLcGu@yury>
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
In-Reply-To: <awBcWKvDGV8sLcGu@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 09:42:32AM -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 10:42:24AM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 19, 2026 at 04:22:06PM -0500, Yury Norov wrote:
> > > On Thu, Nov 19, 2026 at 11:03:53PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Nov 19, 2026 at 03:37:33PM -0500, Yury Norov wrote:
> > > > > On Thu, Nov 19, 2026 at 08:15:30PM +0100, Andy Shevchenko wrote:

...

> > > > > I guess... Let's keep the patch minimal?
> > > > > 
> > > > > > -	mask = BITMAP_LAST_WORD_MASK(nbits);
> > > > > > -	value &= mask;
> > > > > > -	offset = start % BITS_PER_LONG;
> > > > > > -	space = BITS_PER_LONG - offset;
> > > > > > -	fit = space >= nbits;
> > > > > 
> > > > > I don't like this 'fit' thing, and would like to drop it. But
> > > > > let's find a better motivation to do that?
> > > > 
> > > > Why? The fit keeps the check I want to refactor, since it makes it twice
> > > > the code with that ternary looks ugly and unreadable. This is exactly the
> > > > chance to kill two birds with one stone.
> > > 
> > > That's what I meant regarding the motivational part and minimizing the
> > > patch.
> > 
> > OK. So refactoring bitmap_write() to make it look like bitmap_read() can be
> > done after your nice below patch.
> 
> Sure, I'll take the patch with the tags suggested.

In the Linux Next it uses Link instead of Closes. Perhaps you still have
a chance to amend that?

> But you're very welcome to continue optimizing it - my gut feeling says we
> can squeeze a few more percents out of it with just a careful refactoring.

Sure, when I have time to look into this again.

-- 
With Best Regards,
Andy Shevchenko


