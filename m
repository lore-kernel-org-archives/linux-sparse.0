From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 6/6] Add a simple test script, embed expected results
 into test files
Date: Sun, 08 Jul 2007 14:52:30 -0700
Message-ID: <46915C9E.503@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>	 <20070628054019.30704.64375.stgit@dv.roinet.com>	 <46836129.7050407@freedesktop.org>	 <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>	 <1183066733.2621.127.camel@josh-work.beaverton.ibm.com>	 <cbf3148c0706281713l793c944fp372a2f91f6f9b18c@mail.gmail.com>	 <1183076949.2621.196.camel@josh-work.beaverton.ibm.com> <cbf3148c0707012159l65432435we10fd9370c282dc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCF2776401E45DC027D77103A"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:48335 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757265AbXGHVwo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Jul 2007 17:52:44 -0400
In-Reply-To: <cbf3148c0707012159l65432435we10fd9370c282dc4@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF2776401E45DC027D77103A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I've applied Damien's test-suite patches.  I've started making use of the=
 test
suite, and adding the test-suite comments to more files in validation.  I=
 find
it a pleasure to work with; thanks, Damien!

Thanks to Pavel as well, for pushing automated testing to begin with, and=
 for
contributing to the final result.

Damien, I noticed one minor issue with test-suite: it seems to eat whites=
pace
in the Sparse output, making "test-suite format" for several of the
preprocessor tests (such as preprocessor18.c) not match the actual output=
=2E  I
would guess some kind of quoting problem.  Here documents may not do what=
 you
want.  Could you take a look at that, please?

- Josh Triplett


--------------enigCF2776401E45DC027D77103A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkVyfGJuZRtD+evsRAr+QAJ9p+9NDzyIsEbvl15C02ih/MyjgSACeP0H+
dPKP2hHQWPed9srrdmGm+R0=
=+8oV
-----END PGP SIGNATURE-----

--------------enigCF2776401E45DC027D77103A--
