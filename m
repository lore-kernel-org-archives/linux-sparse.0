From: Josh Triplett <josh@freedesktop.org>
Subject: Re: sparse as a compiler front-end
Date: Tue, 27 Feb 2007 17:36:14 -0800
Message-ID: <45E4DC8E.9000702@freedesktop.org>
References: <45564680.8090806@garzik.org> <455679B0.8030106@freedesktop.org> <4575A3F0.2090502@freedesktop.org> <20061208193418.GA17790@lists.us.dell.com> <457A854F.5010602@freedesktop.org> <457A8CD4.8020008@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5025F87992AD378E87B74933"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:47458 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbXB1BgQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Feb 2007 20:36:16 -0500
In-Reply-To: <457A8CD4.8020008@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5025F87992AD378E87B74933
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Josh Triplett wrote:
>> From the spec file, I notice that you install the pkg-config file to
>> /usr/lib/pkgconfig (or equivalent), rather than /usr/share/pkgconfig (=
or
>> equivalent) as the Makefile does; any particular reason for that?
>=20
> The pkgconfig file describes an architecture-specific library, so it=20
> goes into /usr/lib/pkgconfig/$pkg.pc if its 32-bit (or the rare 64-bit =

> arch that uses /usr/lib), and it goes into /usr/lib64/pkgconfig/$pkg.pc=
=20
> if the library is 64-bit.
>=20
> /usr/share is not appropriate for architecture-specific data.

Latest sparse from Git now installs sparse.pc to $(LIBDIR)/pkgconfig (def=
ault
/usr/lib/pkgconfig).

Thanks,
Josh Triplett


--------------enig5025F87992AD378E87B74933
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5NyOGJuZRtD+evsRAhu2AKCAxMawUbXX9m5+ZHQx36Wd/QGErwCeIbdl
GeQGubZBYam9iOY8xD/rucQ=
=jTT+
-----END PGP SIGNATURE-----

--------------enig5025F87992AD378E87B74933--
