From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 3] Fix core dump on huge switch
Date: Mon, 26 Feb 2007 11:57:28 -0800
Message-ID: <45E33BA8.80904@freedesktop.org>
References: <20070210001647.GB20644@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD5393556A3D2DB900A30FCCD"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:55904 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030506AbXBZT5b (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Feb 2007 14:57:31 -0500
In-Reply-To: <20070210001647.GB20644@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD5393556A3D2DB900A30FCCD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Bump up the size of the instruction buffer. vt_ioctl.c has
> a huge switch statement causing sparse over flow the instruction
> buffer.
>=20
> Signed-Off-By: Christopher Li <sparse@chrisli.org>

I've applied this fix for now, to solve the immediate problem; thanks for=
 the patch. =20

Ideally I'd like to see some solution that grows the buffer as needed.

I also committed one minor style fix after your patch:

> +	if (buf >=3D buffer + sizeof buffer)

Please use parentheses with sizeof, per the Linux Documentation/CodingSty=
le.

- Josh Triplett


--------------enigD5393556A3D2DB900A30FCCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4zuoGJuZRtD+evsRAq6jAKCbKMgX7KvDyGA+dXiwSKyXkQ80OwCeML2A
qXauG5qPKqeiMvvmnzD5CwM=
=a7KW
-----END PGP SIGNATURE-----

--------------enigD5393556A3D2DB900A30FCCD--
