From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Official releases?
Date: Fri, 03 Nov 2006 21:16:29 -0800
Message-ID: <454C222D.8000901@freedesktop.org>
References: <1162307025.11613.1.camel@zod.rchland.ibm.com>	 <4547B3C7.5030608@freedesktop.org> <1162327518.26960.0.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE6D149A71CBCDB16D7CCB96D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:14764 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1753595AbWKDFQd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 4 Nov 2006 00:16:33 -0500
In-Reply-To: <1162327518.26960.0.camel@zod.rchland.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6D149A71CBCDB16D7CCB96D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Josh Boyer wrote:
> On Tue, 2006-10-31 at 12:36 -0800, Josh Triplett wrote:
>> Josh Boyer wrote:
>>> I'm just curious if anyone is ever really going to do an "official"
>>> release of sparse.  We've got daily snapshots provided by Dave Jones,=

>>> and git of course, but will an official release tarball with shiny
>>> version numbers and everything be created?
>> Since sparse doesn't use any autofoolery, and doesn't include a versio=
n number
>> in the source anywhere, making a release should just require running g=
it tag
>> and git archive, and putting the resulting tarball up in an official l=
ocation.
>> As far as version numbering, it seems reasonable to use the former ker=
nel
>> versioning system: major.oddeven.revision, starting from something lik=
e 0.1.0,
>> and keeping major version 0 until sparse can comfortably provide some
>> guarantee of backward compatibility for sparse extensions.  Thus, peri=
odic
>> releases (0.1.1, 0.1.2, ...) wouldn't take much effort at all, and eve=
ntually
>> calling one "stable" (0.2.0, with crash-fixes an similar backported to=
 produce
>> 0.2.1, 0.2.2, ...) would mostly consist of a judgement call.
>=20
> Great.  Did you see Linus' email suggesting that I ask you to do
> this? :)

I did, and I plan to roll a release this weekend.

- Josh Triplett



--------------enigE6D149A71CBCDB16D7CCB96D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFTCItGJuZRtD+evsRAmtIAJ97+BEmzs0geRYr8UmbtHhTPWL8rgCgvfzP
fkF7qNj7U/g2HM15hgzBC1g=
=09iF
-----END PGP SIGNATURE-----

--------------enigE6D149A71CBCDB16D7CCB96D--
