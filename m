From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Fix compilation warning on 64 bits platforms
Date: Sun, 20 May 2007 17:28:37 -0700
Message-ID: <4650E7B5.4030207@freedesktop.org>
References: <11797058752907-git-send-email-damien.lespiau@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFE3722DEB25DE510DA75CB3A"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:59011 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758315AbXEUA2v (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 May 2007 20:28:51 -0400
In-Reply-To: <11797058752907-git-send-email-damien.lespiau@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE3722DEB25DE510DA75CB3A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Damien Lespiau wrote:
> Fix: format '%d' expects type 'int', but argument 2 has type 'long int'=

[...]
> @@ -461,7 +461,7 @@ const char *show_instruction(struct instruction *in=
sn)
>  	}
> =20
>  	if (buf >=3D buffer + sizeof(buffer))
> -		die("instruction buffer overflowed %d\n", buf - buffer);
> +		die("instruction buffer overflowed %d\n", (int)(buf - buffer));

A cast doesn't seem like the right fix.  The difference between two point=
ers
has type ptrdiff_t.  sizeof(ptrdiff_t) =3D=3D 8 on 64-bit platforms, lead=
ing to
the legitimate warning you saw.  This cast would truncate the difference =
to 32
bits.  glibc supplies a "t" length modifier for ptrdiff_t, but I don't th=
ink
sparse can't portably use that.  I don't think we can portably use %llu
either, even though we use long long.  On the other hand, sparse already =
seems
to use %llu.

Obviously 32-bit overflow seems unlikely here, but I don't like using a c=
ast
to shut GCC up when it has a legitimate complaint; I'd prefer to have the=

right fix.

The ideal fix, so we don't have to worry about printf format-string
portability: change this function to cleanly *prevent* instruction buffer=

overflows rather than detecting them after the fact. :)

- Josh Triplett



--------------enigFE3722DEB25DE510DA75CB3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGUOe1GJuZRtD+evsRAskIAJ9FISIvSHyIRWYNTsK86LBtlnLMggCfUHTp
uakoVZY7F0mDqXkHkjloKMo=
=f9EP
-----END PGP SIGNATURE-----

--------------enigFE3722DEB25DE510DA75CB3A--
