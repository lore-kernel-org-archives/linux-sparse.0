Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADF2EA743
	for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768604148; cv=none; b=n7yJDq1z9JsY2uAEt2b0ajZCEKf/fUGhIy6mKxIvi+um4phfaP2TgBDYxrZ8OyR4bq3yYdDmuIyaeVuZ2lOL5XZwduRLE7/ObpYoIriLtgVr+xYaovVcvt+I8sVbKq3CvZoo2e9dm6qW9GSAdS0SkdSq7dYavdno0jkgkrKACok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768604148; c=relaxed/simple;
	bh=EI+vomJSLlcK5tbACYrFoaiT2JZgEfVa/iQ7Di9LIAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvdzQxCCn9lKvjZ/LfDNEJOqFsCl85mDRmbSxLup+E90eDYCdWnVosRoR2sIlQIKoTMLlGiiTgKBvWWHu7PrR48W35pHYEsF7vj68iyyxAY58yOi3C2Q+eK8l7YVQvIGt3rYua3KwULgxU2GX5hShOLAl3DFQxzRPqtbDXY4pEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78fba1a1b1eso41323097b3.1
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 14:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768604146; x=1769208946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ljWtJ4xVHY15+E8pwkVXsXiU05UPHu/DS8qQVF3BbQg=;
        b=qHeup+yiox3k62Yar/etrqDCiYUF59ND/huimOz88tOcIe1JtSzb4ZhZS2JCCkc8xb
         /DaSAgOYBIiRnk9hHLkgIKPPYSe2fnqroUyVwfXpdUIeFJyw053V2SY6+P9vW9wKcxzF
         eAA+Z2XlUJV0f+2GLCGrIBPQUHbba14BdZYPcWV0cgBHn0Ng95g2olRCloPbV4nt+Jwc
         Gt7N7gyiXo/MnBftEpaDc/1BVzu0SWTvR6GRVuVJS7OUMsJ1m0Hv9Br1+xl7LsM4ZC49
         QtEIGdl0+2I1DNWxeZYiY3/54NMhAZ9Dv/v6AhPnFbhASa1XjFRV33FzlRWHYQfbDvzG
         eERg==
X-Forwarded-Encrypted: i=1; AJvYcCXJgkfFHHLEbH15qrq9Om9HFP86mzOQK7mVtsdxYQVvOgBr83zhsUqOwIOOEiypLyhIZViXqbu31mLMD0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6u2A02MYLsqGOjo+SaYvSa1ImhBOWBb2B2330x7Wj8nm0T9z
	kMFO2hOOOd5we5URrDER3B1O04zODD1bC8wohZQwv0OcV/zYc5uTsUk28MCZukC61OvdJpJEJ5o
	kG9WAZAR2UXNAArHbnnXbf36KarFqPZ+quJz/kSfCiA==
X-Gm-Gg: AY/fxX7WownWjouuU68kj8NI9PiFPc/QiAarRgASLZbH9QUL5HsMhFsQ6RN5IEHRWLb
	3yJXe1g+xrGMywgyDIeWhuOU/I3MNH5sEq1VXPOs0WNFcgSg7EDcaGuakcA9aSvKp9y4c2+C57J
	6zQaUOoEnpbw4NtR6ksdxyNIGzjIrnm1j1y1jrq6fZof+P+bRg8fMRoXCH6DU2C1QzRqLTq2ijm
	EMy+elEdx6L6XzlkkTP0NlDjoO5l0eKz31XYD3jfniR/vQ5R0niMKkoTkNnmfMn0geFNG4Rrzyy
	gFL9ZD87VU8pfBtZoax2coE+80nhR3X2KIG0ZV3sRTc9kh42Oj/SFhDLqQ==
X-Received: by 2002:a05:690c:18:b0:792:72d4:2aad with SMTP id
 00721157ae682-793c58afba6mr33297747b3.17.1768604145802; Fri, 16 Jan 2026
 14:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUFhP-rIwC-iNJ5s@redhat.com>
