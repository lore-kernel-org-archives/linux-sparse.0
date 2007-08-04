From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [patch] improve flag handling
Date: Sat, 04 Aug 2007 13:50:45 -0700
Message-ID: <46B4E6A5.4080706@freedesktop.org>
References: <8bd0f97a0708032202r2615f659v514667337c809d05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig34404BCDFF09EB127344C3F5"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:60675 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759946AbXHDUuy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 4 Aug 2007 16:50:54 -0400
In-Reply-To: <8bd0f97a0708032202r2615f659v514667337c809d05@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34404BCDFF09EB127344C3F5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Mike Frysinger wrote:
> the attached patch tweaks the makefile so that it respects CFLAGS set
> in the environment and it makes sure to link the shared libsparse with
> $(LDFLAGS)
> -mike

Applied, thanks!

- Josh Triplett


--------------enig34404BCDFF09EB127344C3F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGtOalGJuZRtD+evsRAp/ZAKCrX6YZswmZSgsKwxEZvers2in0OwCfcvFU
CBHYpj1b/cpP9zfE5E7E1U0=
=bDkg
-----END PGP SIGNATURE-----

--------------enig34404BCDFF09EB127344C3F5--
