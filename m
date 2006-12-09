From: Josh Triplett <josh@freedesktop.org>
Subject: Re: sparse as a compiler front-end
Date: Sat, 09 Dec 2006 01:43:43 -0800
Message-ID: <457A854F.5010602@freedesktop.org>
References: <45564680.8090806@garzik.org> <455679B0.8030106@freedesktop.org> <4575A3F0.2090502@freedesktop.org> <20061208193418.GA17790@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE19A31C1E7046D4780C8E8BA"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:59054 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936642AbWLIJnp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Dec 2006 04:43:45 -0500
In-Reply-To: <20061208193418.GA17790@lists.us.dell.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE19A31C1E7046D4780C8E8BA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Matt Domsch wrote:
> On Tue, Dec 05, 2006 at 08:53:04AM -0800, Josh Triplett wrote:
>> Josh Triplett wrote:
>>> Jeff Garzik wrote:
>>>> Can libsparse.a and necessary includes be packaged as well?
>>> Sure, assuming you don't mind coding against something potentially fl=
uid.  The
>>> next release will install the library and headers.  (At the moment, "=
necessary
>>> headers" seems to mean "all of them".)
>> The Sparse 0.2 release installs the library and headers, as well as a
>> pkg-config file.
>=20
> I've got a test build of sparse-0.2 posted at
> http://domsch.com/linux/fedora/extras/sparse/0.2/ which I intend to
> put into Fedora Extras for FC5,6,devel.  This puts the libsparse.a and
> headers into a -devel package.

=46rom the spec file, I notice that you install the pkg-config file to
/usr/lib/pkgconfig (or equivalent), rather than /usr/share/pkgconfig (or
equivalent) as the Makefile does; any particular reason for that?

- Josh Triplett


--------------enigE19A31C1E7046D4780C8E8BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeoVPGJuZRtD+evsRAvwXAJ9DO0UA9krzxraoa6XqMF8ySJ1KPwCffUzo
2IGAFEQr0bMHFFxRRH4xI10=
=6XgF
-----END PGP SIGNATURE-----

--------------enigE19A31C1E7046D4780C8E8BA--
