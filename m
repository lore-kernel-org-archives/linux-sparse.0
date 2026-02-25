Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603D280331
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771987210; cv=pass; b=KQV9c3E8u0ix1WEtk0XV/8QAM+apgnwrww8PRBlrvVSn6M2pBM+1AlZ7EW57S2jTEHQ+8fxxDZP/xuJqyltz1TnBpncR0hMNLLPu825qyiirHoFC+/A2yRTrAoEeFQM+zYe9OhPyO9g3M+IqH0T1RUZKHEGIo/q3srSJrca1Ghc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771987210; c=relaxed/simple;
	bh=L2ZT7Ezy81Mh56Z1avttcgqpRzHjq/fp0fN8PoFNbhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdpgU8DCOm7F/ZS3hG53tJqMhKnal7odb+50tV7thZ6Tm+RaYA4CSIg06QLVBvv5EaKZKB3z6WD8OUxGXrGMavIhKEuYKeVDcs4/5UO6uKIakq1OeZTV0/JGguRjFZookGlUGwpAJBo8p1OmpacOWWU9YbraZNgFA4HCvE3TdPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so1113051d50.1
        for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 18:40:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771987208; cv=none;
        d=google.com; s=arc-20240605;
        b=Ajx5Ff7yj3sm8hZtSKVleAaQ4tXpZj8ahHMiELocfOsmTYcE0T0lEuS8/E1yX8cxUB
         1w7xi6XvZc4JEtUqcRJdQMt+IKo53flSepESng3uW74KERtNEAcG+fFWAkO1LUul4EDx
         hZ98xPGvznC5HcyowNNyQBInUjcwC4lHWqGSyT6+G2ymHpwLBBRTqJXflsqmmB9K1y7q
         PmoGSoBLrmT2DSKbUnqMlXvHl7n/tb1hXYHaA8AtVGryblIs3imtuLu0hkH0HkYUCO+c
         pQykc7tGsEsAFmLGcXVH37plFU2SwW7+B7zH95+jfR7RdO1xhrRC3nNj70HhDzX9Xkvk
         y30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Kxjm/NgAdfhk/YcEQbfbAxKwc64nuU+XMHoiASzhzRQ=;
        fh=Y21EvSYG5zIB8YxPyVf+uIbVrDfz+HkqOPrGVXFSTmA=;
        b=EI+iSTy9d6NvrNeI3VjX43ItCLMfUmgIbQXe3NwdYFIc/YujStxmRXi4R8vjUFTllm
         jhw6PnmoKp854OfOJ3r5WqIu/QlN7OKDPiMM8YWRuxF80ltHfuMS8+EdfXw+uGVek3Lr
         Z+FQWGTAKWPG4AJ10ivC7hD9T005d8mOPUI0A3AM48nCwLkde53EK9rh3VYnxpIRSaKR
         G+wER/D9pP3ohuiMd9ajbSUcpQYAlmq6zevVI3GNmRtwMARKCpBvc4IKqhDN6n32aC/7
         Gk5BCd8fmtA1TQMuCwQTSKaWguSdN/Pu8SzaADnIIOhtfCfBJ73znaaeI2iuAtP/2IaW
         6LeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771987208; x=1772592008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kxjm/NgAdfhk/YcEQbfbAxKwc64nuU+XMHoiASzhzRQ=;
        b=hFRjUbU8hOzMCmHVDDdic0VFc9jty9yGycht/t7MOiGvLKa4GmQYvKyKbC03kKi1iX
         NLW45N/IzExDs3iEInX8hqm90ZAMcZ0sMdKe/b+PC9AvtybSE1OEJKreHknh2gb168WY
         4vCHlKJOLVT3i9SUcck8Umtq0grbdwQm8UXAPFjE6mAKhlekR8Ck9AMLMtOIMlhF7XzP
         C4sRO++As1esbOTqxAx+0aM9/e2Ngl2ooRkc3B14E4ajyh9ldFQIzSMsFk1e3Wvq0ma7
         Fl3Y88sfrJho5WHkNBtZGatXjorBGIwsF5hbiNNidnRMdcsFH/2FZJYnG30FTdDkNwDI
         +lkw==
X-Gm-Message-State: AOJu0Yy+ye7L9o48rKLfJ0440A9XkLo2fad41ApdmG/2vvI1Paqa20G+
	YmGqbA+zoXqhf1FRDtZIdIrKOIPSRas7lfZh+U+uNZTSAGu7iLkuA2g8GOXZX5yAwF41r1P1nDy
	7hNzOnILzl6Fg+nDW/6Si3CkYRNnttVZnEh9TDAq7Dw==
