From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [TRIVIAL][PATCH] trivial fix for seg fault.
Date: Tue, 28 Nov 2006 12:27:25 -0800
Message-ID: <456C9BAD.90801@freedesktop.org>
References: <20061123074553.GA9322@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDBF970E46B74AF6524AD2FE7"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:37330 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1756935AbWK1U12 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Nov 2006 15:27:28 -0500
In-Reply-To: <20061123074553.GA9322@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDBF970E46B74AF6524AD2FE7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Trivial fix for some seg fault.
>=20
> Signed-Off-By: Christopher Li <sparse@chrisli.org>
>=20
> Index: sparse/token.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- sparse.orig/token.h	2006-11-22 23:34:35.000000000 -0800
> +++ sparse/token.h	2006-11-22 23:36:28.000000000 -0800
> @@ -94,7 +94,7 @@
>  	"||", "|=3D",		\
>  	"^=3D", "##",		\
>  	"<<", ">>", "..",	\
> -	"<<=3D", ">>=3D", "..."	\
> +	"<<=3D", ">>=3D", "...",	\
>  	"",			\
>  	"<", ">", "<=3D", ">=3D"	\
>  }

Merged, thanks.

- Josh Triplett



--------------enigDBF970E46B74AF6524AD2FE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbJutGJuZRtD+evsRAnycAJ9/C0iWvSy4u10ncWazwKbrfN4YUQCgvjr9
x3aYeSd5oO1nkGKQoOqzZkY=
=7zrl
-----END PGP SIGNATURE-----

--------------enigDBF970E46B74AF6524AD2FE7--
