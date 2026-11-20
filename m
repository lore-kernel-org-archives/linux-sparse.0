Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164151;
	b=evwznWduu3mCYR1yfFDHcqSPhnDKtB1VFgJNLfZOtOSD13EGlYHZv3uHX9zivJaRtOL1
	 SbxdNlbA6aVunWV8uub3zJOQ1jQP8Dj5uW53WzRtFYot0DsHkKZpva7Pj7Qn1BJKmdxUr
	 U50sUB0ovQZcTZ/yp2SC7NiIW+fBm1FzbKT0h0YFXEHQsZu5tpKGzgsLdXUiaRKvhWUbi
	 2PaE8OwazirIKFipXZfjZOfkdI2hMlePZvNSdA47yLrWfM+SER+cNtaaT35Gp1wGA44IG
	 dpabhk6hDAzx5HUuzcFnD4vWe7N405e+wGrWb7V8aow0I6nJwCDvVuKsuvS0Ksj1YIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164151;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=MY+oxUKoQugd/S5oAAs1/TwWjnjTL1j1G+yvMNXZIsU=;
	b=ycudyaYbyNnFE5IxAg7qNH5+s1iUC+pAZ1UHqR0S3eHuCSG/BxNMOvX6Y6NxbubGq3PN
	 r1ZMQzRYWQNmKf/6IzgrBGtCq5urD7GdJTfUJumRW+wBRrwZrrIadaLfXW9wmvkvN5zMp
	 3FPrE/qWHljRftQ0maTAJBnpf0hFcKhzX1S2/FlvYGDL1p+j6m59ihmD26sfIC54D8Tyr
	 /IJ/KAINB0d3+smzUpey6MHh1XmlH0zZEsOpv38z/r6VB1MMJ0eM5tTrHHpsbxkfLIumr
	 Xj9HKqUJPQ17HCM5r16UkXkUzRuseh0b/B0FR0ERPsLMpCSKI+B+k34j2eJOQ92A/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OnicW+vi;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2761606A320;
	Fri, 20 Nov 2026 08:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2761606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OnicW+vi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795164152; x=1826700152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IrEBIIlXXwQBB0sePvLkhBuzj8Fc9kf48o76TI2Zl+g=;
  b=OnicW+vi+f6p3kSmVZsXND4U4zzkiLnIEhdNAWceW0K7szcbX12eBxEm
   9lrajgzNCd+jnj0/pEYo3KxC7GIecx1r+2b08piRGNAnfhQIm2v0bUeqg
   rCEcw0v+wcxc8t1hP/jzI7kJw9jR3lrrnPJIvDRtaicgieKZmX3fBPSqg
   KuR5d0pc+Vli3bsy72XFgWVTjkXsLFBIbgwch8BH3pVX0ecVvAihLHZ3M
   gGYyRSWX3XvRxoyjmBWDzKwOYs8yfLzSVYA01BYDP9B880xtbIneZ4xFI
   ShPVVkaG1KdLrTLINew3BG1eLGH7csks7FFSvDKtkeY5wdhqmhXgmWOfz
   A==;
X-CSE-ConnectionGUID: CpvXl90SRS2sOuTWfdSf5w==
X-CSE-MsgGUID: /8msef/fT++o13i+NQTTpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3955683"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3955683"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 00:42:30 -0800
X-CSE-ConnectionGUID: RfUnov9dSVSiIGQk8vp0kw==
X-CSE-MsgGUID: wswL7jkQQJO8q8R5a199wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10534953"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 00:42:27 -0800
Date: Fri, 20 Nov 2026 10:42:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jonathan Cameron <jic23@kernel.org>, Chris Li <sparse@chrisli.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v1 1/1] bitmap: Refactor bitmap_read() and bitmap_write()
 to avoid too big shift
Message-ID: <awAH8F_UXdcftgV6@ashevche-desk.local>
References: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
 <av9eAde6AKlAKWaH@yury>
 <av9kOeZtIjOtH2yp@ashevche-desk.local>
 <av9ofhBTAcMJud_-@yury>
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
In-Reply-To: <av9ofhBTAcMJud_-@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 04:22:06PM -0500, Yury Norov wrote:
> On Thu, Nov 19, 2026 at 11:03:53PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 19, 2026 at 03:37:33PM -0500, Yury Norov wrote:
> > > On Thu, Nov 19, 2026 at 08:15:30PM +0100, Andy Shevchenko wrote:

...

> > > I guess... Let's keep the patch minimal?
> > > 
> > > > -	mask = BITMAP_LAST_WORD_MASK(nbits);
> > > > -	value &= mask;
> > > > -	offset = start % BITS_PER_LONG;
> > > > -	space = BITS_PER_LONG - offset;
> > > > -	fit = space >= nbits;
> > > 
> > > I don't like this 'fit' thing, and would like to drop it. But
> > > let's find a better motivation to do that?
> > 
> > Why? The fit keeps the check I want to refactor, since it makes it twice
> > the code with that ternary looks ugly and unreadable. This is exactly the
> > chance to kill two birds with one stone.
> 
> That's what I meant regarding the motivational part and minimizing the
> patch.

OK. So refactoring bitmap_write() to make it look like bitmap_read() can be
done after your nice below patch.

> From dfac9a524aa8658fe63c03804cca9f0980b58ef7 Mon Sep 17 00:00:00 2001
> From: Yury Norov <ynorov@nvidia.com>
> Date: Thu, 19 Nov 2026 16:03:21 -0500
> Subject: [PATCH] bitmap: Rephrase read and write bounds checks for sparse
> 
> Reword bitmap_read/write() conditionals such that it improves on code
> generation and performance.
> 
> Tested with minimal x86-64 kernels with GCC 15.2 and CONFIG_TEST_BITMAP=y.
> Run 400 fresh boots per kernel under virtme/KVM on a Core Ultra 7 268V,
> using one vCPU and 256 MiB RAM.
> 
>           Before, us      After, us   Change, us    t         p
>   Read    277.00 (6.99)   265.33 (17.05)   -4.21%   -12.695   2.97e-31
>   Write   496.96 (14.38)  488.56 (10.41)   -1.69%    -9.615   8.03e-20
> 
> Bloat-o-meter reports 60 fewer function bytes in vmlinux and in
> lib/test_bitmap.o:
> 
>   Function                       Before  After  Delta
>   test_bitmap_read_perf             234    227     -7
>   test_bitmap_write_perf            298    286    -12
>   test_bitmap_write_helper          880    872     -8
>   test_bitmap_read_write            800    767    -33
> 
> It also fixes the following sparse errors:
> 
>   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
>   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://lore.kernel.org/r/20261119191530.1716850-1-andriy.shevchenko@linux.intel.com

Should be Closes: tag.

-- 
With Best Regards,
Andy Shevchenko


