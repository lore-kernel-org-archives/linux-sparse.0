From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 7] Allow more than one command line include file.
Date: Sat, 27 Jan 2007 00:39:40 -0800
Message-ID: <45BB0FCC.1090700@freedesktop.org>
References: <20070117024005.GG962@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig987E834EAE79D39E6096FEE4"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:40935 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbXA0Ijn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Jan 2007 03:39:43 -0500
In-Reply-To: <20070117024005.GG962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig987E834EAE79D39E6096FEE4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> --- sparse.orig/lib.c	2006-12-05 16:17:39.000000000 -0800
> +++ sparse/lib.c	2006-12-22 01:51:00.000000000 -0800
> @@ -192,7 +192,10 @@ int Wdo_while =3D 1;
>  int Wuninitialized =3D 1;
>  int preprocess_only;
>  char *include;
> -int include_fd =3D -1;
> +
> +#define CMDLINE_INCLUDE 20
> +int cmdline_include_nr =3D 0;
> +struct cmdline_include cmdline_include[CMDLINE_INCLUDE];
[...]

I've accepted this patch for now, since a larger finite limit will solve =
the
current problem.  I'd really like to see something which handles an arbit=
rary
number of include files, though.  Also, ideally Sparse could read each
filename, parse that include file, and close it, rather than keeping all =
the
include files open; doing something like that might even avoid the need t=
o
keep them around in an array.

- Josh Triplett


--------------enig987E834EAE79D39E6096FEE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuw/MGJuZRtD+evsRAmq5AKChARekVR96pXtHwLqkYbCoP+0JrQCdHKWZ
G1iksfcGFYmFPjwDU83t22s=
=6qGB
-----END PGP SIGNATURE-----

--------------enig987E834EAE79D39E6096FEE4--
