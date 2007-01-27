From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Fix mistaken comparison that becomes a no-op.
Date: Sat, 27 Jan 2007 01:39:50 -0800
Message-ID: <45BB1DE6.5060706@freedesktop.org>
References: <20061218204435.GA8251@jameswestby.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAEAD2C143C0C43ABB41AEFAE"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:33445 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbXA0Jjx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Jan 2007 04:39:53 -0500
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.121]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 27 Jan 2007 09:39:52 -0000
In-Reply-To: <20061218204435.GA8251@jameswestby.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEAD2C143C0C43ABB41AEFAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

James Westby wrote:
> Fix a mistake in same_cast_type where the second test became a no-op as=
 it
> compared a value to itself, rather than to the second operand.

Applied; good catch!

- Josh Triplett



--------------enigAEAD2C143C0C43ABB41AEFAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFux3mGJuZRtD+evsRAuC6AKCktte4aaX2lmxfOD1YFrLQLcaxygCfUB+3
LDOId98F5lCTIafiks/tWMg=
=T2xE
-----END PGP SIGNATURE-----

--------------enigAEAD2C143C0C43ABB41AEFAE--
