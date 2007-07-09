From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 6/6] Add a simple test script, embed expected results
 into test files
Date: Sun, 08 Jul 2007 19:15:40 -0700
Message-ID: <46919A4C.3090602@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>	 <20070628054019.30704.64375.stgit@dv.roinet.com>	 <46836129.7050407@freedesktop.org>	 <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>	 <1183066733.2621.127.camel@josh-work.beaverton.ibm.com>	 <cbf3148c0706281713l793c944fp372a2f91f6f9b18c@mail.gmail.com>	 <1183076949.2621.196.camel@josh-work.beaverton.ibm.com> <cbf3148c0707012159l65432435we10fd9370c282dc4@mail.gmail.com> <46915C9E.503@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB1B5ABD41A6A7A95F7EDB533"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:42015 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583AbXGICPz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Jul 2007 22:15:55 -0400
In-Reply-To: <46915C9E.503@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1B5ABD41A6A7A95F7EDB533
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Josh Triplett wrote:
> Damien, I noticed one minor issue with test-suite: it seems to eat whit=
espace
> in the Sparse output, making "test-suite format" for several of the
> preprocessor tests (such as preprocessor18.c) not match the actual outp=
ut.  I
> would guess some kind of quoting problem.  Here documents may not do wh=
at you
> want.  Could you take a look at that, please?

Actually, this led me to a more important issue: I don't think the test s=
uite
output can mix stdout and stderr safely, because the order may differ if =
both
have data.  Look at preprocessor18.c for an example.  I think the test su=
ite
needs to have a block for check-stdout-{start,end} and a block for
check-stderr-{start,end}.

- Josh Triplett


--------------enigB1B5ABD41A6A7A95F7EDB533
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkZpMGJuZRtD+evsRAhv6AJ9zAadj/jrmQ38PnsdUQdqqUT57bACaA/dM
T9p3PFGuY/0mvw0TPtWsTxo=
=tp4l
-----END PGP SIGNATURE-----

--------------enigB1B5ABD41A6A7A95F7EDB533--
