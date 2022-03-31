Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1175FC433EF
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Mar 2022 19:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbiCaTdb (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiCaTdb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Mar 2022 15:33:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC67A1E530F
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:31:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1na0WC-0001Sv-Au; Thu, 31 Mar 2022 21:31:40 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-551a-5bdf-8277-1453.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:551a:5bdf:8277:1453])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B0D8F5802A;
        Thu, 31 Mar 2022 19:31:39 +0000 (UTC)
Date:   Thu, 31 Mar 2022 21:31:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: building Linux for ARMv7 with llvm breaks sparse
Message-ID: <20220331193139.x3mqngrci3tc6sqo@pengutronix.de>
References: <20220331110118.vr4miyyytqlssjoi@pengutronix.de>
 <CAHk-=wjeC-x28rn50T1oLXayZUm_xYhmRV+N8ewAXjJVZnyUAg@mail.gmail.com>
 <CAHk-=wjeYjkXDpdHwobJ1X+Tk+N8xYPe_O6CbB3zg=fKRVhYJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6pd4e4esxc6plzl3"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjeYjkXDpdHwobJ1X+Tk+N8xYPe_O6CbB3zg=fKRVhYJg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sparse@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


--6pd4e4esxc6plzl3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.03.2022 12:22:08, Linus Torvalds wrote:
> On Thu, Mar 31, 2022 at 12:17 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Does it all work if we just make the kernel use the normal
> >
> >   -meabi=3Dgnu
> >
> > syntax instead?
>=20
> IOW, just something like this
>=20
>     --- a/arch/arm/Makefile
>     +++ b/arch/arm/Makefile
>     @@ -110,7 +110,7 @@ CFLAGS_ABI      +=3D-funwind-tables
>      endif
>=20
>      ifeq ($(CONFIG_CC_IS_CLANG),y)
>     -CFLAGS_ABI +=3D -meabi gnu
>     +CFLAGS_ABI +=3D -meabi=3Dgnu
>      endif
>=20
>      ifeq ($(CONFIG_CURRENT_POINTER_IN_TPIDRURO),y)
>=20
> that's basically what we do for all the other '-mxyz=3Dabc' cases, so
> it's really that use of -meabi that stands out as being the odd man
> out.

No :/

| clang: error: unknown argument '-meabi=3Dgnu'; did you mean '-mabi=3Dgnu'?

The documentation says no "=3D":

| https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clan=
g-meabi

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6pd4e4esxc6plzl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJGAZcACgkQrX5LkNig
012e8Qf/dxD+Hqv0cEYojuy5sbIhtjrb+FDtrZE1TjNoNdzoj3wHbzRZfofsLJ0q
y1Qqi+DHhxDi5DB2+krSnoFelnRLEf1Hf3aep9h3vYHDMh+PdyGcPOOXlDJGKREn
NZu2iwiMbUOBCP0ShtUvJr0E6GBTdttphBXYKtAHTFN/fzJrgQdULSGBx2yOgG5O
bB2oh3feoin3OY9bPQ6fx92IlZfTxszmWOrh6ea7gVfxM5p+mEFSiUxMBX4Z29IV
ziSpyW7PRXv49vdOH68gPWDDNNvZktAn8rc/PtRoPhGYaYKXARJ7fXtNhWe3FGf5
WY2nlXm+bkb9ZGbwyy3ggNPYlVWbLw==
=edMV
-----END PGP SIGNATURE-----

--6pd4e4esxc6plzl3--
