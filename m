From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: source code transform
Date: Wed, 07 Jan 2009 20:03:16 +0100
Message-ID: <1231354996.3545.80.camel@johannes>
References: <a15fe1ffe7f7a6faf8f79d4ac780b663@mail.smartmobili.com>
	 (sfid-20090107_195448_954457_6DD33448)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HeE4CAnHsBOHfmSfijka"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:36130 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760643AbZAGTCv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Jan 2009 14:02:51 -0500
In-Reply-To: <a15fe1ffe7f7a6faf8f79d4ac780b663@mail.smartmobili.com> (sfid-20090107_195448_954457_6DD33448)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: mosfet <forumer@smartmobili.com>
Cc: linux-sparse@vger.kernel.org


--=-HeE4CAnHsBOHfmSfijka
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-07 at 19:48 +0100, mosfet wrote:

> I would like to know if sparse would be able to parse GCC source file to
> add a comment in each function it encounters ?
> For instance let's say I want to trace every function in c-parser.c :
>=20
>=20
> static struct c_typespec
> c_parser_enum_specifier (c_parser *parser)
> {
> ...
>=20
> }
>=20
> in a first step I would like to modify source code like this :
>=20
> static struct c_typespec
> c_parser_enum_specifier (c_parser *parser)
> {
>  fprintf(stderr, "c-parser.c: c_parser_enum_specifier()\n");
> ...
>=20
> }
>=20
> is it possible with sparse ?

Not sure, but spatch might be able to:

http://www.emn.fr/x-info/coccinelle/

johannes

--=-HeE4CAnHsBOHfmSfijka
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJZPxyAAoJEKVg1VMiehFYbhkP/RAH6W7pyhAOkIN9bnEIDgd6
cPdl0VgddKEyACTt5iFaJAYzk9h6CayYBwvPtLxPRjBJGwrGiSjGc9xNGTnb39Ha
nQz7iMcqQkV3MhWoxN2K//ilaGAjTga7J/RvdIbIzecPznh9MlsGXnXoi90BeKD9
UiqJ7S3ihlCObnpUKdIapHHVrnXPZ7AeCrZZtUwk+dtJeOyWcQE74/XmTgZlTrqr
t9eU86Wf+X6pw9RqaUdLTIBEfAX0MpKAZh3Iq1Fqma+ONoLUa1IC7QLLgrDFlMgD
+l+s7GLDnSla7W1cfCA+mwHWBQzBkECEeDfQtPUMxFb+Oe0Pm4jdu7YSNwSJpxNb
BJ6/udmwaMtH99Vyl/aAKDtpajNyXtv8hHxEYDj7sZ1f0BBXZQ2/8OgnDRS4cbJF
QpxgOSY41hK0oPuLYi5PMDE8aHMS/OMqV4ChoBBlYvo5TJvuPQSbHFgRgN7MBqBj
5W9C49ZmEm7nM0xKC6MXsTkcN6eHrHpdkBfIzsAexzZXEvXToncu7/+lso7ZuMRT
h5CsB4YNi4aLNtsoEHFQEgoXw91aAF+PNOXamGado/KBmcioMhVTWlsVK1yRVUat
a3uXGEd9vxcOe3tPG+3poScovVYpskO7Wam/ptneX2SIBEPFkrc9UjIIqc8x5dxN
Vbsbq2t+jefvcYyNGcX8
=IXnA
-----END PGP SIGNATURE-----

--=-HeE4CAnHsBOHfmSfijka--

