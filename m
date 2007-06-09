From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC][PATCH 00/10] Sparse: Git's "make check" target
Date: Sat, 09 Jun 2007 16:50:32 -0700
Message-ID: <466B3CC8.4010508@freedesktop.org>
References: <4669D2F2.90801@ramsay1.demon.co.uk> <466A5204.6060200@freedesktop.org> <20070609225630.GC3008@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig16AF9614489734AED60CE3B1"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:48639 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbXFIXuf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2007 19:50:35 -0400
In-Reply-To: <20070609225630.GC3008@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Junio C Hamano <junkio@cox.net>, GIT Mailing-list <git@vger.kernel.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16AF9614489734AED60CE3B1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sam Ravnborg wrote:
>> Also, you might consider just using cgcc to run both GCC and Sparse.  =
That
>> would handle the issue of target-specific CFLAGS, by ensuring that Spa=
rse and
>> GCC always see the same CFLAGS.
>=20
> Is this the recommended way?
> I that case I suggest that someone looks into the linux kernel part
> and change it to use this method.

The approach taken by Linux allows running sparse on files without recomp=
iling
them.  Using CC=3Dcgcc just makes for less work, but the kernel has that =
work
done now.

- Josh Triplett


--------------enig16AF9614489734AED60CE3B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGazzIGJuZRtD+evsRAqDbAJsGIDnaEQwAi2BSAL+aemsirT7G/QCeLAcb
7rHpo43EvMJtbNZkHhx51lc=
=LbOg
-----END PGP SIGNATURE-----

--------------enig16AF9614489734AED60CE3B1--
