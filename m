From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Antwort: Re: Differences in the behaviour of sparse and gcc within
 cygwin environment
Date: Mon, 21 May 2007 16:16:08 -0700
Message-ID: <46522838.4010407@freedesktop.org>
References: <OF74B9333A.379DA3FD-ONC12572E2.00493908-C12572E2.004946CC@br-automation.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9341BA9B30E416631F2F3C48"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:34731 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913AbXEUXQh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 May 2007 19:16:37 -0400
In-Reply-To: <OF74B9333A.379DA3FD-ONC12572E2.00493908-C12572E2.004946CC@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9341BA9B30E416631F2F3C48
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thomas Schmid wrote:
> I also tried to pre-process that code with cpp - but then I lose the=20
> position-data of the declarations i try to get info from.
> It's not possible to use cpp integrated in sparse, isn't it?

In theory, we could add support for the line-number information provided =
by
the GCC preprocessor.  That seems useful, though it can't provide as much=

information as Sparse's usual line-and-character information.

- Josh Triplett



--------------enig9341BA9B30E416631F2F3C48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGUig4GJuZRtD+evsRAqsRAJ9r4By91rWeaPA5YFKqexWlqeBe1ACfUDGp
np/7rVspQNnO/MhEVVEp3As=
=O4Y4
-----END PGP SIGNATURE-----

--------------enig9341BA9B30E416631F2F3C48--
