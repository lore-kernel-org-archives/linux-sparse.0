Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQg0zVVr"
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBE9D6C
	for <linux-sparse@vger.kernel.org>; Fri,  1 Dec 2023 06:56:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c4433e98bso1501996a12.3
        for <linux-sparse@vger.kernel.org>; Fri, 01 Dec 2023 06:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701442595; x=1702047395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BY/Ue4z1ztXOccdXSKPP/kuORuDV05jekD50D7//YA=;
        b=KQg0zVVrUzFfUe1VaP7QHHE3V8CLrfNuWxtCer6AkMe/dFvvO0MkZHsewjjBPvrxzs
         Z/wAAqN03FmTCeDEYYuBaGImDM7k45YZE0KkNHGY1byuzuiYa/rPsx1SgdyZmnsIW3Z2
         A5NooTsuHy2ODkFIc2IulkHOfbpeB9j7kKY9RIsMUyKxxypLXWvQdIf62eTnn/mEwNW0
         SaDmKfqtOKYfhenPsw/8IUho4+Vh8jnH9aQlpn5ZcyVIl3Dl/D+9dmWWDsdomOvF5oeE
         FU0HG7bv9mMg7pcqMCH4lTYGFMPO5cCbf7xsqusx0gzL6z8gmvsYCTN9TgYGkeH+pamx
         mNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442595; x=1702047395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BY/Ue4z1ztXOccdXSKPP/kuORuDV05jekD50D7//YA=;
        b=Q8Wl9km7kab6kBf6MhCsgqirUvm2Ba+1Vaen5O94YQR/cD9DPrVRms6zvPSZhz5Xow
         04MuzlUh1l9rNXTQ3J0MGzHHt9YG8IA8nrLfzx1/2nlP+TIOGBSUM3OJ2mctoUWll9vd
         8GGyNe/CZ/YX0mcKkZ72yNKzZ7apToW4IEJjBK19595Y6lCPcucHmy1hpu1jsgzowwit
         vX76n3rI/+ax0QnjxzhfxlPKtxjIAPM6fZx+JNJQ34emybKUyTkUTZgjtVxvQgxO3KZn
         E+VKeoeTkQcjTHxnOqBseN4/R2jqC0+zTOkyyyjf5JB3knx6OkKrefGaeWJGUHFKZIqD
         7RtQ==
X-Gm-Message-State: AOJu0YyLEX8Gattg+iKGN7IkeIcg7MadtMYMHbFGcAQNDyWLcKAZY+5d
	yhVrbKGlm1Oh7TB6ESNZQ6GF8MzfbzLDEPU1m/A=
X-Google-Smtp-Source: AGHT+IEiQI2cXxbkzRxPdYhz8FqwtWqMZlnqlr3HdMfKRB6/NB2wHwsSsQp+BEqTgMbE3SDr0MHBRJXHRXuzzDV/aws=
X-Received: by 2002:a50:c291:0:b0:54c:4fec:e7 with SMTP id o17-20020a50c291000000b0054c4fec00e7mr397267edf.118.1701442594976;
 Fri, 01 Dec 2023 06:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202310080853.UhMe5iWa-lkp@intel.com> <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
 <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com> <17d4d1c1-6b27-4fab-bc94-9b2d734e7b36@suswa.mountain>
In-Reply-To: <17d4d1c1-6b27-4fab-bc94-9b2d734e7b36@suswa.mountain>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 1 Dec 2023 15:56:23 +0100
Message-ID: <CAFULd4ZTmq9kw3=KPR9exxp=t=4V=cPODbF5qksxXHFpA8YAWQ@mail.gmail.com>
Subject: Re: sparse: Expected ) at end of cast operator, got __seg_gs
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 3:51=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> I patched Smatch to just ignore it.  I think Luc is on sabatical and
> it's not clear if anyone is applying patches now.

I think you should also include __seg_fs, this is the x86_32
counterpart to __seg_gs.

Uros.

>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  parse.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/parse.c b/parse.c
> index 6803976a1337..2ddc29acbd33 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -74,6 +74,7 @@ static struct token *parse_range_statement(struct token=
 *token, struct statement
>  static struct token *parse_asm_statement(struct token *token, struct sta=
tement *stmt);
>  static struct token *toplevel_asm_declaration(struct token *token, struc=
t symbol_list **list);
>  static struct token *parse_static_assert(struct token *token, struct sym=
bol_list **unused);
> +static struct token *ignore_seg_gs(struct token *token, struct symbol_li=
st **unused);
>
>  typedef struct token *attr_t(struct token *, struct symbol *,
>                              struct decl_state *);
> @@ -354,6 +355,10 @@ static struct symbol_op static_assert_op =3D {
>         .toplevel =3D parse_static_assert,
>  };
>
> +static struct symbol_op seg_gs =3D {
> +       .toplevel =3D ignore_seg_gs,
> +};
> +
>  static struct symbol_op packed_op =3D {
>         .attribute =3D attribute_packed,
>  };
> @@ -521,6 +526,9 @@ static struct init_keyword {
>         N("_Float64x",          &spec_op,       .type =3D &float64x_ctype=
),
>         N("_Float128",          &spec_op,       .type =3D &float128_ctype=
),
>         N("__float128",         &spec_op,       .type =3D &float128_ctype=
),
> +
> +       N("__seg_gs",           &seg_gs),
> +
>  }, keywords[] =3D {
>         /* Statements */
>         N("if",                 &if_op),
> @@ -2130,6 +2138,11 @@ static struct token *parse_static_assert(struct to=
ken *token, struct symbol_list
>         return token;
>  }
>
> +static struct token *ignore_seg_gs(struct token *token, struct symbol_li=
st **unused)
> +{
> +       return token->next;
> +}
> +
>  /* Make a statement out of an expression */
>  static struct statement *make_statement(struct expression *expr)
>  {
> --
> 2.42.0
>
