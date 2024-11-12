Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88E219CAB;
	Tue, 12 Nov 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443172; cv=none; b=LLQ6G5aTMho713Kd32DqsWcBwFwwD/wc7Zch19iq3RiGSsRPTcJ5Jx4cj0OaOoCq9E4S7kUwb23SWHR8IcmJobb8PT9Fu6KhvkogiOk3/aVUOlXiznLY+6qIDlTFRs8gYeCSXybbSp95SMII5CH5BxM6PO3JWL85xABqhEtWR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443172; c=relaxed/simple;
	bh=lpSX9AQd8tnAf/7uAuKcKFncAOMu9HHCLxUafBbmHUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHHETz5Ce5RF5hlB8JKIQ1DbTn21DDcJRTEDpNUSDZXSeL7DEfI8Kqw9YnI2kpreiKV9+V4yP0m/sH8kT2wMjhRwMn+VuTv+b6e5dnvP+SebxOi4Cvqqssav3xsdHNtJ4OUMrRI+B1aRJck6rWE6PI0SwLli22w+1gpKQI1UVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIIZgmbw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIIZgmbw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cdbe608b3so62962685ad.1;
        Tue, 12 Nov 2024 12:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731443171; x=1732047971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkM/qEq4y9oAmuugOBzErq6qYUQUI6HO1Srs3ZPkn7A=;
        b=dIIZgmbwW/kBuviZiBOUP/cx7/bqlijGWlam3HDF40sY1lzgBKJ6sTlDEH9KUxA1v3
         ciZgvR/5xYvuWBDFEs5EXSZfSVKphPvNaARg0HgBSdzH7C1sp1vTJes6p6mntkYX1dey
         E8dkrNMTc/zEgKalsL1JF4QL0Ix3UWxvduysw8oXebV2w1kuwufRVDEEJjqBk4X9IW5G
         m24wgXjZRel7RC/577UD5CBTkq8sbglGh26GBd24pdi5vtnPHN6FkQA0lP4J2eDOemMQ
         EPdQVyLDGVOotSgB+tMqP4Qi3tzro1ekc7l4PXHqL4GyvvS6YYuFbiy4du8NcoV/PdVO
         PL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731443171; x=1732047971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkM/qEq4y9oAmuugOBzErq6qYUQUI6HO1Srs3ZPkn7A=;
        b=t9dz8Q9apcrxDk6mqQexeiteifth4y0YJlIg0Gi/i6qeR+f0euwqtZwdAzZ4C0zDmE
         Gqe83XKuhWUB6dl2iqoi6X2aHTYSHLKW2xOIsd1nsemM6+Q4/VkgiRWD8rz4CcEUVFaG
         VXJ9rkjF5uiRbADmeN9BEObD2ErvJQLWb6iI/O61ONot/FhfEwEgC1BSkXpwSbAeW0Yb
         6RRNbkxQXUxfEOVRn6/4duGZXzgipbYl1EF6EbKdKeRgh0rJ6qsNX/IO/4QBlp/di6KG
         s3ImC5dzou+1Ta2xF03X5Ndw/7Y64p28cljWLZsOu3qlJtZu/S3kwj0osuC1AkdjqavP
         lgqg==
X-Forwarded-Encrypted: i=1; AJvYcCUIselxEq/7X67aCIivazCnurR83FqRLbHGD2Wo8x6LOv656A5sgrpB7GB9drQSqh/Ip8H+IoeimSSFgCM=@vger.kernel.org, AJvYcCVrllNXN406cRlaXqX41bMo7YdVIEsLdBWpS68cHauhJVwR/VcI1/u92UgGlPi8R40MDcNypQgJPRrCJCXb@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkwfHy8wnQmb+mD2WfKtIR4Ena7J0qqZwoAKgBnzGj93Tl5eA
	cDTvKKWe1A1Cu0D28w7HaNpgmA6yUzBe3ycyudqYVOkSzELKJJ0L
X-Google-Smtp-Source: AGHT+IFjeJp9WEWS9DcHgCU8gu4UzPOW6aZMIRJ/trd0B4BxoLvXv8tv1cW+1kX3L5m/kYsXbGYblw==
X-Received: by 2002:a17:903:22ce:b0:20f:ab4a:db2e with SMTP id d9443c01a7336-211ab980431mr47372805ad.29.1731443170569;
        Tue, 12 Nov 2024 12:26:10 -0800 (PST)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7cf8sm97026755ad.34.2024.11.12.12.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 12:26:10 -0800 (PST)
