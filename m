From: Josh Triplett <josh@freedesktop.org>
Subject: Re: constness bug in include/linux/compiler.h
Date: Fri, 16 Mar 2007 11:26:50 -0700
Message-ID: <45FAE16A.3080601@freedesktop.org>
References: <ee9e417a0703131523x2cc701f7l7938624175bf1fe0@mail.gmail.com>	 <45F8206E.8030706@freedesktop.org> <ee9e417a0703141210n7d8e8834j56c17b69ce68ff2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig91FF6F694D65C2B42BDD0508"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:38363 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965822AbXCPS1W (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 16 Mar 2007 14:27:22 -0400
In-Reply-To: <ee9e417a0703141210n7d8e8834j56c17b69ce68ff2c@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Russ Cox <rsc@swtch.com>
Cc: linux-sparse@vger.kernel.org, Tom Bergan <tbergan@ucla.edu>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91FF6F694D65C2B42BDD0508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Russ Cox wrote:
>> Yes, that makes sense.  These functions just check for the annotation =
on their
>> pointer argument, and having the const annotation would allow them to =
check
>> const pointers without provoking a warning due to the lack of const.
>=20
> They don't provoke a warning now.  Sparse is silent on this program:
>=20
> 	#define __user __attribute__((noderef, address_space(1)))
>=20
> 	extern void __chk_user_ptr(void __user *);
>=20
> 	void
> 	f(const void __user *p)
> 	{
> 		__chk_user_ptr(p);
> 	}

Hmmm, odd.  After a few iterations, I managed to discover that Sparse wil=
l
warn if you attempt to convert a const int * to an int *, but not if you
attempt to convert a const void * to a void *.  This seems like a bug to =
me.

> but arguably they should (and then be changed to const void __user*).

Yes.  Please do go ahead and propose the obvious const-adding patch to
include/linux/compiler.h, Cc linux-sparse, and feel free to add a
Signed-off-by from me.

- Josh Triplett


--------------enig91FF6F694D65C2B42BDD0508
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF+uF3GJuZRtD+evsRAkEGAKCb1GSNWKLpWownOu7a3vkScBDANgCfZalP
M11T7OopEht1qIX6THyHWag=
=cYTC
-----END PGP SIGNATURE-----

--------------enig91FF6F694D65C2B42BDD0508--
