Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164680;
	b=0sdqceg+OJYpNTvZNmUWp4LOnAj6aLvN4Uk9aC4wdXgin2se7tjatGhrHNi5hx9wOIpU
	 Uvfvo+4v3j146buuPslAc8aSJkD4hbjtQDHfEqtLf1soKqDIBlBIG7frmrITS+x9Qr8x9
	 +HgtwelGBsbZd8Sbo8bcGGF6BtyQhIx4JWAmscCV8bMqFL7W5p3jl8S785nu+vNdZPFLm
	 cxT6SXN1Z93iRpaxYrYVlUvt/zAmBx6WWEoRv8/dOvcjpAIJzOAT2L+jsVW74hBg7U2Ui
	 bxcMK+XykvdgdC5+CaA8LFP2/aF0a4ZO/QaFlVVAEr4Ys15q/cLujr/6iCTBs8eAeYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164680;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=npQOpvLx9mz/35YSRQVZScpd97DdXxbaEPZoFWdQ9a4=;
	b=WlUh/7a1jxpSnhCFZZcQ8u8aSro4EI1iJ34IRx2J1J6hlWSt2xDEopM2vNPfTzMguuZU
	 e36OdMeHKA/3T4Ju2pbGod4/pHJtwMTChQGLzkInaGal/PMeb8Xo1TDjiA97egQKKij7/
	 iOlLkOFlRkyHFgmMIRP5pu0ulceb30xoRaktyRdRWHOqW/k9uv9vDen5IqBJJsUdJfq2a
	 /iwmLB/3DeswDglHtbmc9jwrZcMQAkzYZ0j2M90YAUWNBumNPpgjNUkUVrEqHHVYOXFw2
	 FIKzSFnacSzsJce/phWSWPVCo4Rm5tfrbzY2AGG6wGnJDAPNVMG/bEVQ7dy40/9z8tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iPz50o70;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020A606A320;
	Fri, 20 Nov 2026 08:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A020A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iPz50o70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795164680; x=1826700680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aXkvqofRpVrW9o4sYYFTxw3uZK1qaKkQ5DOvn5M5O6Q=;
  b=iPz50o70eiN+JRQ4+0x2DNaxE7BoI0/QPIW8MfrN2f+CpbvWkNO5XoeU
   Uv0cRnv9etNeYG8rAF1DCX/5BfY29Hg4a+a3nSlcYXuYFHAw06lagevRU
   bj2u4QyWu6VP8c5Ml51yctmpG01XT6cb1rEIpIJXJvLu1Y3LRHSXqOBNZ
   XEP9YPQWAr82bMh4O2HMFbD0ZgRvNqh9xxm2wjMQhdVdegdEd2IFxBH6O
   DG8FB6m5uJtO9JY4gsazS/kohyB6tv/zK/bgUOEk/nS3iuZaXwln/iNeD
   6VW3aT5QCblYHnbLBaWK9tPIz/QPYnBiMwWbcV33Ob37tj9DcYQIOYM6e
   Q==;
X-CSE-ConnectionGUID: ZZPACSHnQxS468+m5DnFMA==
X-CSE-MsgGUID: 50trmNxoTPqyoPCkbflyJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4046791"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4046791"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 00:51:19 -0800
X-CSE-ConnectionGUID: z3KBz45cQW6tTZWpHARFEw==
X-CSE-MsgGUID: Qljbd4s+Ql6z5ExaGR0uig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="11083328"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 00:51:16 -0800
Date: Fri, 20 Nov 2026 10:51:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jonathan Cameron <jic23@kernel.org>, Chris Li <sparse@chrisli.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v1 1/1] bitmap: Refactor bitmap_read() and bitmap_write()
 to avoid too big shift
Message-ID: <awAKAkVQeeHLemdN@ashevche-desk.local>
References: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
 <av9eAde6AKlAKWaH@yury>
 <av9kOeZtIjOtH2yp@ashevche-desk.local>
 <av9ofhBTAcMJud_-@yury>
 <awAH8F_UXdcftgV6@ashevche-desk.local>
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
In-Reply-To: <awAH8F_UXdcftgV6@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 10:42:29AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 19, 2026 at 04:22:06PM -0500, Yury Norov wrote:
> > On Thu, Nov 19, 2026 at 11:03:53PM +0200, Andy Shevchenko wrote:

...

> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Link: https://lore.kernel.org/r/20261119191530.1716850-1-andriy.shevchenko@linux.intel.com
> 
> Should be Closes: tag.

Thinking of this more, you should probably add Reported-by: Jonathan and the
link I mentioned in my patch and drop this one.

-- 
With Best Regards,
Andy Shevchenko


