From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Mon, 21 Apr 2008 11:04:38 -0700
Message-ID: <480CD736.601@freedesktop.org>
References: <20080410132519.049821000@sipsolutions.net> <20080410132617.720109000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC5153A41476CB17862798830"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:36740 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbYDUSEY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 14:04:24 -0400
In-Reply-To: <20080410132617.720109000@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5153A41476CB17862798830
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

One comment on your patch description, by the way:

Johannes Berg wrote:
> However, the kernel use of __attribute__((context(...)) is actually
> wrong, the kernel often does things like:
>=20
>     static void *dev_mc_seq_start(struct seq_file *seq, loff_t * pos)
>             __acquires(dev_base_lock)
>     {
>             [...]
>             read_lock(&dev_base_lock);
>             [...]
>     }
>=20
> rather than
>=20
>     static void *dev_mc_seq_start(struct seq_file *seq, loff_t * pos)
>             __acquires(dev_base_lock)
>     {
>             [...]
>             __acquire__(dev_base_lock);
>             read_lock(&dev_base_lock);
>             [...]
>     }

I don't understand why you count this as wrong.  read_lock should
handle acquiring the context itself, either via an __acquires
annotation if written as a function, or via an __acquire__ statement
if written as a macro.  Callers of read_lock shouldn't need to
explicitly call __acquire__.

- Josh Triplett


--------------enigC5153A41476CB17862798830
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIDNc3GJuZRtD+evsRAq6FAJ0UeK//uhA9EEygEj33qPHSDmWVbACfYVQq
WpZ3Cdz9BQd3Tmp2/IZWTDs=
=2fEz
-----END PGP SIGNATURE-----

--------------enigC5153A41476CB17862798830--
