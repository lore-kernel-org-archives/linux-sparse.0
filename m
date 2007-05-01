From: Josh Triplett <josh@freedesktop.org>
Subject: sparse -Wptr-subtraction-blows: still needed?
Date: Tue, 01 May 2007 14:08:13 -0700
Message-ID: <4637AC3D.6000008@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB4918FE0C92B6DA879A8A310"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:38549 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423558AbXEAVIQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 17:08:16 -0400
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 1 May 2007 21:08:14 -0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ftp.linux.org.uk>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4918FE0C92B6DA879A8A310
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Sparse has a warning -Wptr-subtraction-blows (off by default) which gener=
ates
a warning for any pointer subtractions.  This warning relates to GCC
shortcomings observed in 2005; the original log message:

> commit 6889bd0f84939675c743229d6fe623513b95e057
> Author: Linus Torvalds <torvalds@ppc970.osdl.org>
> Date:   Fri Jan 7 15:06:24 2005 -0700
>
>     Add option "-Wptr-subtraction-blows" to warn about expensive
>     pointer subtractions.
>    =20
>     Not only does it generate bad code (that can often be rewritten
>     to not do that), it also causes gcc to go into horrible contortions=
,
>     and Al Viro reports that it can make a factor of 2.5 difference in
>     kernel build times to have just a few of these in common header
>     file inline functions.

Does this still apply?  Do current versions of GCC still have this proble=
m?
If not, can the option and warning go away?

- Josh Triplett


--------------enigB4918FE0C92B6DA879A8A310
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGN6w9GJuZRtD+evsRApgfAJwKYQfnnqh8Bfo5nCbHEt8Tkwb2RwCgg+gT
NqaAwXE0PwVwX8XcSe89rF0=
=v0VU
-----END PGP SIGNATURE-----

--------------enigB4918FE0C92B6DA879A8A310--
