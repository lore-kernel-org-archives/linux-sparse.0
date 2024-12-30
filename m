Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638A12CD88;
	Mon, 30 Dec 2024 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583545; cv=none; b=RdYEBI3TppjFTk9FhBy2kyFLoUoHPFor7g1H7gIV3689nKHd0RzPOhW48bIwsjnKRW1WSzv1ae/j3TGvlN2FZjWDeJKShroJw9gzJOivupyRUstiit5R1/krnXZxr3Zj4W2qdiKiVa0B4jK8efTF5Ms2e6AzkMvZ3akeNaUr0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583545; c=relaxed/simple;
	bh=yrQodZsGdppDyRZaCUNZnCpQrZCViTjTaQqC0VgBJtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqFKXos0BN9+Th0yzFMrr8teFRVmNpiAM3Ycq4tUQ51hFppfogfzmsycPh0xzSib3OelZrkjdBshOOo+wrND8THrqDJEemxZkvYp3K1vDndYPMGAJ1ALomRruPGiH/A7po/GfnlzhWrwQkQx5ZJTV1jPW0JzffDLkGIjRjbkDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZEzxjvi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZEzxjvi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso9714063a91.3;
        Mon, 30 Dec 2024 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735583543; x=1736188343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8C6jCalhhG+62TtuQXkt+4wgmWWrxOuGdJcyKYwdnQ4=;
        b=nZEzxjviId7SD5S3IBfqSUWPAfc8DtkcVbx4XDTYWBulQj2fgzhUJsnFkPNpAN4VVg
         zqMgWNXGRjHWdjFqiYmXFobZFsWTSHA4zYqyMO1vDTkhYzj2kyV4VBy+J7GKorbZXqtl
         6ttcF9LBWzBi2JXtII3An9TDQLhuWN04y5IK99Q6hoXZYhONxEBVpVd2qKDy6viittla
         M+X/kfBP9ev6+c7k82PVdTyTB8Iw743wEncm+VIj4+T62VUd37bzAEEUYt3uSxIW1Np3
         WUnP1scMP1a81CpMcG9jEjQjByGTzIVAbHT3JpUe9aCvE3E5LnIvtuhKQ6+b2AZLQDuc
         i5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735583543; x=1736188343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C6jCalhhG+62TtuQXkt+4wgmWWrxOuGdJcyKYwdnQ4=;
        b=ofhQApo5D8ytEaNZgHrBmAUtsytfQ3MAS8XJRhhiYO3LaD2KMkqQljBwIo4k8YhsWE
         I9FYeNadsdOX6vCOJtFWNmAW5ctATDbwNmRR9DVf1TLGPWNaBKe3RcUWSlMggqrtb5a9
         j1YOyEuRaPZmS89L9vnMlzPP2LDehxDNrouqjZiphl2jMdmkiUpWn2gbqplBJIGykXy6
         Ivj+oxgt2L3WnGvGOppMbNhTXXoDCLoIF0vko2MQ9uNc+lxphEklVyjLp89zJaVcjy2W
         QVtju4uum3kisCh93e2a/HZtMWkxhQtCfkOzyhSP/nekhi4CDxqz0eUk30ZAHPyw1tPf
         02Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUA8GRgNau1ZBQ0aLrTFzwc4RTQMgYLzZX7k2AErdWnOmxl4jRfMFkduS4uILWkBevbIrbKce9lVonG4BOK@vger.kernel.org, AJvYcCXsCvill9PxY6Xbff03SCuGqUibj1k6Xk5apDY7b/KscDfLZzDb8keCZIyKLCfXbnPMtYh4YSvKk6Wc6JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0BbWyK+Yjvb/aSYnLLR9/y7Me8u69wN2ueZMSJfb4Jj9Fo2XO
	n9aEs4A6PmXJAdU93aXISqge/zCj0pTIDPCxJuIUUDdUw4BH2qwp
