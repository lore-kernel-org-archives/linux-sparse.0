Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8E824BB
	for <linux-sparse@vger.kernel.org>; Wed,  4 Sep 2024 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725428392; cv=none; b=WsWVycikbD/Og6wXq2Q9czHQ53YJ2+rNEax4eDD1zqZMTnvveh1uT8jaOjXZfaT7z4kqGZrCBupyIQsCtCG+Dg63BDuJq7V33wjlUuvKeFs583sezWs+0TBzecZsSn0x5nv8jUT2lS1oT2b4w03wkPs/dvEai1YJoPkE5Eg6w9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725428392; c=relaxed/simple;
	bh=nnhIwY2u7o1V7vOw//GQ9erXlyrbJp+mLJ7gw6UHuAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+TDy+OXyK5UrJjO4LDnvBj+kEl8eBtP4c0JRN3n0TL/QeRfs/jgKJxzWx4ysO4wWWKsQWFTWhV1G5Lfr2xqZzo9MmoE4HP2kEd0LuAHpBdErFaI4Ya0EgmUD06KSBErATft0XfvTPtVNa/MvqUrdNK+Qz/N+YUzxqB9HWUx+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JuRt5Z37; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuRt5Z37"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42c7a49152aso42352285e9.2
        for <linux-sparse@vger.kernel.org>; Tue, 03 Sep 2024 22:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725428389; x=1726033189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRh+/TP0JEwE5mdrUeswu9P+i1T5h6zEuzd/EBL7aS8=;
        b=JuRt5Z37MIUmLSS0qHhUAJNenlq5Uy8cqRswTwJK5sXvUgSNarZzsQT5msTiX22A8h
         iXG263XqgXXHqep6jYjNiM21Gen+o1EdVZKUdamnqCr/uic0Ips+tN1lIFrokt72WxRd
         m2VOEproFV0EJ+2PBx18FkZlfLe2a68pMB5mPwOa9tTFQK8grC5SbplGDvvZ6TWsNiUm
         x68K4B6l+iT9p0ooms6g9XA2zwiiv3ZHaqp2HOAATzzFwP2aQMCDdbB4At70CaleqcIp
         2XETeINXKhahApzfZXIC7IV8lzHfHyFj7lM4AsQQtPL1983aVz47uEZWgRHWIN7kBmdg
         MiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725428389; x=1726033189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRh+/TP0JEwE5mdrUeswu9P+i1T5h6zEuzd/EBL7aS8=;
        b=EfMopwMK3ZlLQqARnSNxayHgpIzeXpsudqqbipUUHtoP3RkYDFQCXy/F4H7E9qdzz7
         Jt/SVbqJscOzJKvGUX/gzxQv5L79RA2RMwQ382xo85cSS0nQbJnL/ZryrORyvgr3UNw7
         0XRujzu57eazmXA6yreZBhWWuiGJdJWFJlyy5BAM5QW7vAG2sceWsQud0pUjPam0N3SR
         M3prBEndymfF8B1eYxa6O89MvUMH9fZ6i0ZNn5fVnRJ82wwpb50OthO0GMEhEUUoE1lc
         +1EUfWhW9GS2LsL+WConXjz9sPe9Qy9V+9AYadCshtw/oeDE610Oc2nmdllfXvrftwXx
         6mIw==
X-Gm-Message-State: AOJu0YzUBP6aZlUqAKXiRPY1EMs0nQA1crHTb+BFLX7kBIouwIYFZCb9
	vHV0gPN6WhypvmNJdG7w2RiXnkz0mQNqxLWdu9qdoBDRgSmVBMPj3LH5bnD3KWs=
X-Google-Smtp-Source: AGHT+IFbWmSS3neLY5ZjXvG+6zh0K8ShOeWaA8Nf0YQblBzKKvWdOKoJB3bMt45wfEqYPEHjQN8PRw==
X-Received: by 2002:a5d:5591:0:b0:374:c847:867 with SMTP id ffacd0b85a97d-374c8470b71mr7055597f8f.47.1725428388439;
        Tue, 03 Sep 2024 22:39:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4a5edsm15998161f8f.1.2024.09.03.22.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 22:39:47 -0700 (PDT)
