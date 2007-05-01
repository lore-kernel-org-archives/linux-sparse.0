From: Josh Triplett <josh@freedesktop.org>
Subject: Re: C++ support
Date: Tue, 01 May 2007 10:50:37 -0700
Message-ID: <46377DED.5070608@freedesktop.org>
References: <DAE2DE304D25FE4FA8D2B55FBB0842DA010B73@sjvm-exch01.arc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFB64FF555E83317B9B3D48BB"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:49593 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbXEARuk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 13:50:40 -0400
In-Reply-To: <DAE2DE304D25FE4FA8D2B55FBB0842DA010B73@sjvm-exch01.arc.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mitesh Shah <Mitesh.Shah@arc.com>
Cc: "Linux-Sparse (E-mail)" <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFB64FF555E83317B9B3D48BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Mitesh Shah wrote:
> Has any one have any idea about how to sparse C++ code? Is there any
> wrapper or converter to convert it to C before passing it to sparse?

Sparse doesn't support C++ natively.  In theory, someone could write a C+=
+
frontend that provides similar output to the C frontend (same data struct=
ures
and linearized bytecode format), but barring someone providing the *huge*=
 pile
of code this would require *and* committing to support it, I don't see th=
is
happening anytime soon.  (That said, if someone genuinely has an interest=
 in
doing so, feel free to contact linux-sparse@vger.kernel.org to coordinate=
=2E)

Some tools exist to translate C++ to C, most of them proprietary and most=
 of
them quite old.  Some of them come from the days when everyone used such =
tools
to compile C++ in the first place.  To the best of my knowledge, all of t=
hese
tools primarily target the ability to compile with a C compiler; they don=
't
target easily readable C code.  If you could manage to get the Sparse key=
words
to pass through them into the C code, you *might* manage to get some usef=
ul
semantic warnings out of one of them, such as locking validation or
user/kernel pointer checking, though you'd have to wade through a lot of =
noise
to find them.

- Josh Triplett


--------------enigFB64FF555E83317B9B3D48BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGN33tGJuZRtD+evsRAqA0AJ93FGir4E6PyDUquUS/w3R7yoWK5wCeMpgz
DF+tNs8FeGO+OthEKJm0HPI=
=EnEs
-----END PGP SIGNATURE-----

--------------enigFB64FF555E83317B9B3D48BB--