X-Gm-Gg: ATEYQzxxSg58ImY8eXZMOk19RWvlifPreucIjy68zZ3rxbZtQpKn3aGy+LibEOErpyt
	O7aQYODbbZBlX5J+a9qZPRCpvrm52Dn0D4NCqpORpD7M4IAdJip6caTCtrhiXXZVFYqML9U9Cyy
	HP2qbU0fCMYejWZN5qLaffeiAH5Z4+yXH7XvKLm/sDxgIkGa1Sqmv2h+aGNq9Bb4huXjDLz1skz
	n4TaMQGUT+/kfkYSFiQVL1CFU81aLadSQ6Usho0l/MVJcP189GCLW9x8VfiONHWVqeu2u0WPfxR
	H8P1TlZMJuIaYmVvpLJW2Jb/x+VaddFcqxkuoF1ctIE+V2ccGGCg3PWp+GiHH2Lf+h03V9hP
X-Received: by 2002:a05:690e:4495:b0:64a:d314:295a with SMTP id
 956f58d0204a3-64c78accbdamr9518472d50.37.1771987207972; Tue, 24 Feb 2026
 18:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771930766.git.dan.carpenter@linaro.org> <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
In-Reply-To: <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
From: Chris Li <sparse@chrisli.org>
Date: Tue, 24 Feb 2026 18:39:57 -0800
X-Gm-Features: AaiRm51O87IlYOwp2mh52zz_8njEvKV9IPDjw_LVjp6iULCrrh26kjenq290fSc
Message-ID: <CACePvbUjNQUZWcTK-59p09RJAjZZs+z8HuYmkfeTXWBsOKBEfw@mail.gmail.com>
Subject: Re: [PATCH] sparse: add support for __VA_OPT__
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-sparse@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ricardo Ribalda <ribalda@chromium.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Xuanhao Zhang <zxh@xh-zhang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thanks for the patch.

BTW, can you CC my personal email next time? Thanks.