Date: Tue, 12 Nov 2024 12:26:07 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] compiler.h: add _static_assert()
Message-ID: <ZzO5390yVTqNbgJl@yury-ThinkPad>
References: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
 <20241112190840.601378-5-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112190840.601378-5-mailhol.vincent@wanadoo.fr>

On Wed, Nov 13, 2024 at 04:08:39AM +0900, Vincent Mailhol wrote:
> __builtin_constant_p() is known for not always being able to produce
> constant expression [1] which lead to the introduction of
> __is_constexpr() [2]. Because of its dependency on
> __builtin_constant_p(), statically_true() suffers from the same
> issues.
> 
> For example:
> 
>   void foo(int a)
>   {
>   	 /* fail on GCC */
>   	BUILD_BUG_ON_ZERO(statically_true(a));
> 
>   	 /* fail both clang and GCC */
>   	static char arr[statically_true(a) ? 1 : 2];
>   }
> 
> For the same reasons why __is_constexpr() was created to cover
> __builtin_constant_p() edge cases, __is_constexpr() can be used to
> resolve statically_true() limitations.
> 
> Note that, somehow, GCC is not always able to fold this:
> 
>   __is_constexpr(x) && (x)
> 
> It is OK in BUILD_BUG_ON_ZERO() but not in array declarations or in
> static_assert():
> 
>   void bar(int a)
>   {
>   	/* success */
>   	BUILD_BUG_ON_ZERO(__is_constexpr(a) && (a));
> 
>   	/* fail on GCC */
>   	static char arr[__is_constexpr(a) && (a) ? 1 : 2];
> 
>   	/* fail on GCC */
>   	static_assert(__is_constexpr(a) && (a));
>   }
> 
> Encapsulating the expression in a __builtin_choose_expr() switch
> resolves all these failed test.
> 
> Declare a new _statically_true() macro which, by making use of the
> __builtin_choose_expr() and __is_constexpr(x) combo, always produces a
> constant expression.

So, maybe name it const_true() then?
 
> It should be noted that statically_true() still produces better
> folding:
> 
>   statically_true(!(var * 8 % 8))
> 
> always evaluates to true even if var is unknown, whereas
> 
>   _statically_true(!(var * 8 % 8))
> 
> fails to fold the expression and return false.
> 
> For this reason, usage of _statically_true() be should the exception.
> Reflect in the documentation that _statically_true() is less powerful
> and that statically_true() is the overall preferred solution.
> 
> [1] __builtin_constant_p cannot resolve to const when optimizing
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
> 
> [2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Bonuses:
> 
>   - above examples, and a bit more:
> 
>       https://godbolt.org/z/zzqM1ajPj
> 
>   - a proof that statically_true() does better constant folding than _statically_true()
> 
>       https://godbolt.org/z/vK6KK4hMG
> ---
>  include/linux/compiler.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 4d4e23b6e3e7..c76db8b50202 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -308,6 +308,20 @@ static inline void *offset_to_ptr(const int *off)
>   */
>  #define statically_true(x) (__builtin_constant_p(x) && (x))
>  
> +/*
> + * Similar to statically_true() but produces a constant expression
> + *
> + * To be used in conjunction with macros, such as BUILD_BUG_ON_ZERO(),
> + * which require their input to be a constant expression and for which
> + * statically_true() would otherwise fail.
> + *
> + * This is a tradeoff: _statically_true() is less efficient at
> + * constant folding and will fail to optimize any expressions in which
> + * at least one of the subcomponent is not constant. For the general
> + * case, statically_true() is better.

I agree with Rasmus. Would be nice to have examples where should I use
one vs another right here in the comment.

> + */
> +#define _statically_true(x) __builtin_choose_expr(__is_constexpr(x), x, false)
> +
>  /*
>   * This is needed in functions which generate the stack canary, see
>   * arch/x86/kernel/smpboot.c::start_secondary() for an example.
> -- 
> 2.45.2
