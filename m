Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A002EC081;
	Fri, 16 Jan 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552100; cv=none; b=SlfEhm2wDjFcCg+PRULJXHx4/BNr1LonbQXFWduZyXwaZfju3mdOwOLVYM3JrnK+ncRUSZ2vzKfgaTGi02Dk2HakU0Y9MWwDI17Z/xHMe6Qk9t+OYCHijrUQ7e4dibqVQRwWZPHvSNsnJ+o+LDm0FFByiDUq9rdzJ+MDvTGa/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552100; c=relaxed/simple;
	bh=a7eKrKM6/YEWnFFl7qpOhJnegZBYhe/Z+RJ9vpLL8fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKcE04QmGYM5ty5aesTyDYQ1kWv3F5WVleKKhk7BLLrRZ28t4ZCa4sbppKcOHU252q40qhc2EvtgxoH+6/4jsCS7c/z6FoBHHtc3N7uoOFSnugfVquefg9I/NiunabPzyc+XKgeIcgDbG9fLeepkYT8Fy3tWep6EFqUhb7KPVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HTbZimV5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTbZimV5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TV1Jx+rEWvbUkCzd4vjjAcoIFqoWvhAI61VIjM4vfHc=; b=HTbZimV5Qmy4g5YdPxxGg7t3OV
	b6mvGeyq5CBxB29YH/sHGHT8WPl06gjP2esikJjrgoZ7NlqvF603qKSKyWEVfPC/MdZ37TyH4kq4x
	0S+uRN2C5g3dyN0Bi7ESEd2WAreGSg8Xve/Taq1mStGyHbamei10rkF19Bh59phVS2kRvAYzs8NUp
	Z1WjYtLlllMlEOfp24CmrPzYnapzLD2KcpIwhg6O/LrrTfjcAUHNNjOOivWY1EDtzh7JNe7StvcZw
	aNILJgaEroGXhOVebFVZXatMmrtOGPhXfqqXGzr7uZCPmYQx+affl8hU2YwEjH0npzssCT4XNnjBt
	GQcVDAZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgfBl-00000008ILg-3lkL;
	Fri, 16 Jan 2026 08:28:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F1F6830065D; Fri, 16 Jan 2026 09:28:12 +0100 (CET)
Date: Fri, 16 Jan 2026 09:28:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>, kernel test robot <lkp@intel.com>,
	Ian Rogers <irogers@google.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org, sparse@chrisli.org,
	linux-sparse@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [tip:timers/vdso 12/14] net/rds/ib_cm.c:96:35: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
Message-ID: <20260116082812.GH830755@noisy.programming.kicks-ass.net>
References: <202601150001.sKSN644a-lkp@intel.com>
 <87v7h23cb0.ffs@tglx>
 <20260115211120.GD831050@noisy.programming.kicks-ass.net>
 <CAHk-=wg9pxiKm3kcZ0XQrFvz6fFek_A1WGqRh9yeghx3pE2d3w@mail.gmail.com>
 <20260115213054.GF831050@noisy.programming.kicks-ass.net>
 <CAHk-=wgXxY4NTZW8rcrXqx3h=j+t2445VWccbpywXYdoL_V0qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgXxY4NTZW8rcrXqx3h=j+t2445VWccbpywXYdoL_V0qA@mail.gmail.com>

On Thu, Jan 15, 2026 at 03:03:52PM -0800, Linus Torvalds wrote:
> On Thu, 15 Jan 2026 at 13:31, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > GCC-14 :-/ The GCC-8.4 one was the function return value trick.
> 
> Right you are. And yeah, us moving on to gcc-14 as a minimum version
> is not imminent.
> 
> Still, while we can't force it, lots of distros are on gcc-15, so
> while we'd have the _Generic() macro as a fallback for older versions,
> at least most developers would hopefully get the nice clean modern
> __typeof_unqual__ thing...

Absolutely. I'll try and make it happen if tglx doesn't.
