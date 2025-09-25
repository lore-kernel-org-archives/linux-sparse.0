Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCE502BE
	for <linux-sparse@vger.kernel.org>; Thu, 25 Sep 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810586; cv=none; b=qzNLHn3LKe9zb4ST9+WpYXkvx9eLhskeJYrZjxn99k6VwH9FRf1wXY7onXc8LDZrZyQbuLBvM0Pkvr5bIoXUU6BAf/1TcOBj5z+YMPlUzsfM+BJyHInQzhzFhCAhI8kMYFNzN8/evSJHYxLobfZDMseK6gDerAqbrpqzJxf8Mh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810586; c=relaxed/simple;
	bh=C9I9532uxtYRrGhAexcZovrP38OOFHBak81WSqLy7+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwZzqWool56WpZkfKHHaTypqKWDornN9mj17JZH5/x1OzLrDX1ijEFR6Zsqle+eZBAObd/bqBpiu1D2Y/p+xh465mhlt+8OaanG3W+4i9SDjO1OtnyuFDQxw4qv1zRfd/4F5hvHtbdDOXl7t7s60qiT7yyE8gR0rkCesefB8l88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6354a4b4871so697926d50.2
        for <linux-sparse@vger.kernel.org>; Thu, 25 Sep 2025 07:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810584; x=1759415384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVeITWhOz9MxlGUTT9JkXV738ZZYwUriHMuIJFfUVKw=;
        b=Q+2oT9GLR3E/P9kGhBpoCZ6Ckp66NeJkemC2th8tK91BqLIDDxJp9SxTPFnLEbcON/
         ulo+yW5+IzMEVolKJ4JSbDWPmI+ugWvYqC81tVa9fb5EIjSTQcRCNC6iVdyYf6eS6qlu
         cEhxQ/eI1N/cObZHdm3NYOW5zzskk8HZx8KgGShvBQKpKFhvvPPEU4nQeVcFDjAcvzWY
         P0Guz+wmEr9rOVgHCiqDp4IxWZJKxIZxYy93owqV9IsnTZlEi5eIROsKSl4SAhh208/p
         veBc6l//3X55nlesjkBTB5WWBlmj/VHOEZE17z1lNmVedVxQBznh5ftx2qu+23cVea40
         RtmQ==
X-Gm-Message-State: AOJu0Yz3255ZSzqtkDbGfvimX3la/9U+JQ/7OEFVwcgwWiXY3O5LIa1e
	pDD5fEnFWTgob9jafyxnUEn+Kp14Mm5fvvQiwb4w7dkMTK5pe3wfCPKYyVswpiYCayKAEoJ8Y6Z
	BwR9hHgNZu9IVby2IjJXL5ZmKNmfiVi3Z+fAxL5+gRzd8Xzuv5eseT+g=
X-Gm-Gg: ASbGnctlnuxqHSCzz7K+amRnXB2pBu+YqHfh1UK5VNf+kdEijSBsgtLP2y4Wkw5RU8Y
	64tiF2/FLhAtuMi46RxPc6CdX05qOjEduxWFkt00zVsJozpRrHlUNUOpn6fDc6Sj4t4WKRmG9+T
	zJilhjq8A3OiHN1Wj0e9CdxaoGBiCDSHJSlzvK/h9CQ3muScmI9HTmkXJth0rZHPSTgfrgt7lIQ
	axxjg==
X-Google-Smtp-Source: AGHT+IHAimlMLs79kN+1KV6YMM4xUAUWzJJC5BoZWLqRaY90NVBdcpQIC00oj+EXuz0xfAso3n41jFEzPRt3uGDI/08=
X-Received: by 2002:a05:6902:2510:b0:eb0:2cc1:c460 with SMTP id
 3f1490d57ef6-eb37fcab0bfmr3017126276.36.1758810583446; Thu, 25 Sep 2025
 07:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923083944.2263208-1-wenlunpeng@uniontech.com>
In-Reply-To: <20240923083944.2263208-1-wenlunpeng@uniontech.com>
From: Chris Li <sparse@chrisli.org>
Date: Thu, 25 Sep 2025 07:29:32 -0700
X-Gm-Features: AS18NWBNTmOuzn_m836GKE6jJAM_xA0gRlaLeTPUWHCvvX5VgAAglmbJBKZj0Qg
Message-ID: <CACePvbVcTrP06zPu6j7P7ui4UySYdGn+vqnyDLfdN4LfyRfbYA@mail.gmail.com>
Subject: Re: [PATCH] fix: Skip if symbol have no op when handle_qualifiers
To: wenlunpeng <wenlunpeng@uniontech.com>
Cc: linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied in sparse-dev.

Thanks

Chris

On Mon, Sep 23, 2024 at 1:41=E2=80=AFAM wenlunpeng <wenlunpeng@uniontech.co=
m> wrote:
>
> Missing s->op will cause a SIGSEGV when trying to get s->op->type.
>
> I encountered the issue when building with sparse in a linux kernel tree
> containing a vendor network driver. A simple `make` will success but a
> `make C=3D2` will exit with exit-code 139. The coredump shows that s->op
> here is NULL when dealing with a source code line like:
>         u8 *byte;
>
> Lines like this exist everywhere. I cannot figure out why just this file
> breaks sparse. But I think the NULL judge is needed here.
>
> Signed-off-by: wenlunpeng <wenlunpeng@uniontech.com>
> ---
>  parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parse.c b/parse.c
> index 3d6fef7c..66d0be04 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -1505,7 +1505,7 @@ static struct token *handle_qualifiers(struct token=
 *t, struct decl_state *ctx)
>  {
>         while (token_type(t) =3D=3D TOKEN_IDENT) {
>                 struct symbol *s =3D lookup_keyword(t->ident, NS_TYPEDEF)=
;
> -               if (!s)
> +               if (!s || !s->op)
>                         break;
>                 if (!(s->op->type & (KW_ATTRIBUTE | KW_QUALIFIER)))
>                         break;
> --
> 2.20.1
>
>
