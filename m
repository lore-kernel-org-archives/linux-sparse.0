From: Josh Triplett <josh@freedesktop.org>
Subject: Re: How do I get the latest sparse?
Date: Tue, 16 Jan 2007 21:41:49 -0800
Message-ID: <45ADB71D.3080502@freedesktop.org>
References: <AKEOJDDJLNPHDAKOMMBHCEGHCPAA.mshah@teja.com> <20070116001735.GA12002@chrisli.org> <45ACC3DD.6050702@freedesktop.org> <20070117014923.GA641@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC7C6D6FE9E352C7E43CE8602"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:46875 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbXAQFlw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Jan 2007 00:41:52 -0500
In-Reply-To: <20070117014923.GA641@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC7C6D6FE9E352C7E43CE8602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Tue, Jan 16, 2007 at 04:23:57AM -0800, Josh Triplett wrote:
>> I've followed all the patches on linux-sparse, and I have tested sever=
al of
>> them in local git; I just haven't pushed out new bits.  I particularly=
 look
>=20
> Great to know you are back. I can resend my stack of patches now :-)

In general, you only need to resend if you have changes.  Otherwise, I ca=
n
just use the previous versions you mailed. :)

Currently working my way through your resent patches.

>> forward to integrating your NULL pointer checking code, and I think I =
can
>=20
> I haven't get much feed back of the new checking code yet.

Expect some comments in response to your new patch shortly.

> I will refresh my patch as well.

It probably still applied. :)

> Without cross function/file checking, the interrupt checking generates =
way
> too many false positives.

Sounds a lot like the context checking. :)

The use of strcmp on asm strings for x86 instruction mnemonics seems like=
 a
problem, though.

> I am working on the cross file checking right now.

Excellent.  I would welcome any attempts at cross-function and cross-file=

checking, rather than continuing to add annotations for that purpose.

- Josh Triplett


--------------enigC7C6D6FE9E352C7E43CE8602
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrbcdGJuZRtD+evsRApeeAKChdG/awiChTiQxTmJD6klqWG0vUQCgocPO
nlgxuB7KFU/aR2h1Taewpm8=
=2uN0
-----END PGP SIGNATURE-----

--------------enigC7C6D6FE9E352C7E43CE8602--
