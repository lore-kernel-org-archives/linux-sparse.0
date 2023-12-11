Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/t9gccH"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E672FC3
	for <linux-sparse@vger.kernel.org>; Mon, 11 Dec 2023 05:16:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b5155e154so52381785e9.3
        for <linux-sparse@vger.kernel.org>; Mon, 11 Dec 2023 05:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702300611; x=1702905411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQgITVR3ZpsytFpcgrTPNVi94PKH4uv9rl39PMT5JXE=;
        b=D/t9gccHmJUATH2NlK95ooMYi9WkZ+L5g/FSupbSc+h1j7JOTfrZ7GZ98tHi/LMnZv
         rZIUssnbXIm+a2Gm3awEjDPuRUaHVUglD6ARrXyi55NVa8OfOkVRnvQWQoqm7oKJTrQ7
         9dBBr6XPKzdw4GeFxLbdvqpClNRu1Rxw1o9Niiv8tdfm9y+T5v0qZH7MiPlmGMjQznuD
         0JqTDQIOoNmH2+pAJyMutR8YGceoK2Gd51UwiHToAiMMrS9A5NLwC+keZvDGgnMb0KPI
         7RzE3aii+jVW7mITHvU0u1sDyrCgx569+9RRTCj+lLGH7cXvwvNdk0pcs5DaRjE8b0+6
         R5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702300611; x=1702905411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQgITVR3ZpsytFpcgrTPNVi94PKH4uv9rl39PMT5JXE=;
        b=aAN+VHkAl9dKZ6KyCvHFDSdxHNao18UoepVx7CUmHpy21o3FYm7ia4AVb4e2XzwDpR
         D0Dkk+A+X70osR2cr0Ee2gDiLMFRYyTTAqkHQPaNPnKKorXwEafGivSI7ajXRnfk3vf9
         qKyzKU7HtWJYrjtKjhuMKgTepNilZ2mnzYiYscedY4F6VGIXwGa9HIXZg6va6flACJ8G
         3HYp9x7HoLK7VbsVt5zNdBPjDFbO75w4eqGI8IoB6EMteLdWs1kLk0cXOCcnFe3/L0b/
         o461lVNLL1n+G3RvlHgYsyaRoiETep6yAjnnu2Ps+MwR9/NyeDjiR6a/xLIRfqZ7Vexj
         7azA==
X-Gm-Message-State: AOJu0Yyn4i1dUXDkVl4VjBB9/efZeB5HXSNCJKb0OvddO6K/4OgsSPbQ
	zfkDdUp3MiYj3BU80TpX6BaaqujaWus=
X-Google-Smtp-Source: AGHT+IEdZ0bBfsmlcOhrZSx15TklomNOe1mAtHb1U0D5IUixVGYhdEGABLPu0KUbasNMDgFsXWiYwA==
X-Received: by 2002:a05:600c:54c5:b0:40c:337e:caf with SMTP id iw5-20020a05600c54c500b0040c337e0cafmr2009245wmb.150.1702300611187;
        Mon, 11 Dec 2023 05:16:51 -0800 (PST)
Received: from mail ([87.66.46.106])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709060c4f00b00a1f78a97063sm3879710ejf.153.2023.12.11.05.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:16:50 -0800 (PST)
Date: Mon, 11 Dec 2023 14:16:49 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2] parse: handle __cleanup__ attribute
Message-ID: <i4s2gnr6rlq3yhmfiy7lkbsahnaioilksvmx3eocdjfh2434zo@zhxhwwgqpxt2>
References: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>

On Fri, Dec 08, 2023 at 12:49:34PM +0300, Dan Carpenter wrote:
> The kernel has recently started using the __cleanup__ attribute.  Save
> a pointer to cleanup function.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2:  The first version of this patch had a bug handling a list of
>      declarations.  I had to add a .cleanup = NULL at the start of
>      the loops iterations in declaration_list() and
>      external_declaration().

OK. See some notes here under, but first at all please forgive my very long delay.
 
> diff --git a/parse.c b/parse.c
> index 3d6fef7cb011..e5b5e6acc062 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -537,6 +542,7 @@ static struct init_keyword {
>  	/* Attributes */
>  	D("packed",		&packed_op),
>  	D("aligned",		&aligned_op),
> +	D("__cleanup__",	&cleanup_op),

This should simply be D("cleanup" (to accept both the plain form and the __X__ form).

> @@ -1964,6 +1984,7 @@ struct token *typename(struct token *token, struct symbol **p, int *forced)
>  	token = declarator(token, &ctx);
>  	apply_modifiers(token->pos, &ctx);
>  	sym->ctype = ctx.ctype;
> +	sym->cleanup = ctx.cleanup;

I don't think this should be needed because the cleanup attribute should be
'attached' to individual symbols, not their types (but I have no idea what GCC do).

> @@ -2924,6 +2945,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>  
>  	decl->ctype = ctx.ctype;
>  	decl->ctype.modifiers |= mod;
> +	decl->cleanup = ctx.cleanup;

Similarly, the attribute should only be applied to automatic variables,
so this should not be needed/should be detected as an error.

> diff --git a/symbol.h b/symbol.h
> index 5270fcd73a10..88130c15d4bd 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -204,6 +205,7 @@ struct symbol {
>  			struct statement *inline_stmt;
>  			struct symbol_list *inline_symbol_list;
>  			struct expression *initializer;
> +			struct expression *cleanup;

This annoys me a little bit as it adds one more member to struct symbol
which is already the biggest memory user.
But currently this is fine as other currently ignored attributes are also
concerned. A solution is needed for all of them but there is no urgency.

It would be nice to have some testcases though.

Anyway, I can take this patch as-is modulo the few changes here above or
you can send a v3 if you prefer. But it may take a few days before I'm able
to push it to k.org.

Best regards,
-- Luc

