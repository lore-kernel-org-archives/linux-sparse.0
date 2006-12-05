From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] cleanup write to argument array hack
Date: Mon, 04 Dec 2006 23:37:37 -0800
Message-ID: <457521C1.4060102@freedesktop.org>
References: <20061130101136.GA27500@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE71F02660D9EE7BBC7ECDBF6"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:42728 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937469AbWLEHhv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Dec 2006 02:37:51 -0500
In-Reply-To: <20061130101136.GA27500@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE71F02660D9EE7BBC7ECDBF6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> The sparse interface is a kind of snaky that it change the input argume=
nt
> array. The function sparse() does the same hack just to skip the files.=

>=20
> This patch add the ptr list for string. So sparse_initialize will
> return list of file to compile. The string pointer is not aligned
> at word boundary. This patch introduce non taged version of the ptr
> list iteration function.

Nice improvement; thanks.

Since tagged lists seem like by far the common case, I'd prefer to see
PTR_ENTRY keep its current name, as you did with add_ptr_list.  Also, you=
r
patch didn't update test-unssa.c.  I've merged your patch, with those two=

additional changes.

I'd also love to see some additional static type checking here, to preven=
t
using the untagged functions on a tagged list or vice versa at compile ti=
me,
rather than allowing mysterious corruption at runtime.

- Josh Triplett


--------------enigE71F02660D9EE7BBC7ECDBF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdSHKGJuZRtD+evsRApIxAKClyLpyf8Z0oHkiniT/cANymbiAtwCgjkSf
4EdU0tmr4e0tDanRyqEZZbE=
=ez8e
-----END PGP SIGNATURE-----

--------------enigE71F02660D9EE7BBC7ECDBF6--
