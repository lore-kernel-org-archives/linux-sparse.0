Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F33164B8
	for <linux-sparse@vger.kernel.org>; Wed,  7 Jan 2026 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818546; cv=none; b=TPEdOdviOxgVe8crAz8bMZKkD4WnsCFiJY+ZnC3r7SEfwVP8F74i0Urv4idSVTRrkK0yPRXqA7yHVuasD/qKQANFsCi7B2rd7JKuA3EkGo46Z655JW0+dRYXbdOczM1TgZ2nXJguy1gn8Ul7yrDD3I2P6dGiyKWq+FGNSRJNz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818546; c=relaxed/simple;
	bh=5BJ12JfDhRA0NZgXp03WDhFurJJmrexK+3YaTrT2YKQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OSngWQjnEHvYezW+HEZqYvCTkacCXMHiHBzbjvtDuIiDD2lWwN8V+GUk94E/I3lPyMoDzJr7PHV6ErSOVXAbR5PTti+QSFH+AY1uKB8F3M42oEKD9rliZl+rqZ0s4vyJO0/ZyS58krXJdtzY7BXwxj3g2BHHggIuBvIREBlgYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9WXeM9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9WXeM9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575F9C4CEF1;
	Wed,  7 Jan 2026 20:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818545;
	bh=5BJ12JfDhRA0NZgXp03WDhFurJJmrexK+3YaTrT2YKQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=l9WXeM9wABP/DNLhQ0WsiEHf4dd1oCEJx47OgCxFyKh8ExkbOdz6VvaDTb6AWc6p+
	 o5TWKuZfFNPVvMySD+f4lCz82cbqQp2SCnbEJ9QDrMPNzoms5MEPuzxYMSG8Kn+kZF
	 sxe4xaIYV9gGweY15DblCXumc8AC0xLKmX2dpgHgMRr0pW0+QhpeLaD5ITRQLLXJmd
	 uZKhrK32gHZCH9QBIZ0QNbA7Xxuvg6iQrpXkLUcIcptI5FZrdM9Fut42uig52yqwLk
	 tJ2aCYDhKIA6O9dbYskPUk2jT3PmDhYI350bI/QrfU/7z8uFTpLuDI076J8APZISSn
	 jPMWzwhzFBjXQ==
Date: Wed, 7 Jan 2026 13:42:24 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH 2/2] RISC-V: restart extension search on match
In-Reply-To: <20260102114449.535597-3-ben.dooks@codethink.co.uk>
Message-ID: <a273a46c-c90b-3895-c019-09a624ba43a4@kernel.org>
References: <20260102114449.535597-1-ben.dooks@codethink.co.uk> <20260102114449.535597-3-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 Jan 2026, Ben Dooks wrote:

> If we are passed multiple extensions in -march, don't assume these will
> be in any sort of order. If we do match, then restart the loop by setting
> the search back to 0, and retrying.
> 
> This sorts out issues with the current kernel build where there are now
> lots of extensions for the rv64i and even adding zacas doesn't silence the
> warnings generated.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  target-riscv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target-riscv.c b/target-riscv.c
> index 80c25285..ddf50e61 100644
> --- a/target-riscv.c
> +++ b/target-riscv.c
> @@ -56,7 +56,7 @@ static void parse_march_riscv(const char *arg)
>  
>  	// Each -march=.. options entirely overrides previous ones
>  	riscv_flags = 0;
> -
> +	

Looks like some horizontal whitespace was inadvertently added here.

>  	for (i = 0; i < ARRAY_SIZE(basic_sets); i++) {
>  		const char *pat = basic_sets[i].pattern;
>  		size_t len = strlen(pat);
> @@ -80,6 +80,7 @@ ext:
>  		if (!strncmp(arg, pat, len)) {
>  			riscv_flags |= extensions[i].flags;
>  			arg += len;
> +			i = 0;
>  		}
>  	}
>  	if (arg[0])


Tested-by: Paul Walmsley <pjw@kernel.org>


- Paul
