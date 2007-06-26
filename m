From: Josh Triplett <josh@freedesktop.org>
Subject: Re: support for C++ ?
Date: Tue, 26 Jun 2007 06:10:27 -0700
Message-ID: <46811043.90207@freedesktop.org>
References: <Pine.LNX.4.64.0706252219310.12395@paik.artengine.ca> <4680A013.8030707@freedesktop.org> <4680F209.7070601@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE566E768257A63A71FA40AFC"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:48727 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbXFZNLZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2007 09:11:25 -0400
In-Reply-To: <4680F209.7070601@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mathieu Bouchard <matju@artengine.ca>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE566E768257A63A71FA40AFC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Josh Triplett wrote:
>> To the best of my knowledge, nobody involved in the Sparse community h=
as any
>> plans to attempt C++.  I also think that a subset of the language capa=
ble of
>> handling any significant number of common programs would end up contai=
ning
>> most of the language.  Even basic support for C++ would require large =
changes
>> to the parser and to the Sparse data structures, and that doesn't even=
 count
>> the huge can of worms that would open once you start running into inte=
ractions
>> between Sparse-annotated types and inheritance or overloading.
>=20
> Indeed.  The gcc people even wrote their own hand-coded C++ parser for =

> similar reasons, so I can't see it being an easy integration into=20
> sparse.  You might as well fork at that point.

While a C++ parser would add significant complexity to Sparse, I would st=
ill
prefer to integrate it rather than encouraging people to fork.  I think a=

reasonable amount of code sharing would still exist between the C and C++=

code, and ideally almost all of the backend code would support both.

- Josh Triplett


--------------enigE566E768257A63A71FA40AFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgRBDGJuZRtD+evsRAiJ1AKCFSmHF66qAugupW2DHya5DCW944QCcDBbM
XZzbZwaOqmVj9ueHPyaOeYU=
=0rt7
-----END PGP SIGNATURE-----

--------------enigE566E768257A63A71FA40AFC--
