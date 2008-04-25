From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] ignore __cold__ attribute
Date: Thu, 24 Apr 2008 19:26:06 -0700
Message-ID: <4811413E.1080103@freedesktop.org>
References: <1208860883.31429.8.camel@johannes.berg>	 <20080422090739.2izftuclwocs80o4-cebfxv@fcnzpbc.arg@webmail.spamcop.net>	 <1208870706.31429.23.camel@johannes.berg> <1208900131.22856.4.camel@dv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig78D65CCA001E81C8CA803BEC"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:48308 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbYDYC0F (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 22:26:05 -0400
In-Reply-To: <1208900131.22856.4.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78D65CCA001E81C8CA803BEC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pavel Roskin wrote:
> On Tue, 2008-04-22 at 15:25 +0200, Johannes Berg wrote:
>> *Shrug*. I just wanted the kernel to work again and failed (in about 2=
0
>> minutes of searching) to find a changelog for gcc mentioning this so
>> gave up and just added the one that the kernel uses. Want to amend the=

>> patch?
>=20
> I think this would be better.  Now sparse would ignore both "cold" and
> "hot", both with and without underscores.  They are also added to
> ident-list.h.
>=20
> diff --git a/ident-list.h b/ident-list.h
> index 8fcd7de..6104826 100644
> --- a/ident-list.h
> +++ b/ident-list.h
> @@ -74,6 +74,8 @@ IDENT(__malloc__);
>  IDENT(nonnull); IDENT(__nonnull); IDENT(__nonnull__);
>  IDENT(constructor); IDENT(__constructor__);
>  IDENT(destructor); IDENT(__destructor__);
> +IDENT(cold); IDENT(__cold__);
> +IDENT(hot); IDENT(__hot__);
>  IDENT(cdecl); IDENT(__cdecl__);
>  IDENT(stdcall); IDENT(__stdcall__);
>  IDENT(fastcall); IDENT(__fastcall__);
> diff --git a/parse.c b/parse.c
> index 137ba77..877414c 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -353,6 +353,10 @@ static struct init_keyword {
>  	{ "__constructor__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
>  	{ "destructor",	NS_KEYWORD,	.op =3D &ignore_attr_op },
>  	{ "__destructor__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
> +	{ "cold",	NS_KEYWORD,	.op =3D &ignore_attr_op },
> +	{ "__cold__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
> +	{ "hot",	NS_KEYWORD,	.op =3D &ignore_attr_op },
> +	{ "__hot__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
>  };

Looks good to me.  Could I get a signoff and commit message please?

- Josh Triplett


--------------enig78D65CCA001E81C8CA803BEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIEUE+GJuZRtD+evsRAjRZAJ9zt0jsvCbkcZ+QrkLXCSWgIt7rGACfbI+v
nlVR8IbLw7m0BHXI/3uB+YU=
=wmkq
-----END PGP SIGNATURE-----

--------------enig78D65CCA001E81C8CA803BEC--
