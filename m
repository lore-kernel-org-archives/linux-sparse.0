From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/4] Compile sparse executable under it's own name, not
 as "check"
Date: Mon, 06 Nov 2006 10:50:00 -0800
Message-ID: <454F83D8.9030204@freedesktop.org>
References: <20061103221659.7811.73832.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7881ED88C2CE8722D95B4121"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:10669 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1752267AbWKFSuD (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Nov 2006 13:50:03 -0500
In-Reply-To: <20061103221659.7811.73832.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7881ED88C2CE8722D95B4121
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I've applied this series of four patches; thanks.

Your "typo fixes" patch also reminded me that I needed to fix the typo in=
 the
name of "validation/bad-assignement.c", which I have now done.

Regarding your comment about using "make check" for something more useful=
, I
would greatly welcome a patch which actually checked sparse against all t=
he
files in validation/ and tested what those files intended to test.  As fa=
r as
I can tell, it looks like some of them may not work as intended right now=
; for
example, it looks like validation/builtin_safe1.c expects
__attribute__((pure)) and __attribute__((const)) to work and mark a funct=
ion
as side-effect-free, which doesn't currently happen in sparse.

- Josh Triplett



--------------enig7881ED88C2CE8722D95B4121
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFT4PYGJuZRtD+evsRAtdlAJ9+d8GrP0qDZZRzanc6sROK49rMJgCdG9iH
nwXtFsiyg6dvynVEjLPOZMQ=
=F9vm
-----END PGP SIGNATURE-----

--------------enig7881ED88C2CE8722D95B4121--