Date: Wed, 4 Sep 2024 08:39:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: wuruilong <wuruilong@loongson.cn>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [ Patch 001 ] feature: add support for loongarch
Message-ID: <f687e64e-d653-46a3-a302-68aa4a021215@stanley.mountain>
References: <c35dc58e-444f-0809-67cc-113d6b4b29be@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c35dc58e-444f-0809-67cc-113d6b4b29be@loongson.cn>

On Fri, May 24, 2024 at 10:47:23AM +0800, wuruilong wrote:
> +const struct target target_loongarch64 = {
> +	.mach = MACH_LOONGARCH64,
> +	.bitness = ARCH_LP64,
> +
> +	.big_endian = 0,

No need to initialize things to zero.

> +	.unsigned_char = 1,

According to
https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html
"For all base ABI types of LoongArch, the char datatype is signed by default."
Is the webpage wrong?

> +	.has_int128 = 1,
> +
> +	.predefine = predefine_loongarch64,
> +};
> diff --git a/target.c b/target.c
> index 8ae22d74..0e075d59 100644
> --- a/target.c
> +++ b/target.c
> @@ -94,6 +94,7 @@ static const struct target *targets[] = {
>  	[MACH_PPC64] =		&target_ppc64,
>  	[MACH_RISCV32] =	&target_riscv32,
>  	[MACH_RISCV64] =	&target_riscv64,
> +	[MACH_LOONGARCH64] =    &target_loongarch64,
>  	[MACH_S390] =		&target_s390,
>  	[MACH_S390X] =		&target_s390x,
>  	[MACH_SH] =		&target_sh,
> @@ -112,29 +113,30 @@ enum machine target_parse(const char *name)
>  		enum machine mach;
>  		char bits;
>  	} archs[] = {
> -		{ "alpha",	MACH_ALPHA,	64, },
> -		{ "aarch64",	MACH_ARM64,	64, },
> -		{ "arm64",	MACH_ARM64,	64, },
> -		{ "arm",	MACH_ARM,	32, },
> -		{ "bfin",	MACH_BFIN,	32, },
> -		{ "h8300",	MACH_H8300,	32, },
> -		{ "i386",	MACH_I386,	32, },
> -		{ "m68k",	MACH_M68K,	32, },
> -		{ "microblaze",	MACH_MICROBLAZE,32, },
> -		{ "mips",	MACH_MIPS32,	0,  },
> -		{ "nds32",	MACH_NDS32,	32, },
> -		{ "nios2",	MACH_NIOS2,	32, },
> -		{ "openrisc",	MACH_OPENRISC,	32, },
> -		{ "powerpc",	MACH_PPC32,	0,  },
> -		{ "ppc",	MACH_PPC32,	0,  },
> -		{ "riscv",	MACH_RISCV32,	0,  },
> -		{ "s390x",	MACH_S390X,	64, },
> -		{ "s390",	MACH_S390,	32, },
> -		{ "sparc",	MACH_SPARC32,	0,  },
> -		{ "x86_64",	MACH_X86_64,	64, },
> -		{ "x86-64",	MACH_X86_64,	64, },
> -		{ "sh",		MACH_SH,	32, },
> -		{ "xtensa",	MACH_XTENSA,	32, },
> +		{ "alpha",	MACH_ALPHA,	 64, },
> +		{ "aarch64",	MACH_ARM64,	 64, },
> +		{ "arm64",	MACH_ARM64,	 64, },
> +		{ "arm",	MACH_ARM,	 32, },
> +		{ "bfin",	MACH_BFIN,	 32, },
> +		{ "h8300",	MACH_H8300,	 32, },
> +		{ "i386",	MACH_I386,	 32, },
> +		{ "loongarch64",MACH_LOONGARCH64,64, },

Add spaces after the commas, especially if we're going to re-indent the whole
table anyway.

regards,
dan carpenter


