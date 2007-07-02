From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 6/6] Add a simple test script, embed expected results
 into test files
Date: Sun, 01 Jul 2007 22:19:00 -0700
Message-ID: <46888AC4.4050005@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>	 <20070628054019.30704.64375.stgit@dv.roinet.com>	 <46836129.7050407@freedesktop.org>	 <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>	 <1183066733.2621.127.camel@josh-work.beaverton.ibm.com>	 <cbf3148c0706281713l793c944fp372a2f91f6f9b18c@mail.gmail.com>	 <1183076949.2621.196.camel@josh-work.beaverton.ibm.com> <cbf3148c0707012159l65432435we10fd9370c282dc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD2FC7256954B6D122BB59334"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:47976 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbXGBFTQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Jul 2007 01:19:16 -0400
In-Reply-To: <cbf3148c0707012159l65432435we10fd9370c282dc4@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD2FC7256954B6D122BB59334
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Damien Lespiau wrote:
> A small update,
>=20
>> Yes, but I still prefer the delimited format for readability.
>=20
> Ok: expected output is now between check-output-start / check-output-en=
d
> tags.
> I've added a clean-check target in the Makefile, updated the provided
> test-cases and documentation.

Thanks!  Will review and apply soon.

>> You can't redirect two things independently to the same file; that wil=
l
>> open the file twice, and the writes will conflict, giving exactly the
>> result you saw.  > o 2>&1 should work; it has exactly the same effect =
as
>> &> .
>=20
> For some reason I was expecting that:
>=20
> [pid  8877] open("o", O_WRONLY|O_CREAT|O_TRUNC| \
>         O_LARGEFILE, 0666) =3D 3
> [pid  8877] dup2(3, 1)                  =3D 1
> [pid  8877] close(3)                    =3D 0
> [pid  8877] open("o", O_WRONLY|O_CREAT|O_TRUNC| \
>         O_LARGEFILE, 0666) =3D 3
> [pid  8877] dup2(3, 2)                  =3D 2
> [pid  8877] close(3)                    =3D 0
>=20
> and
>=20
> [pid 10777] open("o", O_WRONLY|O_CREAT|O_TRUNC| \
>         O_LARGEFILE, 0666) =3D 3
> [pid 10777] dup2(3, 1)                  =3D 1
> [pid 10777] close(3)                    =3D 0
> [pid 10777] dup2(1, 2)                  =3D 2
>=20
> followed by:
>=20
> [pid  xxxxx] write(2, "validation/preprocessor19.c:4:9:"..., 73) =3D 73=

> [pid  xxxxx] write(2, "validation/preprocessor19.c:3:9:"..., 66) =3D 66=

> [pid  xxxxx] write(1, "\ny\n", 3)        =3D o
>=20
> to give the same result and that the first one would not eat characters=
=2E

In the first case, fd 1 and fd 2 represent separate open files, and have
independent file offsets; thus, writes through the two file descriptors
overwrite each other.  In the second case, fd 1 and fd 2 represent the sa=
me
open file, and have the same file offset, so writes to either one appear =
in
the file in sequence.

- Josh Triplett


--------------enigD2FC7256954B6D122BB59334
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGiIrQGJuZRtD+evsRAl/JAJ9uW8uuLNso9aQdYkYfOC3fiEuJ9QCgwVYU
tsaqidayIhJyD2m50qKrEHE=
=GHJM
-----END PGP SIGNATURE-----

--------------enigD2FC7256954B6D122BB59334--
