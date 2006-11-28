From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] trivial: more .gitignore stuff
Date: Tue, 28 Nov 2006 12:31:59 -0800
Message-ID: <456C9CBF.8050408@freedesktop.org>
References: <cbf3148c0611181546s46431944hb1da14c18fe32ae1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD0F77569D1D40EDF6EF6A002"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:31975 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1754876AbWK1UcB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Nov 2006 15:32:01 -0500
In-Reply-To: <cbf3148c0611181546s46431944hb1da14c18fe32ae1@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD0F77569D1D40EDF6EF6A002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Damien Lespiau wrote:
> Ignore tags and git frontends' files.
>=20
> Signed-off-by: Damien Lespiau <damien.lespiau@gmail.com>
> ---
>=20
> diff --git a/.gitignore b/.gitignore
> index 3e12ce7..6a12c5c 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -18,3 +18,15 @@ test-dissect
> test-linearize
> example
> test-unssa
> +
> +# tags
> +tags
> +TAGS
[...]

Looks like something mangled this patch; the context lines should have a =
space
at the beginning.  Manually fixed and merged.

- Josh Triplett


--------------enigD0F77569D1D40EDF6EF6A002
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbJy/GJuZRtD+evsRAj2XAJ95Iy8b5cQ30Kc7okfcCfWQ9YkeXQCfWIsc
rHisP6Ymh5xfPb3vdZe9ymI=
=R4B7
-----END PGP SIGNATURE-----

--------------enigD0F77569D1D40EDF6EF6A002--
