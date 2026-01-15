Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6560EEA8;
	Thu, 15 Jan 2026 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512664; cv=none; b=Qz/MApQu/Hn8cvvcSoiCwz/B7AgbQNVcsCOgVNDWHx/KJJ03PDGKRiZ08m8A8T3ch6b/mgonTi2Cxz+dGb+Rj559yES4UGUxlneqDKMDyLM0EEIAVFbinY7Z3BxJmNq2WFq4s2qa6QOoHUKg8T7Ua9CHkqramrQorcdl8mwWpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512664; c=relaxed/simple;
	bh=wWdi1yjzITr/KyeB35zzyJq2Nt+yrxqjCmmCrZIelKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVL2/kQ1kdNvQ4tcVuD4a24Ezik24jF0gleoE6A4Tb8X/7Ga30Dz6SyzevSq399dDet+2LQO7Ci9RPImfE68hUwel6XF/dAQolyUSncpQRIIpiUjNrSZzqoGdt5QM08JvezuxaQAMSHArMP3GFdEDZ6wa4xQf2T0J7zqhEijDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qyfZJm61; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qyfZJm61"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wWdi1yjzITr/KyeB35zzyJq2Nt+yrxqjCmmCrZIelKo=; b=qyfZJm61wo8lm4z3OuFfosea4Z
	O8Vw0fb3KCo9odHXhgCzNJJ5IzPmSeMh5gMmn4O7GvqpRg/l/AAkmEFr3osM0YPolUPPXVsGHX6TI
	k8jkIKHkaDR/Uss+Ut17oy13kUxM+QeVHqUD2UTZTp6uTPEtGV7NGIYWvKeAnGC4QziZ67w9/DXy1
	+GEmenKQyE5861w3fMtt+x8U5FG2SlD2u+0aiKwaOIAzMx3bIW+u/OcutwZKqE/vxDVXAf0Nlap9F
	kj0yR5itWZuljtjotAFOPOjcVFejiaQGQNe9kThT81aD1MxEyX8RF9/s37VKod8lNV8WX9xCcSmWT
	msWsuwHA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgUvf-00000007fnq-0N3a;
	Thu, 15 Jan 2026 21:30:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9B05F3003C4; Thu, 15 Jan 2026 22:30:54 +0100 (CET)
Date: Thu, 15 Jan 2026 22:30:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>, kernel test robot <lkp@intel.com>,
	Ian Rogers <irogers@google.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org, sparse@chrisli.org,
	linux-sparse@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [tip:timers/vdso 12/14] net/rds/ib_cm.c:96:35: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
Message-ID: <20260115213054.GF831050@noisy.programming.kicks-ass.net>
References: <202601150001.sKSN644a-lkp@intel.com>
 <87v7h23cb0.ffs@tglx>
 <20260115211120.GD831050@noisy.programming.kicks-ass.net>
 <CAHk-=wg9pxiKm3kcZ0XQrFvz6fFek_A1WGqRh9yeghx3pE2d3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9pxiKm3kcZ0XQrFvz6fFek_A1WGqRh9yeghx3pE2d3w@mail.gmail.com>

On Thu, Jan 15, 2026 at 01:19:14PM -0800, Linus Torvalds wrote:

> Eventually we can just force that everywhere, but as Al pointed out in
> another thread, we're not quite there yet (ie we'd need clang-19.0.1
> and gcc-8.4 to be able to just switch entirely over to
> __typeof_unqual__).

GCC-14 :-/ The GCC-8.4 one was the function return value trick.
