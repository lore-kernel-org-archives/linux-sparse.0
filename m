From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC] infinite loop in free_preprocessor_line()
Date: Sun, 03 Jun 2007 15:27:35 -0700
Message-ID: <46634057.1000709@freedesktop.org>
References: <20070526002437.GB5786@martell.zuzino.mipt.ru> <4658D24E.30607@freedesktop.org> <20070602215526.GA5710@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5506ECADCEDC12B95F62FAD1"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:35550 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbXFCW1q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 3 Jun 2007 18:27:46 -0400
In-Reply-To: <20070602215526.GA5710@martell.zuzino.mipt.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5506ECADCEDC12B95F62FAD1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alexey Dobriyan wrote:
> On Sat, May 26, 2007 at 05:35:26PM -0700, Josh Triplett wrote:
>> Alexey Dobriyan wrote:
>>> While running if-2.c from gcc testsuite sparse goes into infinite loo=
p in
>>> free_preprocessor_line().
>>>
>>> Trimmed down test-case is
>>>
>>> 	#if 1
>>> 	#if
>>>
>>> (two lines)
>> Thanks for this fix.
>>
>> Can I get a Signed-off-by for this patch, please?
>=20
> Sorry, lost email in noise
>=20
> Patch is Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Thanks.  Applied, along with the test case.

- Josh Triplett



--------------enig5506ECADCEDC12B95F62FAD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGY0BXGJuZRtD+evsRAvdeAJwPiPSFhUF56iQRS3ZmAjKxsFNYCgCfSU6Q
9Bc5emBn74cmW6ZP0g85rWM=
=1MKF
-----END PGP SIGNATURE-----

--------------enig5506ECADCEDC12B95F62FAD1--