On Tue, Feb 24, 2026 at 3:12=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The linux kernel has started using __VA_OPT__ so lets add support for it.
>
> What it does is it adds an optional thing, normally a comma, if the
> __VA_ARGS__ parameter is not empty.  So if you have at least one argument
> but possibly more then you could create a macro like:
>
> #define test_args(a, ...) printf(a __VA_OPT__(,) __VA_ARGS__)
>
> If you call test_args("foo\n") it expands to:
>
> printf("foo\n");
>
> but if you pass two arguments test_args("foo %d\n", 2) it expands to:
>
> printf("foo\n" , 2);
>
> I guess if you wanted instead of a comma then you could have an empty
> __VA_OPT__() or you could pass random things like __VA_OPT__(a b c).  I
> don't know why you would do that.  In this case, "a" is a macro argument
> so that has to be expanded out.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  ident-list.h  |  1 +
>  pre-process.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/ident-list.h b/ident-list.h
> index d65668108385..bffc4038a75d 100644
> --- a/ident-list.h
> +++ b/ident-list.h
> @@ -66,6 +66,7 @@ IDENT(c_static_assert);
>  __IDENT(pragma_ident, "__pragma__", 0);
>  __IDENT(_Pragma_ident, "_Pragma", 0);
>  __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
> +__IDENT(__VA_OPT___ident, "__VA_OPT__", 0);
>  __IDENT(__func___ident, "__func__", 0);
>  __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
>  __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
> diff --git a/pre-process.c b/pre-process.c
> index 05a5a79396a8..94710301ce17 100644
> --- a/pre-process.c
> +++ b/pre-process.c
> @@ -643,11 +643,49 @@ static int handle_kludge(struct token **p, struct a=
rg *args)
>         }
>  }
>
> +static struct token *get_VA_OPT(struct token **p, struct arg *args)
> +{
> +       struct token *t =3D (*p)->next;
> +       const char *expected;
> +       struct token *ret =3D NULL;
> +       struct token *dup, *tail;
> +
> +       if (token_type(t) !=3D TOKEN_SPECIAL || t->special !=3D '(') {
> +               expected =3D "(";
> +               goto error;
> +       }
> +       while (true) {
> +               t =3D t->next;
> +               if (eof_token(t)) {
> +                       expected =3D ")";
> +                       goto error;
> +               }
> +               if (token_type(t) =3D=3D TOKEN_SPECIAL &&
> +                   t->special =3D=3D ')')
> +                       break;


I think this approach has some limitations. You can use the
collect_arguments() to collect and expand the arguments for
__VA_OPT__().

I did a small test case to show that gcc actually expand the arguments
inside the __VA_OPT__().
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D terminal =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
$ cat ~/tmp/va_opt.c
#define A(B) ,
#define foo(fmt, ...) printk(fmt __VA_OPT__(A(x)) __VA_ARGS__)

foo("\n");
foo("\n", "a");
$ gcc -E ~/tmp/va_opt.c
# 0 "/home/chrisl/tmp/va_opt.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "/home/chrisl/tmp/va_opt.c"

printk("\n" );
printk("\n" , "a");
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D terminal =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
That shows that gcc correctly expand the A() macro inside __VA_OPT__(A(x)).

I have not test it on your program yet, reading your patch I assume it
will not expand the A() here.

One idea is to add an expand function expand___VA_OPT__, similar to
expand_has_feature(). Register it in the dynamic expand macro array.
That way you get the collect_arguments() for free and it behaves just
like a builtin macro expansion. Just duplicate the collected arg list
to the current token, if  there are extra arguments.

If you go that route, likely don't need the manual __VA_OPT__ident parsing.

I haven't had time to code it myself yet; it's just an idea.

Chris

> +               dup =3D dup_token(t, &(*p)->pos);
> +               if (!ret)
> +                       ret =3D dup;
> +               else
> +                       tail->next =3D dup;
> +               tail =3D dup;
> +       }
> +
> +       if (tail)
> +               tail->next =3D &eof_token_entry;
> +       *p =3D t;
> +       return ret;
> +error:
> +       sparse_error(t->pos, "__VA_OPT__ error: expected '%s'", expected)=
;
> +       return NULL;
> +}
> +
>  static struct token **substitute(struct token **list, struct token *body=
, struct arg *args)
>  {
>         struct position *base_pos =3D &(*list)->pos;
>         int *count;
>         enum {Normal, Placeholder, Concat} state =3D Normal;
> +       struct token *va_opt =3D NULL;
>
>         for (; !eof_token(body); body =3D body->next) {
>                 struct token *added, *arg;
> @@ -697,6 +735,10 @@ static struct token **substitute(struct token **list=
, struct token *body, struct
>
>                 case TOKEN_MACRO_ARGUMENT:
>                         arg =3D args[body->argnum].expanded;
> +                       if (va_opt && !eof_token(arg)) {
> +                               list =3D substitute(list, va_opt, args);
> +                               va_opt =3D NULL;
> +                       }
>                         count =3D &args[body->argnum].n_normal;
>                         if (eof_token(arg)) {
>                                 state =3D Normal;
> @@ -716,6 +758,11 @@ static struct token **substitute(struct token **list=
, struct token *body, struct
>                         continue;
>
>                 case TOKEN_IDENT:
> +                       if (body->ident =3D=3D &__VA_OPT___ident) {
> +                               va_opt =3D get_VA_OPT(&body, args);
> +                               continue;
> +                       }
> +
>                         added =3D dup_token(body, base_pos);
>                         if (added->ident->tainted)
>                                 added->pos.noexpand =3D 1;
> @@ -1234,6 +1281,8 @@ static struct token *parse_arguments(struct token *=
list)
>         while (token_type(arg) =3D=3D TOKEN_IDENT) {
>                 if (arg->ident =3D=3D &__VA_ARGS___ident)
>                         goto Eva_args;
> +               if (arg->ident =3D=3D &__VA_OPT___ident)
> +                       goto Eva_opt;
>                 if (!++count->normal)
>                         goto Eargs;
>                 next =3D arg->next;
> @@ -1312,6 +1361,9 @@ Enotclosed:
>  Eva_args:
>         sparse_error(arg->pos, "__VA_ARGS__ can only appear in the expans=
ion of a C99 variadic macro");
>         return NULL;
> +Eva_opt:
> +       sparse_error(arg->pos, "__VA_OPT__ can only appear in the expansi=
on of a C99 variadic macro");
> +       return NULL;
>  Eargs:
>         sparse_error(arg->pos, "too many arguments in macro definition");
>         return NULL;
> --
> 2.51.0
>
>
