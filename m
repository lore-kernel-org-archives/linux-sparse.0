Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EF8C433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 23 May 2022 09:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiEWJRO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 23 May 2022 05:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiEWJRO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 23 May 2022 05:17:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38AE1C915
        for <linux-sparse@vger.kernel.org>; Mon, 23 May 2022 02:17:12 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nt4Ba-0004wd-8I; Mon, 23 May 2022 11:17:10 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 16378841AB;
        Mon, 23 May 2022 09:17:09 +0000 (UTC)
Date:   Mon, 23 May 2022 11:17:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Luc Van Oostenryck <lucvoo@kernel.org>
Cc:     linux-sparse@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] handle clang's option "-meabi gnu"
Message-ID: <20220523091708.z4cql7i72altyemn@pengutronix.de>
References: <CAHk-=wit1MGUeFOycVt_qrk8TKBAAHf-9=ekqC=t0snMNpo29g@mail.gmail.com>
 <20220522090824.11678-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4oeb3pmx5iblimmd"
Content-Disposition: inline
In-Reply-To: <20220522090824.11678-1-lucvoo@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sparse@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


--4oeb3pmx5iblimmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.05.2022 11:08:24, Luc Van Oostenryck wrote:
> From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>=20
> Clang has an option "-meabi <arg>" which is used by the kernel for ARMv7.
> This kind of option, taking a argument without a separating '=3D', can't
> be ignored like most other options and must this be special-cased.
>=20
> So, add the special case for this option and consume the argument if it's
> one of the valid one.
>=20
> Link: https://lore.kernel.org/r/20220331110118.vr4miyyytqlssjoi@pengutron=
ix.de
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4oeb3pmx5iblimmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKLUREACgkQrX5LkNig
012YCggAtvCdWMv4H9wj9VJskEUeZpqrwzH/db1PSN2a6BD8A8ga3+iOeqC31oN9
3TYeMsog8oizUX58efbtVFTPB8Bgh8PtcDpOJvOw1HG8tAiR3VDYUdmtNBgZ4bqF
GtxMx8jkbD0iHbozK9E3J/lesZhvxb/0GPCLYLAJ94zAjRtz2cQj3hsJqk7/P97F
zRK6sihCsuLDjruycsuXPcgNg8hfJTiF6CklpiynvecXbR8y6Po6s9a6RIqQx8gf
kWzLzG75gNYZPr+ff/amwspDgOwZE1pnu/yj1Xc4UvSTw4aCitBnC7rz+TwbGt+r
ElCC689epG5/2YGRzwodCyxvoaO1NQ==
=ishz
-----END PGP SIGNATURE-----

--4oeb3pmx5iblimmd--
