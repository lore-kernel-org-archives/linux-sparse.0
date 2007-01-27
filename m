From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 8] Enhance debug information.
Date: Sat, 27 Jan 2007 00:48:42 -0800
Message-ID: <45BB11EA.4060409@freedesktop.org>
References: <20070117024239.GI962@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig518AAA67EF57DB87D55ED583"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:35790 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbXA0Isp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Jan 2007 03:48:45 -0500
In-Reply-To: <20070117024239.GI962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig518AAA67EF57DB87D55ED583
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> I found it very useful for debug_symbol to show the builtin
> type name.

Applied, with one minor style fix noted below.

> Signed-off-by: Christopher Li<sparse@chrisli.org>
>=20
> Index: sparse/symbol.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- sparse.orig/symbol.h	2006-12-14 20:26:32.000000000 -0800
> +++ sparse/symbol.h	2006-12-14 20:28:01.000000000 -0800
> @@ -239,6 +239,8 @@ extern void bind_symbol(struct symbol *,
>  extern struct symbol *examine_symbol_type(struct symbol *);
>  extern void examine_simple_symbol_type(struct symbol *);
>  extern const char *show_typename(struct symbol *sym);
> +extern const char* builtin_typename(struct symbol *sym);
> +extern const char* builtin_ctypename(struct ctype *ctype);

The * goes next to the name, not the type:
=2E..char *builtin_..., not ...char* builtin_...

(The same issue applied to the definition of these two functions as well.=
)

- Josh Triplett



--------------enig518AAA67EF57DB87D55ED583
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuxHqGJuZRtD+evsRAhu/AJ9ANfkprub1uscnmWpFPCirKL9OpACeMtBv
qclQxEvd0y8nOARoJD4WwWA=
=a4vu
-----END PGP SIGNATURE-----

--------------enig518AAA67EF57DB87D55ED583--
