Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC541DA319
	for <linux-sparse@vger.kernel.org>; Wed,  3 Jul 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020509; cv=none; b=M3a01PO42AwGIl/TAQwagd5eUTiklC8TRmiVDgmkQPu0H5uGXUw+tGtVZN8uptG4mg0UVbwhXzgwQ35nPK/XG+nnjF+SsBym3y1VBko8TLx5ptt4T2McR3MUt2BBbzIOWATLp+zGc1H2y/g0SVtI3yZzTQbhPUaqlje0UQU2xFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020509; c=relaxed/simple;
	bh=fIs1h9NvLWDkcTbOb1/hzSd0Knl/ZKGEZ2Mk3M55hwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji7UhX3Na/suCNWpI+zSPiVnbPR0PZXu+CsmjtfPS8mTWxme/KD4lyR/eoW2EVP5CaE61m2eHfsaNvPhabrMlU3vxUQbQf8ezIxiULwTNKkhTs0+cHJJNXJp9WP9SwixQnGpNLG9k85kAnLRYO8AmdN2Hy37bqnbYIonxFKXfvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F++Yb/fH; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F++Yb/fH"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d846aade6cso1196157b6e.0
        for <linux-sparse@vger.kernel.org>; Wed, 03 Jul 2024 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720020507; x=1720625307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVDV9z1WRLX7mGs8qKDciE7sLgewN2cWZV5ECTKgn9I=;
        b=F++Yb/fHNMxm4jYIrK04rG7s9o4FZWzAWo9VNkyXh2p16Pq0zgoX9EY4AeeoK27/sU
         ejo0D132DWGcCj3+YvQTBUHRswpt7fq+uBmjKz1qW0B+5HL0aR8ipHpcQKJqzCo0q5zW
         4qlHcRHObGmKyHsm0RhRcHXgZVMKrOHDEt79hinLch/FMtWcZSomb4nRiVrHU6L/J+s/
         hcvCFSMjjPuEt6PRzC8Zh6bMfY2VCsjzml+BR4OYOSk5yc3Ol279qWC1nib5cLJfSCF4
         +AEgD+caqOxb0qlFKMXfr3zgqZyxBNeV2smsNHf2n6zyaqq/IDpel3D4CkPgO7jxf0w2
         QWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720020507; x=1720625307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVDV9z1WRLX7mGs8qKDciE7sLgewN2cWZV5ECTKgn9I=;
        b=pcL3x6dcV3wz1amy5gBK1+tu/zl7szYlHi5WudXC4Whl+A5EXHxzjo5pEyNIt4lzaK
         4Cd/c/tUykIWYbzetmLNI0bz2YVbYUXd5qYxV/OWslzrGJbeBys1Mbi41x+PKGbzqYaE
         qWHcFICtkCCXPKPbyEBJX4AocWHDdk6CElI6wyRNqU6gnYOVzeGghlVdCBdJBMk2sTZJ
         1BZ+dHBxZkUZLPPwxp2t1zTK1BE4ZUHngYrgJ54KDQdDk83yPEI1NYsDvso4bZ1Rn89Z
         G0v9Pvgzc8vRo/pzlet5svL6nP/cEEJcueBaliruSLd2IIPTax/gukz0K33eAmizvoAO
         pR9w==
X-Forwarded-Encrypted: i=1; AJvYcCVgR7cVlnDx9MQE2rl3VALAvTvhriuzB6ai/1w6CYg0eS/lfx9S+X7P8mvfFPGAozteKrfWRoD6nLhc1M9fwRnBd0RE7bK/YY005p3W
X-Gm-Message-State: AOJu0YwjKirSkaVXLSLFjAFDSbRthNj3yL3jtS8mkWRpgAKGYHGWbvUh
	Pfgt0JH8+LTn56NV34l7dkZ9E8NUXJcVNuAn9Pq9iISwEV46nXs9TBFmNUBaCGY=
X-Google-Smtp-Source: AGHT+IEpWekugQX4rNJZrxqGs8f7WtNWIEGukAkHrmnJenlWBVcZ+K0oFVjL14/IJYcJpJD2kO9MbA==
X-Received: by 2002:a05:6870:d18d:b0:24f:f282:241b with SMTP id 586e51a60fabf-25db34babcemr10770126fac.33.1720020507017;
        Wed, 03 Jul 2024 08:28:27 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:5b79:ebe0:e3cb:2ba6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e37bd82sm2830498fac.52.2024.07.03.08.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:28:26 -0700 (PDT)
Date: Wed, 3 Jul 2024 17:28:24 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: dan.carpenter@oracle.com, 679652+tititiou36@users.noreply.github.com,
	linux-sparse@vger.kernel.org
Subject: Re: Spurious warning about using kzalloc instead of kmalloc
Message-ID: <957a021a-2f35-471d-8478-5bc9d8ead457@suswa.mountain>
References: <65fee38d-8b16-43b9-b16e-3afdc899a2cf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fee38d-8b16-43b9-b16e-3afdc899a2cf@opensource.cirrus.com>

On Wed, Jul 03, 2024 at 04:02:35PM +0100, Richard Fitzgerald wrote:
> As far as I can tell from the limited commit message and comments, the
> purpose of commit 6a74b670 ("Refactor and add new functions tested by
> check_kvmalloc_array_zero()") is to suggest that uses of __GFP_ZERO are
> replaced by the appropriate zeroing allocator, like kzalloc.
> 
> But this warning is being reported on the function
> cs_dsp_coeff_read_ctrl_raw() in drivers/firmware/cirrus/cs_dsp.c
> 
> That function does not have a __GFP_ZERO, the kmalloc is:
> 
> scratch = kmalloc(len, GFP_KERNEL | GFP_DMA);
> 
> and it is intentional to use kmalloc because the entire buffer is
> then overwritten, so it's inefficient to zero-fill it first.

Sorry about that.  To be honest, I don't look at those results because
it's a style issue and I tend to ignore those.  So I didn't see the
results were all wrong now.

The issue is that they redifined __GFP_ flags to be much more
complicated macros instead of just 0x001000 or whatever it was.

I've been meaning to fix this.  I'll disable the check_kvmalloc_array_zero()
check until it's fixed.  But really I need to fix this because I need to
know when GFP_ATOMIC is set.

Thanks for the bug report.

regards,
dan carpenter
