From: Josh Triplett <josh@freedesktop.org>
Subject: Re: support for C++ ?
Date: Mon, 25 Jun 2007 22:11:47 -0700
Message-ID: <4680A013.8030707@freedesktop.org>
References: <Pine.LNX.4.64.0706252219310.12395@paik.artengine.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB61598D2713FFB19D81E8CEE"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:55419 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXFZFMl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2007 01:12:41 -0400
In-Reply-To: <Pine.LNX.4.64.0706252219310.12395@paik.artengine.ca>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mathieu Bouchard <matju@artengine.ca>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB61598D2713FFB19D81E8CEE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Mathieu Bouchard wrote:
> Are there any plans for supporting C++ or any subset thereof? (e.g.=20
> parsing G++4 syntax but perhaps skipping over some constructs that are =

> difficult to handle if it's too much work for now)

To the best of my knowledge, nobody involved in the Sparse community has =
any
plans to attempt C++.  I also think that a subset of the language capable=
 of
handling any significant number of common programs would end up containin=
g
most of the language.  Even basic support for C++ would require large cha=
nges
to the parser and to the Sparse data structures, and that doesn't even co=
unt
the huge can of worms that would open once you start running into interac=
tions
between Sparse-annotated types and inheritance or overloading.

I certainly won't rule the idea out; if someone wants to submit clean pat=
ches
adding C++ support to Sparse, I would take them.  At the lowest level, co=
de
should still end up looking much like the current Sparse bytecode format.=

However, such a project would require a monumental coding effort.

The same thing applies to other C-like languages.

- Josh Triplett


--------------enigB61598D2713FFB19D81E8CEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgKATGJuZRtD+evsRAlDuAKCEGdL6a46A5L2Yz/uVRUi2/ByDrQCeM3+e
UGDPAxC6QtIt6IH/fZidsEM=
=A0nj
-----END PGP SIGNATURE-----

--------------enigB61598D2713FFB19D81E8CEE--
