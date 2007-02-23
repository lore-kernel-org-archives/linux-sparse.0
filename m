From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Re: __attribute__ annotations and struct types
Date: Thu, 22 Feb 2007 18:23:19 -0800
Message-ID: <45DE5017.6030202@freedesktop.org>
References: <1171483314.14504.9.camel@systems03.mmm.com>	 <20070214201549.GB18753@chrisli.org> <1171486927.8554.0.camel@systems03.mmm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig796E47C6493C99BEFA6726E8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [69.17.117.3] ([69.17.117.3]:52549 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750714AbXBWCXz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Feb 2007 21:23:55 -0500
In-Reply-To: <1171486927.8554.0.camel@systems03.mmm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Drake <ddrake@brontes3d.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig796E47C6493C99BEFA6726E8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Daniel Drake wrote:
> On Wed, 2007-02-14 at 12:15 -0800, Christopher Li wrote:
>> On Wed, Feb 14, 2007 at 03:01:54PM -0500, Daniel Drake wrote:
>>> sparse doesn't like it:
>>>
>>> 	test.c:7:8: error: Trying to use reserved word '__attribute__'=20
>>> 	as identifier
>> Can you please try this:
>>
>> Chris
>>
>> Handle structure attribute.
>=20
> Thanks for the quick response, works nicely!

Applied, along with a test case.

- Josh Triplett



--------------enig796E47C6493C99BEFA6726E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3lAXGJuZRtD+evsRAvT8AJ9w7E+YbG6HitjflQCkK54UkapEHgCeJJFJ
/xT9gTmvBLXTvr7U9zQWUq0=
=eRFk
-----END PGP SIGNATURE-----

--------------enig796E47C6493C99BEFA6726E8--
