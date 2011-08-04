From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Recognize and ignore _Complex, artificial and vector_size
Date: Thu, 4 Aug 2011 15:49:16 -0700
Message-ID: <CANeU7QmxY8aqU=HjQ6GEW5qw0J5YLrniLHY-_0J5wB9pnymsrQ@mail.gmail.com>
References: <20110804213811.27256.73386.stgit@mj>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61335 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071Ab1HDWtS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Aug 2011 18:49:18 -0400
Received: by wyf22 with SMTP id 22so855215wyf.19
        for <linux-sparse@vger.kernel.org>; Thu, 04 Aug 2011 15:49:16 -0700 (PDT)
In-Reply-To: <20110804213811.27256.73386.stgit@mj>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

Do mind add a test case of _Complex? It can be a separate
patch.

It helps me understanding the usage of _Complex as well.

Thanks

Chris

On Thu, Aug 4, 2011 at 2:38 PM, Pavel Roskin <proski@gnu.org> wrote:
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> ---
>
> =A0ident-list.h | =A0 =A02 ++
> =A0parse.c =A0 =A0 =A0| =A0 =A09 +++++++++
> =A02 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/ident-list.h b/ident-list.h
> index b94aece..973bf57 100644
> --- a/ident-list.h
> +++ b/ident-list.h
> @@ -87,6 +87,8 @@ IDENT(fastcall); IDENT(__fastcall__);
> =A0IDENT(dllimport); IDENT(__dllimport__);
> =A0IDENT(dllexport); IDENT(__dllexport__);
> =A0IDENT(restrict); IDENT(__restrict);
> +IDENT(artificial); IDENT(__artificial__);
> +IDENT(vector_size); IDENT(__vector_size__);
>
> =A0/* Preprocessor idents. =A0Direct use of __IDENT avoids mentioning=
 the keyword
> =A0* itself by name, preventing these tokens from expanding when comp=
iling
> diff --git a/parse.c b/parse.c
> index 537055f..1c3e305 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -145,6 +145,10 @@ static struct symbol_op restrict_op =3D {
> =A0 =A0 =A0 =A0.type =3D KW_QUALIFIER,
> =A0};
>
> +static struct symbol_op complex_op =3D {
> + =A0 =A0 =A0 .type =3D KW_QUALIFIER,
> +};
> +
> =A0static struct symbol_op typeof_op =3D {
> =A0 =A0 =A0 =A0.type =3D KW_SPECIFIER,
> =A0 =A0 =A0 =A0.declarator =3D typeof_specifier,
> @@ -419,6 +423,7 @@ static struct init_keyword {
> =A0 =A0 =A0 =A0/* Ignored for now.. */
> =A0 =A0 =A0 =A0{ "restrict", =A0 NS_TYPEDEF, .op =3D &restrict_op},
> =A0 =A0 =A0 =A0{ "__restrict", NS_TYPEDEF, .op =3D &restrict_op},
> + =A0 =A0 =A0 { "_Complex", =A0 NS_TYPEDEF, .op =3D &complex_op},
>
> =A0 =A0 =A0 =A0/* Storage class */
> =A0 =A0 =A0 =A0{ "auto", =A0 =A0 =A0 NS_TYPEDEF, .op =3D &auto_op },
> @@ -486,6 +491,8 @@ const char *ignored_attributes[] =3D {
> =A0 =A0 =A0 =A0"__alloc_size__",
> =A0 =A0 =A0 =A0"always_inline",
> =A0 =A0 =A0 =A0"__always_inline__",
> + =A0 =A0 =A0 "artificial",
> + =A0 =A0 =A0 "__artificial__",
> =A0 =A0 =A0 =A0"bounded",
> =A0 =A0 =A0 =A0"__bounded__",
> =A0 =A0 =A0 =A0"cdecl",
> @@ -563,6 +570,8 @@ const char *ignored_attributes[] =3D {
> =A0 =A0 =A0 =A0"__unused__",
> =A0 =A0 =A0 =A0"used",
> =A0 =A0 =A0 =A0"__used__",
> + =A0 =A0 =A0 "vector_size",
> + =A0 =A0 =A0 "__vector_size__",
> =A0 =A0 =A0 =A0"visibility",
> =A0 =A0 =A0 =A0"__visibility__",
> =A0 =A0 =A0 =A0"warn_unused_result",
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