In-Reply-To: <aUFhP-rIwC-iNJ5s@redhat.com>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 16 Jan 2026 14:55:34 -0800
X-Gm-Features: AZwV_QgAYlniWMuE9dP2Wb7wWUO_ajGFE9x0COVqINxMJmBXMqn59385iakWch8
Message-ID: <CACePvbWfwsu_gEUqfg47joLpD=UmO5Rj7hyoJFgiLzv5LyRFCw@mail.gmail.com>
Subject: Re: [PATCH] sparse: add the new m_pos member into struct expression{EXPR_DEREF}
To: Oleg Nesterov <oleg@redhat.com>
Cc: Luc Van Oostenryck <lucvoo@kernel.org>, Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

Applied to sparse-dev.

Chris



Chris

On Tue, Dec 16, 2025 at 5:40=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Test-case:
>
>         $ cat -n MEMPOS.c
>              1  struct T {
>              2   int mem;
>              3  } X;
>              4
>              5  void func(struct T *x)
>              6  {
>              7   x -> mem =3D 1;
>              8   X .  mem =3D 2;
>              9  }
>
>         $ ./test-dissect MEMPOS.c | grep -F T.mem
>            2:6                    def   m T.mem                          =
  int
>            7:4   func             -w-   m T.mem                          =
  int
>            8:4   func             -w-   m T.mem                          =
  int
>
> Note that the reported position of .mem usage is wrong. This is because
> do_expression(EXPR_DEREF) uses &expr->pos which is position of TOKEN_SPEC=
IAL,
> not the position of the next token (mem).
>
> This also breaks "semind search -l" (search by location)
>
>         $ ./semind add MEMPOS.c
>         $ ./semind search -l MEMPOS.c:7:7
>
> reports nothing.
>
> With this patch:
>
>         $ ./test-dissect MEMPOS.c | grep -F T.mem
>            2:6                    def   m T.mem                          =
  int
>            7:7   func             -w-   m T.mem                          =
  int
>            8:7   func             -w-   m T.mem                          =
  int
>
>         $ ./semind add MEMPOS.c
>         $ ./semind search -l MEMPOS.c:7:7
>         (def) MEMPOS.c  2       6                int mem;
>         (-w-) MEMPOS.c  7       7       func     x -> mem =3D 1;
>         (-w-) MEMPOS.c  8       7       func     X .  mem =3D 2;
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  dissect.c    | 2 +-
>  expression.c | 1 +
>  expression.h | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/dissect.c b/dissect.c
> index 9419c593..a6003afa 100644
> --- a/dissect.c
> +++ b/dissect.c
> @@ -454,7 +454,7 @@ again:
>                         p_mode =3D U_R_VAL;
>                 p_type =3D do_expression(p_mode, expr->deref);
>
> -               ret =3D report_member(mode, &expr->pos, p_type,
> +               ret =3D report_member(mode, &expr->m_pos, p_type,
>                         lookup_member(p_type, expr->member, NULL));
>         }
>
> diff --git a/expression.c b/expression.c
> index 727e7056..b23107da 100644
> --- a/expression.c
> +++ b/expression.c
> @@ -605,6 +605,7 @@ static struct token *postfix_expression(struct token =
*token, struct expression *
>                                 break;
>                         }
>                         deref->member =3D token->ident;
> +                       deref->m_pos =3D token->pos;
>                         token =3D token->next;
>                         expr =3D deref;
>                         continue;
> diff --git a/expression.h b/expression.h
> index 8bf40d32..ce8a29ce 100644
> --- a/expression.h
> +++ b/expression.h
> @@ -202,6 +202,7 @@ struct expression {
>                 struct /* deref_arg */ {
>                         struct expression *deref;
>                         struct ident *member;
> +                       struct position m_pos;
>                 };
>                 // EXPR_SLICE
>                 struct /* slice */ {
> --
> 2.52.0
>
>
