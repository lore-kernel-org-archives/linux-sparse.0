From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/6] Bitfield without explicit sign should be a warning,
 not an error
Date: Wed, 27 Jun 2007 23:09:51 -0700
Message-ID: <468350AF.2050704@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFC90D229BFC50530B5117638"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:55639 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbXF1GJx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:09:53 -0400
In-Reply-To: <20070628053954.30704.66440.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC90D229BFC50530B5117638
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pavel Roskin wrote:
> The -Wdefault-bitfield-sign is supposed to control a warning, just like=

> other -W options.

I've applied this patch; thanks!

- Josh Triplett


--------------enigFC90D229BFC50530B5117638
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg1CvGJuZRtD+evsRAir4AJ45ceINlIUIZ4W0GSa0wmH0BGhiDwCfTvgh
CutYCyO4gQzoQ2ZooBDfric=
=uFiz
-----END PGP SIGNATURE-----

--------------enigFC90D229BFC50530B5117638--
