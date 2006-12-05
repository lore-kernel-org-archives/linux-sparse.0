From: Josh Triplett <josh@freedesktop.org>
Subject: Re: sparse as a compiler front-end
Date: Tue, 05 Dec 2006 08:53:04 -0800
Message-ID: <4575A3F0.2090502@freedesktop.org>
References: <45564680.8090806@garzik.org> <455679B0.8030106@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF84D02FFBA7A9AF9C9AC9761"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:48651 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968451AbWLEQxK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Dec 2006 11:53:10 -0500
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.121]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 5 Dec 2006 16:53:09 -0000
In-Reply-To: <455679B0.8030106@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Matt Domsch <Matt_Domsch@dell.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF84D02FFBA7A9AF9C9AC9761
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Josh Triplett wrote:
> Jeff Garzik wrote:
>> Can libsparse.a and necessary includes be packaged as well?
>=20
> Sure, assuming you don't mind coding against something potentially flui=
d.  The
> next release will install the library and headers.  (At the moment, "ne=
cessary
> headers" seems to mean "all of them".)

The Sparse 0.2 release installs the library and headers, as well as a
pkg-config file.

- Josh Triplett


--------------enigF84D02FFBA7A9AF9C9AC9761
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdaPwGJuZRtD+evsRAvW6AJ0TVTtMEEW8yD3AanEX/nfuOqwzHQCfUh4c
W0RJwfb2iNj3Vfd/yimCrzs=
=T4H2
-----END PGP SIGNATURE-----

--------------enigF84D02FFBA7A9AF9C9AC9761--
