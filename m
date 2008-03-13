From: Josh Triplett <josh@freedesktop.org>
Subject: Re:
Date: Thu, 13 Mar 2008 12:09:10 -0700
Message-ID: <47D97BD6.8050408@freedesktop.org>
References: <1205424338.47d950d2e7165@webmail.mrt.ac.lk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0780C83A8CC2B1E49319918A"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:57493 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757209AbYCMTPx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Mar 2008 15:15:53 -0400
In-Reply-To: <1205424338.47d950d2e7165@webmail.mrt.ac.lk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: rajika@cse.mrt.ac.lk
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0780C83A8CC2B1E49319918A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

rajika@cse.mrt.ac.lk wrote:
> Is there is any guide which describe how to use sparse to parse a C sou=
rce file.
> I went through README, FAQ and searched the archived but unable to find=
 any
> guide which describe how to use this. I found some information in the R=
EADME
> file, is that the only information available?

You might also look at the manpages for sparse and cgcc.  If you just
want to run the sparse static analysis tool on your source code, those
manpages should tell you everything you need to know.  If you want to
use Sparse to parse C source code for some other purpose, then either
try c2xml or write some code linking to libsparse; documentation on
both of those alternatives still needs writing, but you can find
examples in the Sparse source code.

- Josh Triplett


--------------enig0780C83A8CC2B1E49319918A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH2XvXGJuZRtD+evsRAgSjAJ4+XihjfmXWe2HFYmIoCWvrtHqK2QCggjK4
WYdQlE9VxwdotlbRAftGFIU=
=GAKb
-----END PGP SIGNATURE-----

--------------enig0780C83A8CC2B1E49319918A--
