From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 01/36] build: make PREFIX overwritable from the
 environment
Date: Sun, 5 Nov 2017 19:54:52 +0100
Message-ID: <df71c48a-f4d4-7654-a15e-3e46c77197c9@kleine-koenig.org>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-1-luc.vanoostenryck@gmail.com>
 <20171105174408.33uctnzyt53ig2uv@s>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7IsdI2hI2JX6iIQtBKPVJKWsSFMbeoi0k"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:60416 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKESzS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 13:55:18 -0500
In-Reply-To: <20171105174408.33uctnzyt53ig2uv@s>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7IsdI2hI2JX6iIQtBKPVJKWsSFMbeoi0k
Content-Type: multipart/mixed; boundary="MLOhBf5R6QFt7Ep4duOCtBACiAf88gtGS";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Josh Triplett <josh@joshtriplett.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org
Message-ID: <df71c48a-f4d4-7654-a15e-3e46c77197c9@kleine-koenig.org>
Subject: Re: [PATCH 01/36] build: make PREFIX overwritable from the
 environment
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-1-luc.vanoostenryck@gmail.com>
 <20171105174408.33uctnzyt53ig2uv@s>
In-Reply-To: <20171105174408.33uctnzyt53ig2uv@s>

--MLOhBf5R6QFt7Ep4duOCtBACiAf88gtGS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Josh,

On 11/05/2017 06:44 PM, Josh Triplett wrote:
> On Sun, Nov 05, 2017 at 05:25:09PM +0100, Luc Van Oostenryck wrote:
>> From: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
>>
>> This way I can just use
>>
>> 	env PREFIX=3D/usr make install
>>
>> on the command line to install sparse into the system.
>=20
> You can already use "make PREFIX=3D/usr install" to do this, which seem=
s
> far more conventional, and seems less error-prone (e.g. it won't pick u=
p
> something random from the environment, only something intentionally put=

> on the command line).

Having PREFIX in the build environment and then being surprised that
it's picked up by a build isn't something I'd show consideration for.

> Any particular reason to do this?

I had this patch in my stack for the sparse debian package because
with debhelper it is easier to put something into the environment than
to overwrite the make command line. (But having said that, the currently
used packaging doesn't rely on this feature any more.)

Best regards
Uwe


--MLOhBf5R6QFt7Ep4duOCtBACiAf88gtGS--

--7IsdI2hI2JX6iIQtBKPVJKWsSFMbeoi0k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAln/Xo8ACgkQwfwUeK3K
7AnG6gf+Kysy2JlhmiRvgwvZd2T/gNSqongpsPSDSKGhHQLpYIOXepz5s9ok6KZn
VnVB7eW7HdcMQfX+EXrUaNiRRkykoX8v5ZX+2sQMDJzosARQL2jg3wLzuJj0uCIu
5EoWoIZlkMbmcSVC0M0z2Wgj7izbVWmNta6rIgHFuCAI/uxINbBWsmfop9NPb3up
ybFk0KOFI+VrCuQZkUV7nFpDKII8uI4jkDXAKYrnqKST5OPXTjN4+XpSAh8C6S/t
0wkOQ9SiJAWx5Swt8rFeD0x/+b61olKjdsPRBgqIXktsiSNJV9ANzW8D1N5wuNBP
aS5d2EgZ8ruAhRiUvJ/mKGZaIBp1WA==
=05zI
-----END PGP SIGNATURE-----

--7IsdI2hI2JX6iIQtBKPVJKWsSFMbeoi0k--
