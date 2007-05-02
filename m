From: Josh Triplett <josh@freedesktop.org>
Subject: Sparse 0.3 version number
Date: Tue, 01 May 2007 19:33:08 -0700
Message-ID: <4637F864.7090601@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig98166A780C043F79DDC635DB"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:58374 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbXEBCdL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 22:33:11 -0400
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail5.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 2 May 2007 02:33:09 -0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98166A780C043F79DDC635DB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

So, the 0.3 release went out...with VERSION=3D0.2 in the Makefile.  Oops.=


Fortunately, $(VERSION) currently only affects the version number in the
pkg-config file sparse.pc.  If you have written some software that depend=
s on
Sparse, uses pkg-config to check for it with a sufficient version number,=
 and
hoped to depend on 0.3 or newer, my apologies.  Fortunately, I suspect fe=
w to
no people have done this.

I plan to put out a release shortly with a fix for this, as well as a cou=
ple
of additional opportunistic fixes.  I also plan to include a "make dist" =
with
some checks to prevent this from happening again.

- Josh Triplett


--------------enig98166A780C043F79DDC635DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGN/hkGJuZRtD+evsRAoPHAJ45ZaUxRYhedOeD4h0shwYTgcUD4QCbBt/2
wBLyCdThJdEE9uB55/mAb/M=
=md39
-----END PGP SIGNATURE-----

--------------enig98166A780C043F79DDC635DB--
