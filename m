Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF902311946
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007334; cv=none; b=iQdFjFPLCKwUA0LnchPpbfY1060VEH8+ReoqWu4zVpy555cwaHGysxd/WswaroIauqKZwZQRFg0UaX+5XclXujSUvd1gQCyRPJBegNC6KLwVCMc/XFhKOmh2zJCBZRd5xIFDfl/0UXcWqAsExxlqDJroZHJAbUT+dL4wV298bUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007334; c=relaxed/simple;
	bh=b0IWS/Bv9HIrN/QIceN9IKsqWKFjysW6PbjVYvsdR2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwVBBGRGLLaRISqeWjljrClUgNNIyJ0wvdLgaTUgObGbH6vZaXteN05v2ElE4bIDvw51pw2gOAiwb6TrGVMLLyzW15nG6qeVa7pllxVTcJLwOPm95au6pk4O65NIvJe2Wj2xB/g3sbNAPtelcPHHLZsYZ5eeOi+avd0pOIiv4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L25QmQjR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L25QmQjR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4837907f535so57015185e9.3
        for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 00:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772007331; x=1772612131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X225D5Ei9UC4pV2nV6End/Mxx7XQa7ZRi+IwmSgqyvo=;
        b=L25QmQjRkcbvBVS3COx+x5bhfHndBxlQqRWb3XVVCq2dOKmuUc6EZjrlxjrHMVrulr
         4x0wUOWRghl3QMSDxsizai73st4XXqu3Xd31yfxTDhP0bS4iPD93GjTI3y4CD32x/8Mz
         5xHQI2KdfsWylaxN4nGVjB/XLjmUfPxfd0SX106mVK5c0elkNZ0gSiDNnb+lu3xNHy2b
         FPG7dx6JTDjpUeqFna6OnWx+8c047pX6mHwOIU1Zn6wdeqgzfvZoI5I9uiYS3bsF2JWq
         U0DOdg/oGg7DwFdkWWL/2Mz3G0Jbs/LB5pqPqLtyDZLS2ZYXsBu9sPRuLNSxonjkq1op
         QBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772007331; x=1772612131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X225D5Ei9UC4pV2nV6End/Mxx7XQa7ZRi+IwmSgqyvo=;
        b=tga9/KTCU1N2FpaSGhTK4ccWRqKLGD6K578JeWNsAU81cbdueJjDEC4FqW/Sd2Kw2/
         eMV6QTbIjpn4UcoWa1Rmk59DNzWpdfhxw/1eR0IvpZeFM2nF0YRmKc7j9GNX7/4I60Dt
         c0wJTaOWNb6o0aMu2rLg7Rih0wj17Z8Qj9I/JcVElh0tpD2TjVFCPl5w6PlyqFkYwK5d
         kSZFYyXz8r6uZGrVaUEQzFFsNvKxJCGbQG/u34HtNWhlE4MGPzQAxiRtA3I2ZRjF5MH0
         tLyF2oz5JfZUcDifrvnejqKrFLTagJHwSUu/Q55YamfMc+brIztssrsI96W1VCpjGUwD
         BlvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAqECqcz9Rzv94ICp0uYYRO27xskT9GmF1h+JNDoFAjiGcD2yhtgqMNXYFqN+FLX8riPQvDvd7Hqtfq1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WIZ8nOYxJ7h5JiJKgWZRmC+UqQ4DcZYd8+77LIkY5LdYH9LI
	4VMEzCAVm7golLCg7eA9RihIHOzkgMdDmxEP0SwobOgqgQJMQX46b1jav6AUR4aeihk=
X-Gm-Gg: ATEYQzwOOe47QmnYdE4tjRvY0gOZDZE8nPOHwYNu1OplQZ7DpPz0l8p7rHCmoLtcWj3
	ZkPsHW9Lpd4NPEn2SpOa38Wp9l5INMWnfSsDwKZ+KzKN0w6gCBzhPfu3Tm1brh3CGotn6J3Uyk8
	d/mzsUwE0g86icOBySBfQHVotqb80LYs2WDVTtpUKxNzGHR0iBR8sQiETYdSmIq4fQR5t7QvNOP
	puKSQdUVzBYGtyJ2APBX2DY9svpiSF+/JQtFdh/UCVMlbOEcfj5edKVIr10sEbfODQJgjOlFadU
	IV4t/tMOLip9tw1N2koaqvmUZ+Ke+e2KdtVPo5kaBmslYa3vnnG1Wi3IfcBwFQSVy+mKhQ0IHoX
	CYUrUqOntJt+GORMFjpPW5uHc1kiKVaKyeOjH5GIB98NTZREv/0apzRBnro0sr3BB/S4gXYjp6I
	HehdDW5w61L0KHoF1bQiEJZDMmHrnhc3OgGIzwemQ=
X-Received: by 2002:a05:600c:4e14:b0:483:702f:4641 with SMTP id 5b1f17b1804b1-483bef19d37mr25321705e9.3.1772007331299;
        Wed, 25 Feb 2026 00:15:31 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7507adsm60197395e9.9.2026.02.25.00.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 00:15:30 -0800 (PST)
Date: Wed, 25 Feb 2026 11:15:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>, Ian Rogers <irogers@google.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, sparse@chrisli.org, linux-sparse@vger.kernel.org,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH] compiler: Use __typeof_unqual__() for
 __unqual_scalar_typeof()
Message-ID: <aZ6vn1NrIkv4UXFW@stanley.mountain>
References: <202601150001.sKSN644a-lkp@intel.com>
 <87v7h23cb0.ffs@tglx>
 <20260115211120.GD831050@noisy.programming.kicks-ass.net>
 <87ms2e32gw.ffs@tglx>
 <87jyxh3ike.ffs@tglx>
 <87ecnp2zh3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecnp2zh3.ffs@tglx>

On Fri, Jan 16, 2026 at 07:18:16PM +0100, Thomas Gleixner wrote:
> --- a/Makefile
> +++ b/Makefile
> @@ -1178,6 +1178,14 @@ ifdef CONFIG_CC_IS_CLANG
>  KBUILD_USERLDFLAGS += --ld-path=$(LD)
>  endif
>  
> +# Validate the checker is available and functional
> +ifneq ($(KBUILD_CHECKSRC), 0)
> +  ifneq ($(shell $(srctree)/scripts/checker-valid.sh $(CHECK)), 1)
> +    $(warning C=$(KBUILD_CHECKSRC) specified, but $(CHECK) is not available or not up to date)
> +    KBUILD_CHECKSRC = 0
> +  endif
> +endif
> +

This means we can't run "CHECK="valgrind smatch -p=kernel" because
valgrind always prints output to stderr.  So hopefully we can
eventually remove this check.

regards,
dan carpenter

