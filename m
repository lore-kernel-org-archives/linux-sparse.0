From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Thu, 28 Jun 2007 00:38:55 -0700
Message-ID: <4683658F.1030902@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com> <20070628055850.GE21478@ftp.linux.org.uk> <46834FA0.8010201@freedesktop.org> <46835471.4070000@garzik.org> <46835B0F.4080606@freedesktop.org> <46835CBE.6010608@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig469F8393C0F7320B0B1D06ED"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:53218 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759486AbXF1HjA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 03:39:00 -0400
In-Reply-To: <46835CBE.6010608@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig469F8393C0F7320B0B1D06ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Josh Triplett wrote:
>> However, in the meantime, GCC doesn't seem to have any such thing.  Ho=
w do we
>> want to implement it in Sparse?  I don't think we have enough informat=
ion on
>> the GCC command line.  I suppose we could allow specifying an architec=
ture
>> explicitly; for cgcc, we could also allow specifying the compiler name=
 for
>> cross-compilation and then deriving the architecture name from the com=
piler
>> name if not explicitly specified.
>=20
> Judging from existing software, "--target foo" to set the target arch=20
> should be familiar to many.  If not specified, detect the current arch =

> at runtime, and use the results of the detection as the target arch.

Sounds reasonable.

- Josh Triplett



--------------enig469F8393C0F7320B0B1D06ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg2WPGJuZRtD+evsRAhchAKCsvNdhqhjAiwUBzdQ4dGCND+GPYACfdrIo
5wJmbEqqCuMxsJPP7nENaY4=
=RcNn
-----END PGP SIGNATURE-----

--------------enig469F8393C0F7320B0B1D06ED--
