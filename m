From: Christopher Li <sparse@chrisli.org>
Subject: Re: Small patch for __builtin_fabs and an attribute
Date: Tue, 13 Jul 2010 00:33:36 -0700
Message-ID: <AANLkTilt83WWkm4wJnfLZucaKbHF8AZj-aoU2aMDZehY@mail.gmail.com>
References: <AANLkTilLz1Tgfnf8nwvocJeX5B2bpBG5ZzObHdNKF_ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41968 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab0GMHdh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Jul 2010 03:33:37 -0400
Received: by qyk38 with SMTP id 38so4733676qyk.19
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jul 2010 00:33:36 -0700 (PDT)
In-Reply-To: <AANLkTilLz1Tgfnf8nwvocJeX5B2bpBG5ZzObHdNKF_ee@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <mortenw@gnome.org>
Cc: linux-sparse@vger.kernel.org

On Fri, Jul 9, 2010 at 8:15 PM, Morten Welinder <mortenw@gnome.org> wro=
te:
> FYI.
>
>
> diff --git a/lib.c b/lib.c
> index a218bfc..7f0b524 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -716,6 +716,7 @@ void declare_builtin_functions(void)
> =A0 =A0 =A0 =A0add_pre_buffer("extern long __builtin_alpha_inslh(long=
, long);\n");
> =A0 =A0 =A0 =A0add_pre_buffer("extern long __builtin_alpha_cmpbge(lon=
g, long);\n");
> =A0 =A0 =A0 =A0add_pre_buffer("extern long __builtin_labs(long);\n");
> + =A0 =A0 =A0 add_pre_buffer("extern double __builtin_fabs(double);\n=
");
>
> =A0 =A0 =A0 =A0/* And some floating point stuff.. */
> =A0 =A0 =A0 =A0add_pre_buffer("extern int __builtin_isgreater(float, =
float);\n");
> diff --git a/parse.c b/parse.c
> index f81b19f..0645538 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -515,6 +515,8 @@ const char *ignored_attributes[] =3D {
> =A0 =A0 =A0 =A0"__format_arg__",
> =A0 =A0 =A0 =A0"hot",
> =A0 =A0 =A0 =A0"__hot__",
> + =A0 =A0 =A0 "may_alias",
> + =A0 =A0 =A0 "__may_alias__",
> =A0 =A0 =A0 =A0"malloc",
> =A0 =A0 =A0 =A0"__malloc__",
> =A0 =A0 =A0 =A0"model",

Hi Morten,

I forget one thing. Can you signed off your patch?

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
