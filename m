Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838834CFCC;
	Thu, 19 Feb 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520039; cv=none; b=YNLdLs0/9+XalcxzOjPVmohz2cNmP0STJ8ZAvRlc8j8oEYgwDDqXEjgVkRIGodc84p258jNqzx3WpLdVlePIzHP5kXjwd76beYd4Rx5nFpfxYqU6UxpLZ6mbpvOivS55g02L9eJH7woy78vbvYcj3Lw3sObUb2DY0fc6yAS8QPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520039; c=relaxed/simple;
	bh=R+yxOfJWzyldqZrxkIZa7moHMk5aY5/cjb5oY25FmHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPPmqXVf4+NRgV0DvdZwrTVnttixp+pW1WbZuHR/itpkrE7Qyobx3pii+1epwR1xdDT4HxwzONugHzFVj32nPfds+TAPc9+gav/JNXLVW3NVYzG8UvF04VYNXaVlGF1x1auxjJ8DHP7eVr2liBW0YwDn2kTFkMiHabdFQkrq/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ4GkhDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ4GkhDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D3FC116D0;
	Thu, 19 Feb 2026 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771520038;
	bh=R+yxOfJWzyldqZrxkIZa7moHMk5aY5/cjb5oY25FmHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZ4GkhDLW6rT8TMWh4np3kQ/h16aX406Gwh06dQa3Hpx0i0ArFd+8Psftvl6BgAuL
	 eRXCxboKXDbMDVpHxPUrl+XW5c74mXN5I1HDd5K2A+lKFhBMkLCddW7AvmEM0tsGzG
	 voK4oyJqngNUju2hTZmyZfeAdKoND/HfDRmCyt+XXr47IoGwcOCR8NSPwXBDlsYL7C
	 STUGYD6o2L0YPnX8goACyLtARcmWZtuxZD+fHNfiKAEN8PZV3E/Yeh59+cfGfdLW/T
	 sqRSzFeReox7CsaoksoSONZ/2YSZMruSQPQfiR+tragwAaT5A7IY/Fj7EYgFQISyOV
	 QvmGR1+AKkSTQ==
Date: Thu, 19 Feb 2026 17:53:54 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Chris Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
Cc: Aaron Tomlin <atomlin@atomlin.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] builtin: mark __builtin_strlen() as integer constant
 expression
Message-ID: <aZc_NiSIjlZG7kly@macos>
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>

On 2026-02-19 17:10, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> Commit ae83f3b72621 ("module: Add compile-time check for embedded
> NUL characters") in the Linux kernel added static assert checks for
> __builtin_strlen() inside MODULE_INFO() macros. But sparse does not mark
> the result as CEF_SET_ICE during evaluation, making these assertions
> fail with:
> 
>     error: static assertion failed: "MODULE_INFO(...) contains embedded
>     NUL byte"
> 
> Fix by marking __builtin_strlen() as an integer constant expression at
> eval time. This matches other builtins like __builtin_constant_p() or
> __builtin_safe_p().
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: "Luck, Tony" <tony.luck@intel.com>
Reported-by: Eric Biggers <ebiggers@kernel.org>
 
