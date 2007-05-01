From: Josh Triplett <josh@freedesktop.org>
Subject: Variable "combinations" in tokenize.c and token.h
Date: Tue, 01 May 2007 14:29:10 -0700
Message-ID: <4637B126.7050100@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5083CE1511615A3F2D40DDE3"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:33019 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423664AbXEAV3P (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 17:29:15 -0400
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 1 May 2007 21:29:12 -0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5083CE1511615A3F2D40DDE3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

token.h contains this:
> /* Combination tokens */
> #define COMBINATION_STRINGS {   \
>         "+=3D", "++",             \
>         "-=3D", "--", "->",       \
>         "*=3D",                   \
>         "/=3D",                   \
>         "%=3D",                   \
>         "<=3D", ">=3D",             \
>         "=3D=3D", "!=3D",             \
>         "&&", "&=3D",             \
>         "||", "|=3D",             \
>         "^=3D", "##",             \
>         "<<", ">>", "..",       \
>         "<<=3D", ">>=3D", "...",    \
>         "",                     \
>         "<", ">", "<=3D", ">=3D"    \
> }
>=20
> extern unsigned char combinations[][3];

tokenize.c contains this:
> const char *show_special(int val)
> {
>         static const char *combinations[] =3D COMBINATION_STRINGS;
>         static char buffer[4];
>=20
>         buffer[0] =3D val;
>         buffer[1] =3D 0;
>         if (val >=3D SPECIAL_BASE)
>                 strcpy(buffer, combinations[val - SPECIAL_BASE]);
>         return buffer;
> }
[...]
> unsigned char combinations[][3] =3D COMBINATION_STRINGS;

Apart from triggering a -Wshadow warning, this seems somewhat wasteful.
The reason appears to relate to the presence or absence of a '\0'
terminator at the end of each item.  Does that matter?  Could
show_special change somehow to avoid the duplication?  Alternatively,
could the global version just include '\0' terminators?

- Josh Triplett


--------------enig5083CE1511615A3F2D40DDE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGN7EmGJuZRtD+evsRAiqvAJ99pcDbgGksW4n2Kn9yEMGiLxTUtwCfYfXd
108YQ2RyRgYHyxWD2KW30II=
=lOpc
-----END PGP SIGNATURE-----

--------------enig5083CE1511615A3F2D40DDE3--
