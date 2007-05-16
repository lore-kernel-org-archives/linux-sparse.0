From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Ignore the cdecl and stdcall attributes for now.
Date: Tue, 15 May 2007 23:32:27 -0700
Message-ID: <464AA57B.3010205@freedesktop.org>
References: <20070515220536.GA23923@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB91F2012A7BD2925AE95A21A"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:55426 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431AbXEPGcg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 May 2007 02:32:36 -0400
In-Reply-To: <20070515220536.GA23923@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB91F2012A7BD2925AE95A21A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael Stefaniuc wrote:
> Wine uses the __stdcall__ attribute extensively. The effects of the
> patch on a sparse run on the Wine code are:
> - Removes 143000 "attribute '__stdcall__': unknown attribute" errors.
> - Removes 116 "attribute '__cdecl__': unknown attribute" errors.
> - Reduces the amount of "error: too many errors" from 1992 to 1459.
>=20
> Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>

Applied, along with a test case.  Thanks!

I'd love to see the results you get with Wine; in particular, I'd love to=
 see
and fix any parse errors.  Would you consider posting a build log somewhe=
re
with latest Sparse from Git?

Did you integrate Sparse into the Wine build system, or did you use CC=3D=
cgcc?

- Josh Triplett


--------------enigB91F2012A7BD2925AE95A21A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGSqV7GJuZRtD+evsRAmYuAJ46n2bDLH3vYLA/xqhHqIZ+SJt4LACfd4KC
du2luPhJAYpkr5oI9265T0o=
=98zw
-----END PGP SIGNATURE-----

--------------enigB91F2012A7BD2925AE95A21A--