X-Gm-Gg: ASbGncs5ppEs/odXK6WFudLMMPZ0S/jkAE+Y+T9tpI20CxDykzp7SgIuI2XPfUKFapo
	ryOydZERnSn/1BfBz+Ncnh8jkne9F6gOvc/xiBa6sGgsWbLyriQOQFeVu9u+sORo9rHLV4mRufo
	UblsG5a/X/q6oXHb3lt22jky7StQDZLBuMFCTdKun2p7dh/BvV3EOnTp4aKBB0ETTBYW8Y+v6Jh
	nfmSryArHDM0XWevbk9yjWX8qIVflziLNeRWy1fUb9ihz9w5yKfh0Gk
X-Google-Smtp-Source: AGHT+IF0kpU1ivx050K3LIHZbj5S6i52pi+Emkd1aeepP7LUYU2eo7dQDeVIlv8b8Ryb30KdQsl2Qg==
X-Received: by 2002:a17:90b:2802:b0:2ee:8358:385 with SMTP id 98e67ed59e1d1-2f452def795mr54896064a91.4.1735583543350;
        Mon, 30 Dec 2024 10:32:23 -0800 (PST)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cddbsm25704821a91.15.2024.12.30.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 10:32:22 -0800 (PST)
Date: Mon, 30 Dec 2024 10:32:20 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
Message-ID: <Z3LnNBWn8dHZIo7E@yury-ThinkPad>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
 <ZzT1wZ-WQi8zuwqG@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzT1wZ-WQi8zuwqG@yury-ThinkPad>

On Wed, Nov 13, 2024 at 10:53:55AM -0800, Yury Norov wrote:
> On Thu, Nov 14, 2024 at 02:18:32AM +0900, Vincent Mailhol wrote:
> > __builtin_constant_p() is known for not always being able to produce
> > constant expression [1] which led to the introduction of
> > __is_constexpr() [2]. Because of its dependency on
> > __builtin_constant_p(), statically_true() suffers from the same
> > issues.
> > 
> > For example:
> > 
> >   void foo(int a)
> >   {
> >   	 /* fail on GCC */
> >   	BUILD_BUG_ON_ZERO(statically_true(a));
> > 
> >   	 /* fail on both clang and GCC */
> >   	static char arr[statically_true(a) ? 1 : 2];
> >   }
> > 
> > For the same reasons why __is_constexpr() was created to cover
> > __builtin_constant_p() edge cases, __is_constexpr() can be used to
> > resolve statically_true() limitations.
> > 
> > Note that, somehow, GCC is not always able to fold this:
> > 
> >   __is_constexpr(x) && (x)
> > 
> > It is OK in BUILD_BUG_ON_ZERO() but not in array declarations nor in
> > static_assert():
> > 
> >   void bar(int a)
> >   {
> >   	/* success */
> >   	BUILD_BUG_ON_ZERO(__is_constexpr(a) && (a));
> > 
> >   	/* fail on GCC */
> >   	static char arr[__is_constexpr(a) && (a) ? 1 : 2];
> > 
> >   	/* fail on GCC */
> >   	static_assert(__is_constexpr(a) && (a));
> >   }
> > 
> > Encapsulating the expression in a __builtin_choose_expr() switch
> > resolves all these failed tests.
> > 
> > Define a new const_true() macro which, by making use of the
> > __builtin_choose_expr() and __is_constexpr(x) combo, always produces a
> > constant expression.
> > 
> > It should be noted that statically_true() is the only one able to fold
> > tautologic expressions in which at least one on the operands is not a
> > constant expression. For example:
> > 
> >   statically_true(true || var)
> >   statically_true(var == var)
> >   statically_true(var * 0 + 1)
> >   statically_true(!(var * 8 % 4))
> > 
> > always evaluates to true, whereas all of these would be false under
> > const_true() if var is not a constant expression [3].
> > 
> > For this reason, usage of const_true() be should the exception.
> > Reflect in the documentation that const_true() is less powerful and
> > that statically_true() is the overall preferred solution.
> > 
> > [1] __builtin_constant_p cannot resolve to const when optimizing
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
> > 
> > [2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
> > Link: https://git.kernel.org/torvalds/c/3c8ba0d61d04
> > 
> > [3] https://godbolt.org/z/c61PMxqbK
> > 
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> For the series:
> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
> 
> If no objections, I'll move it with my tree.

This is already in my branch, but there was a discussion after I pulled
it. Can you guys tell me what is your conclusion on that? Should I
keep it in the branch, or drop?

Thanks,
Yury
