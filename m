Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719232B99D
	for <linux-sparse@vger.kernel.org>; Thu,  8 Jan 2026 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850895; cv=none; b=BNcV5VdXxnMAOWlpEUju5ypttvDm9XqwpsJtOFZ2P+yhOrvbjzVx7a+YCYWSqhNPh84XU3XSRW6KbxX9vm+CXaJJ9d/bMSSq9DPTE0T3+e8aHostHoZCsxdKhBDWBy7QsYAQyruhLeO8r+tnk1NitgTxGI6I72vQGPhxHV1C8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850895; c=relaxed/simple;
	bh=Z2Sm7Z0zaT+N48LWKDY6xMPY6+JNkta60ZzAge+7Fos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaoBzuBdqez0VNK5easvgZeJT6r1oR1pQeFE4KjFqKOujcITaeZODdpeJwSvZVIxvqjQAfqJ1rZtMIgEsddupzU/rwdE0CdP+/HEMa5C/J8Q1Eacc+FmofKQqyROL6ytA7W+JN3hJ4Z4+RaYTt6/3yfXv8WJ8CV+wSZ7nzyRsNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXZ0Fs9y; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXZ0Fs9y"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so2359657f8f.3
        for <linux-sparse@vger.kernel.org>; Wed, 07 Jan 2026 21:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767850890; x=1768455690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WUz7RzRexSy87/V0BLhyqkBBfzO5t5JG5xnYeilsMI=;
        b=NXZ0Fs9yExwhc9V9csqDeyoEF5rQyEjAjK8wpi+Us6xJcUodwtCjNLLwGP1cf1DBuj
         yW5dMEeQWqru1yrTCy0qHTzm0BMPuur/yls9BMUTN3wRft/rta3Wb4jLs4xSh1vcAIH1
         QiBlnBBjZ5DLYCeJWSLDSlAJT63BpfHGpoTA/Kc6qweqbaig5z5NXhBO0HuLmyeinEuP
         AixyggNyCa9BxOuDUBAuJwpiTqXQytGwi/LiuaA3cxFZ2KTB+4UUJCsjfRU/DlxKkCrs
         oHWhW8VoTjqgWE2+irvcp04Vn7L0sg2ngMFcoEGClQOnAgKoRqdJRZiAUWuGx06K5RPy
         0LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767850890; x=1768455690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WUz7RzRexSy87/V0BLhyqkBBfzO5t5JG5xnYeilsMI=;
        b=N+C4IYpE+l5b726v7uY1Z2NiDpe1FEsdHviiLPj8QIGRnlZn3/eWLZN/mJpZXPOuPF
         /BPdu9MtNDB6Cfe0drAIuW6wOUZOXvkq2r+hV69eLe9DUdTTNFgw556/EBzmxKFO3xCD
         GC/IsSsuosW1C8cjCARyEhp3EqOByME62xxbnPggQTYvsCj/81Oattkp91FvMuy8i0sD
         nMExG7oMk/+BtOSz5mWg1jGy0zhc3U/fSI3cxsQ0qwKFAqwxwcvp07wNhxd1MlehiQv/
         5ylZtUCmJWWCzRyjjjTDOFf7pP7LgHV8G+hTRVHP6imLueWdzcA7aOrHOjWhfi+LqSgJ
         0o1A==
X-Gm-Message-State: AOJu0Ywhb2zMzWPehkbzppmdI6OmsDT/jahytp8aPsYP8U7ciKN710Ad
	yLvSMtuwB2RWC3zLEnPbe/itPRzXjp11pgj2BgGHn94HGuSSy8Mu2Mc6XsTJQRFnHZo=
X-Gm-Gg: AY/fxX4XUZmb2m6E89fRDkwpwZdSYvV2kgq4FVLRt+ZtA84FhlXxmzsyZwEihuMxdiO
	VHX59YOwqvUfRts8J8gjg4L+Az+wL4PDOTEWEBboDkSyjt7EKQmegvOUO0JYBN0EM4AzXfEIkDH
	bXTJ/CVLXgzef8fakPPF6TsRTlj5lkX/8iINOgI02p5pssmqwraZDr2jPrMzsZO/W2d8Pmu6Dje
	a/DXB7ZsnRbk+A1TWuZvLStuFnEoeeh4++YwupIfMZ5l+bViuI47iSxBkjmisDowUQSp2pgBz2B
	WL0FzrUMNU322HIj4gWFccBeyTBg867uKjnN8KqIwDDMKecLMeCdCbJD+ssCS0OfCShSVv7uKas
	LYcOmx3ON3HLMHoYZxuThEvl/HOiIrSqzWP+GL1QH8sLdHUm4gmXhqnWNZzuLz3XyTAdtWljTA8
	ymsC7SJrqyzs1G9I9E
X-Google-Smtp-Source: AGHT+IFnswyDtxTToTuypP+LKhJd/MYtmmaU9VtGVzRjplis8pH2HWnIFDEmjgoFyw1ucF8Tp9sUtg==
X-Received: by 2002:a05:6000:2382:b0:430:fd69:9920 with SMTP id ffacd0b85a97d-432c37909cfmr5629098f8f.16.1767850889766;
        Wed, 07 Jan 2026 21:41:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5eesm14345393f8f.34.2026.01.07.21.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 21:41:29 -0800 (PST)
Date: Thu, 8 Jan 2026 08:41:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org
Subject: Re: issue with _Static_assert and __builtin()s
Message-ID: <aV9DhtIM7Z5ZmJRz@stanley.mountain>
References: <2943a1fd-1168-4043-bede-8f39cad4444b@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2943a1fd-1168-4043-bede-8f39cad4444b@codethink.co.uk>

On Wed, Jan 07, 2026 at 07:41:45PM +0000, Ben Dooks wrote:
> So I am looking at why the Linux kernel's check for nul characters
> in strings is causing errors out of sparse.
> 
> EG:
> drivers/md/dm.c:3813:1: error: bad constant expression
> drivers/md/dm.c:3814:1: error: bad constant expression
> drivers/md/dm.c:3816:1: error: bad constant expression
> drivers/md/dm.c:3817:1: error: bad constant expression
> 
> I've tracked it down to the sizeof(str) - 1 == __builtin_strlen(str)
> failing to be a good constant expression...
> 
> This is an example of the assert which isn't working:
> 
> _Static_assert(sizeof("moo") - 1 == __builtin_strlen("moo"), "nul!");
> 
> This does at least get past w/o warnings
> _Static_assert(__builtin_types_compatible_p(int, int), "doh!");
> 
> I've had a go at updating builtin.c to deal with __builtin_strlen()
> for a string constant (attached) but that's just changing the
> output to "error: bad integer constant expression" so not sure
> what I've missed here.
> 

Al has a fix for that.
https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?id=2634e39bf02697a18fece057208150362c985992

regards,
dan carpenter


