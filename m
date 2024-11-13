Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB75201113;
	Wed, 13 Nov 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524037; cv=none; b=ZWZGT5BVelLVHMykRpWex99wA0Svsjgi/plTI8c3sh4fqkyR0OeeH3SyLdHW3FXt39mfvzWriY1P20ZQ/EhOoK4DfpUbAPqfGdDoYBJk5S3LrhOzT2tNhVHKKfD2S/yr/zKZ5BJXegJ5kle1UJaKumdeKdvVPtCoteWt0UpsIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524037; c=relaxed/simple;
	bh=26UKyLpMSJwFi9jKCccnJfhkmLQhgRY3nCK7eF2M/88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzrzrKBWp4cVB3Phyk2Pag98D+3DBDaNyzhQEz9X+1Y9rI2XWmI1jBYQsmhdACy7bx6MFrj5p6Z7H+ioGGVIsCRtiTqXFVzxHc7dGGzVpw85j92farbWaFDLJ1yGLP1YULdsnAKnxwgBEUPPXQAXBSweQq8UtgtPJz/H6F3DhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3hLobcf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3hLobcf"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cb47387ceso76940825ad.1;
        Wed, 13 Nov 2024 10:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731524036; x=1732128836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ml9JVjX+XuumbZnVZGc+spDnLYBbQ3KFdnBqv3IZEEk=;
        b=U3hLobcfkE+spbfmk5tz0/c7Bm+8HIQLcUj11vkX8tz1cQXN0yws211KQ8oESauIKA
         a8ZqFSE1Z7pF8qisz7TM/KoUI7OeWv0MKMGdgfkhvj5/wkqY78IkuB6bBKTxFodmlXp5
         giAxQYnGSZxrBA8bAP1Jsi1Pu5hSQXE9J6MqrE026gmMhVaFVfyphLNGe0FfvapQzLx/
         faVSEsUPntUCVwxWVBYgR36isLej4jOn5hj01d3khBhhxs8hL4RgcUhasQhkmb1cGcJd
         khMZCIxz4PCeKWudL8YdKqPjCVqzDh8w5ip1Tcamsl0dsuZEB9LL3mVZmmoddkBQN8xN
         7UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524036; x=1732128836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml9JVjX+XuumbZnVZGc+spDnLYBbQ3KFdnBqv3IZEEk=;
        b=EstcrhJtbkaZum4aOwukiGQjb4d+r0fvQYVa5kMj8V2/lTl+b6hzTHIFWVMzbKjX+Y
         xq01RTogddQW0KTraYsrbJrakpjP9oz501fjhFgxoJkH4xtdxepBNiXcyjVEQxfWGvss
         rTBGvKXWyhhzZ4aTNtcuBJ2jgLOxBael8RNaJ0RElUgKd/HYGOJ1Q+DwC+OGZ5vM+OEp
         1MoYFlsvRXFvJUVSj5PZCr9ccTXlpPH2js8iSSk2HqSHjnb9HOs12KXUBJ6JKNGLNrAl
         zyymoMnVs16nALw+XoS6I0xrU2A7KY2QPZH01pvCFipwEOaH1uEqUk4tF7+XKMag2yJD
         n3GA==
X-Forwarded-Encrypted: i=1; AJvYcCU10RQ8fCN3KPpLxmLsVTHzZkW/uXMEIHrVyoCDoPT0Ijn1n5eaWCcdWAmqS0PMvmWouuXaDhFFO0cCZZM=@vger.kernel.org, AJvYcCUBumDas9PqyMi9dnwcrX/HBFNxpDQdPaD/tdZ8NQyMcQn7X6MkW4ydLtIMGyy3PQMPDDEksmXzjBbivwRC@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdBK6Th2eqioKOeamzhr+Z3BNR3ukzxQ48cMqD8ZGAQVqzHs8
	/yxiMncaNcbwm5v6Ngs0OlRAcH2CP08VDPjl7zVUk/VFPlXowgfh
X-Google-Smtp-Source: AGHT+IEva+q3R3ovNCH2uvIpyDjxeTC00//9DQJGGOvGaAXAm/L8veN3g9iVF6DVECrPHCoOatBsDw==
X-Received: by 2002:a17:902:e750:b0:20e:57c8:6ab3 with SMTP id d9443c01a7336-211834e6e10mr259538815ad.4.1731524035570;
        Wed, 13 Nov 2024 10:53:55 -0800 (PST)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e44586sm113668825ad.165.2024.11.13.10.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:53:55 -0800 (PST)
Date: Wed, 13 Nov 2024 10:53:53 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
Message-ID: <ZzT1wZ-WQi8zuwqG@yury-ThinkPad>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>

On Thu, Nov 14, 2024 at 02:18:32AM +0900, Vincent Mailhol wrote:
> __builtin_constant_p() is known for not always being able to produce
> constant expression [1] which led to the introduction of
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
>   	 /* fail on both clang and GCC */
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
> It is OK in BUILD_BUG_ON_ZERO() but not in array declarations nor in
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
> resolves all these failed tests.
> 
> Define a new const_true() macro which, by making use of the
> __builtin_choose_expr() and __is_constexpr(x) combo, always produces a
> constant expression.
> 
> It should be noted that statically_true() is the only one able to fold
> tautologic expressions in which at least one on the operands is not a
> constant expression. For example:
> 
>   statically_true(true || var)
>   statically_true(var == var)
>   statically_true(var * 0 + 1)
>   statically_true(!(var * 8 % 4))
> 
> always evaluates to true, whereas all of these would be false under
> const_true() if var is not a constant expression [3].
> 
> For this reason, usage of const_true() be should the exception.
> Reflect in the documentation that const_true() is less powerful and
> that statically_true() is the overall preferred solution.
> 
> [1] __builtin_constant_p cannot resolve to const when optimizing
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
> 
> [2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
> Link: https://git.kernel.org/torvalds/c/3c8ba0d61d04
> 
> [3] https://godbolt.org/z/c61PMxqbK
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

For the series:

Reviewed-by: Yury Norov <yury.norov@gmail.com>

If no objections, I'll move it with my tree.

Thanks,
Yury

> ---
> Above examples, and a bit more:
> 
>       https://godbolt.org/z/11xnxfx3P
> ---
>  include/linux/compiler.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 4d4e23b6e3e7..f9d660b63765 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -308,6 +308,28 @@ static inline void *offset_to_ptr(const int *off)
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
> + * This is a trade-off: const_true() requires all its operands to be
> + * compile time constants. Else, it would always returns false even on
> + * the most trivial cases like:
> + *
> + *   true || non_const_var
> + *
> + * On the opposite, statically_true() is able to fold more complex
> + * tautologies and will return true on expressions such as:
> + *
> + *   !(non_const_var * 8 % 4)
> + *
> + * For the general case, statically_true() is better.
> + */
> +#define const_true(x) __builtin_choose_expr(__is_constexpr(x), x, false)
> +
>  /*
>   * This is needed in functions which generate the stack canary, see
>   * arch/x86/kernel/smpboot.c::start_secondary() for an example.
> -- 
> 2.45.2
