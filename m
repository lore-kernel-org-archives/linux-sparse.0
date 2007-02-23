From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Re: Sparse just seg faulted on me!
Date: Thu, 22 Feb 2007 18:42:46 -0800
Message-ID: <45DE54A6.7090109@freedesktop.org>
References: <9C17AC42-0C51-44D9-B126-1FB781DE0ECA@cam.ac.uk> <20070214172905.GA17959@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC99EB487981CAE8023E816E1"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [69.17.117.10] ([69.17.117.10]:42114 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750703AbXBWCni (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Feb 2007 21:43:38 -0500
In-Reply-To: <20070214172905.GA17959@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC99EB487981CAE8023E816E1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
>> fs/ntfs/sysctl.c:38:15: error: undefined identifier 'CTL_UNNUMBRED'
> Sparse left empty ctype when error happen. Sparse should skip
> the expand_symbol() at all if error happen.=20
>=20
> Please try this patch:
>=20
> Fix the segfault when initializer has unknown symbol

Applied.

- Josh Triplett



--------------enigC99EB487981CAE8023E816E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3lSmGJuZRtD+evsRAiBYAJ0Yn2SSC5nfKcollEgZf/PhVetSJgCgl+Uc
GBBL+lkENAZSgiThmMEXY64=
=/B4e
-----END PGP SIGNATURE-----

--------------enigC99EB487981CAE8023E816E1--
