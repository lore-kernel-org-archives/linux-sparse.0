From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] delay removing file scope
Date: Mon, 04 Dec 2006 18:04:10 -0800
Message-ID: <4574D39A.9000703@freedesktop.org>
References: <20061130101608.GB27500@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2245999EE7B4F2CB24604329"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:57977 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968016AbWLECEO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Dec 2006 21:04:14 -0500
In-Reply-To: <20061130101608.GB27500@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2245999EE7B4F2CB24604329
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Sparse only returns the used symbol. By the time it return
> the symbol, it already destroyed the file scope.
>=20
> This patch preserve the file scope. The caller can
> examine the unused symbols. e.g. If I want to generate
> ctags base on sparse, it need those unused symbols.

Merged, thanks.  I look forward to seeing your sparse-based ctags generat=
or; a
ctags which actually *parses C* would provide significant improvements. :=
)

- Josh Triplett



--------------enig2245999EE7B4F2CB24604329
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdNOaGJuZRtD+evsRAiN+AJwM7ED4OGGnx6k3l3lI6rBS2fDscACfczys
Ak3VOpgMS6hwkby0kqXwT3s=
=l1Om
-----END PGP SIGNATURE-----

--------------enig2245999EE7B4F2CB24604329--
