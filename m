From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 4/5] Fix an __attribute__() parsing error
Date: Tue, 22 May 2007 15:37:54 -0700
Message-ID: <465370C2.3010801@freedesktop.org>
References: <46533263.3010108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF4AFA16710DDD1873819C2F4"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:36206 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062AbXEVWif (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 18:38:35 -0400
In-Reply-To: <46533263.3010108@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@redhat.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF4AFA16710DDD1873819C2F4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ramsay Jones wrote:
>=20
> When updating this patch from the 0.3 version, I made the (new) third p=
arameter
> KW_ATTRIBUTE only, rather than (KW_ATTRIBUTE | KW_ASM), since it did no=
t seem
> correct to allow an asm there; is that correct?

Correct; I don't think you can have an asm there.

> The test case for this was abstracted from an example in the "expat.h" =
header file.
>=20
> $cat ape.c
>=20
> typedef void (__attribute__((__cdecl__)) *FP)(void *u, const char *n);
>=20
> void set_FP(void *cb, FP f);

Applied.  I think you just made a Wine developer very happy.  Michael, th=
is
patch fixes the test case you provided for Wine; I applied your patch for=
 the
new test case.

Thanks, Ramsay!

- Josh Triplett



--------------enigF4AFA16710DDD1873819C2F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU3DCGJuZRtD+evsRAjpyAJ4poV1wOyx8Wlrieg7+hLBB8HrZ7ACcDhoS
3YI2EBgL5cihCFl2v9q6y4o=
=Cgr8
-----END PGP SIGNATURE-----

--------------enigF4AFA16710DDD1873819C2F4--
