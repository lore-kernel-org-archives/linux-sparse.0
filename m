From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 28/36] build: use a dot file name instead of local.mk:
 .sparse.mk
Date: Mon, 6 Nov 2017 09:57:23 +0100
Message-ID: <57a86c63-05ff-fcfc-41c0-e0a7b1ccc0cf@kleine-koenig.org>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-28-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xXfsDP65Bb38K25ig491IAsT55CnELkrI"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:60836 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdKFI53 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 03:57:29 -0500
In-Reply-To: <20171105162544.72960-28-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xXfsDP65Bb38K25ig491IAsT55CnELkrI
Content-Type: multipart/mixed; boundary="BOkHepW3iWL2nN0cQ3jHuRNKBFGhWRdQK";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-sparse@vger.kernel.org
Message-ID: <57a86c63-05ff-fcfc-41c0-e0a7b1ccc0cf@kleine-koenig.org>
Subject: Re: [PATCH 28/36] build: use a dot file name instead of local.mk:
 .sparse.mk
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-28-luc.vanoostenryck@gmail.com>
In-Reply-To: <20171105162544.72960-28-luc.vanoostenryck@gmail.com>

--BOkHepW3iWL2nN0cQ3jHuRNKBFGhWRdQK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Luc,

> -local.mk
> +.sparse.mk

what is the motivation to hide this file? IMHO it is better to be aware
of eventual changes to the build system and so don't hide the file.

Having said that I question if it is a good idea at all to provide a way
to change the build without dirtying the working copy.

Best regards
Uwe


--BOkHepW3iWL2nN0cQ3jHuRNKBFGhWRdQK--

--xXfsDP65Bb38K25ig491IAsT55CnELkrI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAloAI/MACgkQwfwUeK3K
7AmuLgf/QicArcK3QcEj/A+AMpd6BvJJUFq19h+4XZ/Vdy/ANwwnOwCX9aksH+oR
Up68mm9U3siYQHfj+oi+H8R+RjADgWxQ99fP5Y7gPs6zaWqQ63KGYeW7Uwal1zzX
Ihdkq2bNQYrnfrVcI7xodfq/HGF1tsXmNYI6RIEDFeeO61ti2TSIrdPRnuAL2SzL
E9P6XHjd9hVgthElUSUQJNr0LKu+hE3vGbI+TktVbqWgJkLEOKX27LPq3URUW0k0
RJ6X9V0X2lAZ5f4t08tX+xIxHR4OTUQTjx9+UCi7zFVmMvj6Nuj4evA7sQM0LgJg
yPsDAXdhgs0B5AZxU2bF4ikfjs6K/Q==
=RmmR
-----END PGP SIGNATURE-----

--xXfsDP65Bb38K25ig491IAsT55CnELkrI--
