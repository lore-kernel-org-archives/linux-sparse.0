From: Josh Triplett <josh@freedesktop.org>
Subject: Re: sparse breakage triggered by rcu_read_lock() lockdep annotations
Date: Thu, 18 Oct 2007 10:41:15 -0700
Message-ID: <47179ABB.9060104@freedesktop.org>
References: <20071016105521.GB6352@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig591FEE2E43CC1C54566C6E09"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:48970 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757775AbXJRRlZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Oct 2007 13:41:25 -0400
In-Reply-To: <20071016105521.GB6352@localhost.sw.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@sw.ru>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig591FEE2E43CC1C54566C6E09
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alexey Dobriyan wrote:
> FWIW, commit 851a67b825540a8e00c0be3ee25e4627ba8b133b
> aka "lockdep: annotate rcu_read_{,un}lock{,_bh}"
> causes sparse to trigger internal assertion in quite a few places over
> allyesconfig run.
>=20
> 	sparse: flow.c:805: rewrite_parent_branch: Assertion `changed' failed.=

>=20
> Trimmed down testcase:
>=20
> 	void f(unsigned long ip);
> 	static void g(void)
> 	{
> 	        if (1) {
> 	              f(({ __label__ x; x: (unsigned long)&&x; }));
> 	        }
> 	        f(({ __label__ x; x: (unsigned long)&&x; }));
> 	}
>=20
> #0  0x4001c410 in __kernel_vsyscall ()
> (gdb) bt
> #0  0x4001c410 in __kernel_vsyscall ()
> #1  0x40050701 in raise () from /lib/libc.so.6
> #2  0x40051e38 in abort () from /lib/libc.so.6
> #3  0x40049fcc in __assert_fail () from /lib/libc.so.6
> #4  0x08064947 in pack_basic_blocks (ep=3D0x411a1c6c) at flow.c:812
> #5  0x0805ffbf in linearize_symbol (sym=3D0x4103ec8c) at linearize.c:21=
54
> #6  0x080492a3 in main (argc=3DCannot access memory at address 0x274d) =
at sparse.c:266

Thanks for the detailed report.  Looking into it now.

- Josh Triplett



--------------enig591FEE2E43CC1C54566C6E09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHF5q7GJuZRtD+evsRAi+yAJwOuuybjXRRSIVtdhymlpK2YzTCaACfTeAv
o3T4QqwbeCF614dLCYgJIig=
=OlIi
-----END PGP SIGNATURE-----

--------------enig591FEE2E43CC1C54566C6E09--
