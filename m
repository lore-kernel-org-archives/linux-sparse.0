Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9D3AEF46
	for <linux-sparse@vger.kernel.org>; Mon,  4 May 2026 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895801; cv=none; b=Fbpn3midrZjEOeWN15GKHElf0x3Dtr+2qE8pezbqa4zDd9zNZrRyH6g2tu0grjM0nw/hgM0oXDTj7sOUknSI3AzOjtN/XPJ2EGVAlPKiDQc/zz5D52PHO5KaQKDZwKU58v5PSAd+lSCxCGv1D3NOTChLOBfhoDyGPNTsyJnM6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895801; c=relaxed/simple;
	bh=yjz1YbXdU14Rp4kQMlzccfgBXY7gs9goodGB1ANIRhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2/rckZsneCS4htegopaLZzg8j5lltv5QVLBQWI4G60dkY0GQIDAjZ9hQiJkz1NJ6t4lD6LjMZzUFOOQybCNeNXkoqNNeMZAaquPqXOWv0igShQD9paSkmp39ow4SVZaO6wC9DLTyZfvqyOOjuTO4tFG8trEashPF5qfFM454Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQVOO8Ho; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQVOO8Ho"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so38316295e9.2
        for <linux-sparse@vger.kernel.org>; Mon, 04 May 2026 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777895798; x=1778500598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Xkw7iC7E6x1qx1tLPRawwDMf//SquM3ge9CW59ixCo=;
        b=LQVOO8HodAHbGauIU+eYghVzTcn0JjKKWCj2aM4jYgcUN24LWkwI/yWTpnfFO7qxb6
         FsWTBiM/txroeAth4WRcHPoZYYUJfh2qZ59ymugPw8U4r1SCjJoXl697qEm4YGmji+AQ
         QIZINfE+Y1zaORBAkCOqFFQgItTLvYGP666bW478zDt0uRpsVZ570Sj7AIRwZ/Fz2LmW
         GpqlOeNK0WvUnzZ5gg1E9eFf7K7VCJKYm5hhe1exNosjYT6MeuUrAT5jDfUxuatWfR4l
         K5/23AzoR7NvlvNJ5yoOvao4xVou14rInr2V3T975AqOFBe85AU0k2MJCMwK6blDcegv
         Soiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777895798; x=1778500598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xkw7iC7E6x1qx1tLPRawwDMf//SquM3ge9CW59ixCo=;
        b=SGrSyTDEnMfjrH3+SLBASHNW6sKh+zCNxIyt+DxHDCxbX9wcP6xC7HbKn5WsY9tCwS
         TeW5k+StPnel362CXc9zSw0Kc0t7dkhbq9gja2NE2LxY9gKg0cKHM+yV1zlIbIcSvI8h
         0xq3E4ygzSrIqkERrc+ZplHbhMRzTCreP5dwm4rkii1y+X9Urc+lHi3hO7viU+qU+0BV
         ibqD/1tzuGme0XlCka04JaqvaoB7XEQD/xQpKBC+sDOjWD5rbtukriOv19ZgJABDIedj
         FMcrdM35lw+axJZBkfX7JkvZNs/kyDVMqJsKV2r6q3BVr0yoTiHDCcWeM49XVW94dt65
         rTNw==
X-Gm-Message-State: AOJu0YxsK6yxoGcaL35KVGQ2+Gs0xwW5BU1V47tOn83YDEe+9Uzpeph7
	kPs7oEpAuCcvVdg+wIe14OxjrKch8L514YidHi8gi270Vr1B6CODfihd
X-Gm-Gg: AeBDievFHlK4DbbI/7kT5h3zVdL29pE9NfsQd19Gmv+hmEdsh8xJknu/N07RP/uOaFX
	cp+WV9HEVC4RaDFeBSOgGuhJ2N7zvliyXqeTh/5LRsC4Pi+SDuvCOUN+ENuTJJJLZL0OVMkEXgT
	LuYhKiz1KHsX871c3jbdZzizovRsZJcy7wy/YngTghFcF/VIolTGfR4I+6gOnP4FtYIKHtwVVHw
	5IPylMg0NYG6t2EDv3nMcAJ3kR+zici6iugcKFw7hVIH5rURjgsjSqiQ/fnBrMb7VKYU9via+5r
	qGgeUJaMEq/0mB0u7T56Go1wxkc7qt7Dxx1BUvLzH259KtAl6AcVdsXRKHn6tvZPLXeI0XoJkr0
	6wP/mYJz811hC52RHw5sKQVNAiHIIZmLYOP1cuZ6cS17ch73s+QVHiq0vb56GlIdaV47u9+0gmm
	QChGZB8nS3cm6zY2zifs3bbOVkZIgjjg==
X-Received: by 2002:a05:600c:8590:b0:489:1f3e:5f6f with SMTP id 5b1f17b1804b1-48a98636c00mr110638725e9.12.1777895798019;
        Mon, 04 May 2026 04:56:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981defbfsm27052843f8f.17.2026.05.04.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 04:56:37 -0700 (PDT)
Date: Mon, 4 May 2026 14:56:34 +0300
From: Dan Carpenter <error27@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, chriscli@google.com,
	torvalds@linux-foundation.org, zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk, dan.carpenter@linaro.org,
	rf@opensource.cirrus.com,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 16/21] __VA_OPT__: parsing
Message-ID: <afiJclAklquVsgpA@stanley.mountain>
References: <20260316065622.GA607739@ZenIV>
 <20260316070415.768839-1-viro@zeniv.linux.org.uk>
 <20260316070415.768839-16-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260316070415.768839-16-viro@zeniv.linux.org.uk>

On Mon, Mar 16, 2026 at 07:04:10AM +0000, Al Viro wrote:
> +static struct token *parse_expansion(struct token *expansion, struct ident *name)
> +{
> +	int slots = macro_nargs + (macro_vararg < 0);
> +	struct arg_state args[slots] = {};
                         ^^^^^^^^^^^^^^^^

Hi Al,

gcc-11 and gcc-12 don't allow variable length arrays with an initializer.
The compile fails with:

pre-process.c: In function ‘parse_expansion’:
pre-process.c:1513:16: error: variable-sized object may not be initialized
 1513 |         struct arg_state args[slots] = {};
      |                ^~~~~~~~~
make: *** [Makefile:263: pre-process.o] Error 1
make: *** Waiting for unfinished jobs....

It works in gcc-13 and later.

regards,
dan carpenter

