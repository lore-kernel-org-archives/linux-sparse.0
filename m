From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Re: sparse breakage triggered by rcu_read_lock() lockdep
 annotations
Date: Sat, 20 Oct 2007 20:34:04 -0700
Message-ID: <471AC8AC.7020701@freedesktop.org>
References: <20071016105521.GB6352@localhost.sw.ru>	 <70318cbf0710191244v59bed9fekbef0ae1fcda22a6a@mail.gmail.com> <70318cbf0710191408mfb372bah292028f7bafb6eec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE744594351A95E063B70FA5E"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:52055 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbXJUDe3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 20 Oct 2007 23:34:29 -0400
In-Reply-To: <70318cbf0710191408mfb372bah292028f7bafb6eec@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Alexey Dobriyan <adobriyan@sw.ru>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE744594351A95E063B70FA5E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> OK, I get a trivial fix after all. The test case is fixed now.
> I haven't done much test otherwise.
>=20
> See the patch attached.

Nice work Chris!  Patch applied and pushed out.

I may roll an 0.4.1 release in the near future to fix kernel
builds with Sparse.

- Josh Triplett



--------------enigE744594351A95E063B70FA5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHGsisGJuZRtD+evsRAvRoAJ4pMW/OVO7I2SoWCSIlW11pNx5FqACgjG3m
FdZN8gvX5eRftrcuMsjnTgk=
=a/D+
-----END PGP SIGNATURE-----

--------------enigE744594351A95E063B70FA5E--
