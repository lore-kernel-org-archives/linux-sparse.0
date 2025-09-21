Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617651AAA1B;
	Sun, 21 Sep 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475820; cv=none; b=TT47Xnl0IOlm2jUctC1Nt7snT6M9EMCfLOH+n0nZQOafx80Izzq4d5j4ZHmvrDNqVZaFIaRGHXKC1mPUBhlNaPW9s5sEFeZykMVYKKXnOS9B7XxIuI27LjixOwKEsBz0hK5kun+uQI2pDYNzHqwlAC854E+iF8PHhICrqDbHd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475820; c=relaxed/simple;
	bh=gCSeR+8zNyI86Ou3aAV5m265kk19xZHGyGCTeo0FqZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzBIStXsBn1mYBD+JaxJOAK+NjCbphNHGKQxihTkqDY0cvwLv5tFmfTzAW/EuZ9euBMmhITKHvfFvgyuNKOWh+Nz8Wekjq/2C8iB7jzGxM/7wIDlYV7Z2xYsJNewhk6Ao3ZfO/O5eigtcu16j9hDRGPVIrPZBwi5uEGYd0A1M80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQhOWMv7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQhOWMv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB97C4CEE7;
	Sun, 21 Sep 2025 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758475820;
	bh=gCSeR+8zNyI86Ou3aAV5m265kk19xZHGyGCTeo0FqZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQhOWMv7yP1lrvep97m5vFfdqSqeGL00ZM3hZk/tC4fiatV4ThjOoOh9nW/JYpAHs
	 q6SSL9oG0J0wvdEK0M2tK7nIoG+pzwprKM+u7zXcfRNXl7lk8Hx/JkBf/qPbhRbCDE
	 E160hpPxV4ruN/G7AcHLivAVjMWh7Tfurk/V+RRI=
Date: Sun, 21 Sep 2025 19:30:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Farber, Eliav" <farbere@amazon.com>
Cc: "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sj@kernel.org" <sj@kernel.org>,
	"David.Laight@aculab.com" <David.Laight@aculab.com>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Chocron, Jonathan" <jonnyc@amazon.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/7 5.10.y] tracing: Define the is_signed_type() macro
 once
Message-ID: <2025092123-arming-tannery-c17e@gregkh>
References: <20250916212259.48517-1-farbere@amazon.com>
 <20250916212259.48517-2-farbere@amazon.com>
 <2025091717-snowflake-subtract-40f7@gregkh>
 <91da8ce3e4fb4a8991876a3ed130a873@amazon.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91da8ce3e4fb4a8991876a3ed130a873@amazon.com>

On Wed, Sep 17, 2025 at 10:37:31AM +0000, Farber, Eliav wrote:
> > On Tue, Sep 16, 2025 at 09:22:53PM +0000, Eliav Farber wrote:
> > > From: Bart Van Assche <bvanassche@acm.org>
> > >
> > > commit 92d23c6e94157739b997cacce151586a0d07bb8a upstream.
> >
> > This is only in 6.1, and not other trees, why is it needed here?
> 
> It exists also in 5.15:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/overflow.h?h=v5.15.193&id=ed6e37e30826b12572636c6bbfe6319233690c90

What?  Ugh, duplicate commit ids.  What a mess :(

Fair enough, I can take this, and I want to, but as this really causes a
problem with our scripts, perhaps use the git id that is references in
the other kernel versions as well so that things don't look totally
wrong?

thanks,

greg k-h
