From: Johannes Berg <johannes@sipsolutions.net>
Subject: sparse missing bitwise warnings with dubious bitfields
Date: Fri, 08 Jun 2007 10:24:10 +0200
Message-ID: <1181291050.6533.19.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-S+YzpUUZoCxsy5RUL+TD"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:60062 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbXFHIXx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2007 04:23:53 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse <linux-sparse@vger.kernel.org>
Cc: Michael Wu <flamingice@sourmilk.net>, Christoph Hellwig <hch@infradead.org>


--=-S+YzpUUZoCxsy5RUL+TD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Not sure if this is intended but it is surely quite weird. Take the
following code:

--- begin code ---
#ifdef DUBIOUS
struct { =20
  int x:1;
};
#endif

typedef unsigned short __attribute__((bitwise)) __le32;

int main(int argc, char **argv)
{
  __le32 i =3D 5;
}
--- end code ---

and save it as test.c, and then observe:

$ sparse test.c
test.c:11:14: warning: incorrect type in initializer (different base types)
test.c:11:14:    expected restricted unsigned short [usertype] i
test.c:11:14:    got int=20

$ sparse test.c -DDUBIOUS
test.c:3:10: error: dubious one-bit signed bitfield

[note that no warning about the bitwise error is there!]

johannes

--=-S+YzpUUZoCxsy5RUL+TD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGaRIp/ETPhpq3jKURApcGAKCxdZt5VeSqwDfp/9CWvNS48TuxpACeI8KE
H77CsLyJCKlISOi+THJmMQM=
=gSGh
-----END PGP SIGNATURE-----

--=-S+YzpUUZoCxsy5RUL+TD--
