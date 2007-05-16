From: Josh Triplett <josh@freedesktop.org>
Subject: Test that causes sparse to hang
Date: Wed, 16 May 2007 00:11:28 -0700
Message-ID: <464AAEA0.9020300@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1DBED4F3C83FB6F70FB34BC8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:37085 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028AbXEPHLh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 May 2007 03:11:37 -0400
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 16 May 2007 07:11:36 -0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DBED4F3C83FB6F70FB34BC8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

While poking at the GCC testsuite, I found a source file that hangs Spars=
e.  I
cut it down to the following minimal test case:

#if L'\x1234' !=3D 0x1234
#endif
#if ''
#endif

Documenting this on-list in case someone wants to look at it before I can=
 get
to it later.

- Josh Triplett


--------------enig1DBED4F3C83FB6F70FB34BC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGSq6gGJuZRtD+evsRAugOAKCTDgj0xJKs0AzL2QWxApQ2/bKWPACfZULt
9ETaR898ry+vq8EZvBmkAAM=
=sM0x
-----END PGP SIGNATURE-----

--------------enig1DBED4F3C83FB6F70FB34BC8--
