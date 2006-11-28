From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC] <op>= mishandling
Date: Tue, 28 Nov 2006 12:45:33 -0800
Message-ID: <456C9FED.8000102@freedesktop.org>
References: <20061124071247.GO3078@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBECF5B90A4696F12600F144F"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:38803 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1755309AbWK1UqS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Nov 2006 15:46:18 -0500
In-Reply-To: <20061124071247.GO3078@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBECF5B90A4696F12600F144F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> commit 5a627ec02342727b151712acc9c752a8e4f12da0
> Author: Linus Torvalds <torvalds@ppc970.osdl.org>
> Date:   Sat Nov 6 20:10:22 2004 -0700
>=20
>     Don't do assignment replacement at type evaluation time.
>=20
> was too optimistic.  Here's a trivial example of the things going
> wrong with it:
[snip various detailed examples of this going horribly wrong.]
> I'm fixing that crap right now; if somebody has objections against the
> above - please, yell.

No objections; please do.

When you supply the fix, can you please also include one or more test cas=
es
for the validation directory which demonstrate the incorrect evaluation?

Thanks,
Josh Triplett


--------------enigBECF5B90A4696F12600F144F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbJ/tGJuZRtD+evsRAhddAJ9S2yLG0zNP6/Jv4lcDNLwzWA6qbgCffV9D
4ST5nHvozrmVJGJN4ihzZvc=
=sKmi
-----END PGP SIGNATURE-----

--------------enigBECF5B90A4696F12600F144F--
