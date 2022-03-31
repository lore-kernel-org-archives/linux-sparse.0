Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CCAC433F5
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Mar 2022 11:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiCaLDJ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiCaLDI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Mar 2022 07:03:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C068120596E
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 04:01:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nZsYJ-0008D1-9T
        for linux-sparse@vger.kernel.org; Thu, 31 Mar 2022 13:01:19 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-ffcf-bd2e-518f-8dbf.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:ffcf:bd2e:518f:8dbf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C5E7D57B9C
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 11:01:18 +0000 (UTC)
Date:   Thu, 31 Mar 2022 13:01:18 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-sparse@vger.kernel.org
Subject: building Linux for ARMv7 with llvm breaks sparse
Message-ID: <20220331110118.vr4miyyytqlssjoi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfkwcanmbcjothur"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sparse@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


--kfkwcanmbcjothur
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

building a 32bit ARM kernel with llvm (LLVM=3D1 LLVM_IAS=3D1) and C=3D1 bre=
aks
current sparse:

| sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise
| -Wno-return-void -Wno-unknown-attribute -D__ARMEL__ -D__arm__
| --arch=3Darm -mlittle-endian -m32 -Wp,-MMD,scripts/mod/.empty.o.d
| -nostdinc -I/path/to/linux/arch/arm/include
| -I./arch/arm/include/generated
| -I/path/to/linux/include -I./include
| -I/path/to/linux/arch/arm/include/uapi
| -I./arch/arm/include/generated/uapi
| -I/path/to/linux/include/uapi
| -I./include/generated/uapi -include
| /path/to/linux/include/linux/compiler-version.h
| -include /path/to/linux/include/linux/kconfig.h
| -include
| /path/to/linux/include/linux/compiler_types.h
| -D__KERNEL__ -mlittle-endian -Qunused-arguments
| -fmacro-prefix-map=3D/path/to/linux/=3D
| -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes
| -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
| -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int
| -Werror=3Dreturn-type -Wno-format-security -std=3Dgnu11
| --target=3Darm-linux-gnueabi -fintegrated-as
| -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argument
| -fno-dwarf2-cfi-asm -mabi=3Daapcs-linux -mfpu=3Dvfp -funwind-tables
| -meabi gnu -marm -Wa,-W -D__LINUX_ARM_ARCH__=3D6 -march=3Darmv6k
  ^^^^^^^^^^
| -mtune=3Darm1136j-s -msoft-float -Uarm -fno-delete-null-pointer-checks
| -Wno-frame-address -Wno-address-of-packed-member -O2
| -Wframe-larger-than=3D1024 -fstack-protector-strong -Werror -Wno-gnu
| -mno-global-merge -Wno-unused-but-set-variable
| -Wno-unused-const-variable -fomit-frame-pointer
| -fno-stack-clash-protection -Wdeclaration-after-statement -Wvla
| -Wno-pointer-sign -Wcast-function-type -fno-strict-overflow
| -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types
| -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations
| -Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definition
| -Wmissing-include-dirs -Wunused-but-set-variable
| -Wunused-const-variable -Wno-missing-field-initializers
| -Wno-sign-compare -Wno-type-limits -Wno-shift-negative-value -g
| -gdwarf-4 -I /path/to/linux/scripts/mod -I
| ./scripts/mod -DKBUILD_MODFILE=3D'"scripts/mod/empty"'
| -DKBUILD_BASENAME=3D'"empty"' -DKBUILD_MODNAME=3D'"empty"'
| -D__KBUILD_MODNAME=3Dkmod_empty
| /path/to/linux/scripts/mod/empty.c
|=20
| No such file: gnu

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kfkwcanmbcjothur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJFifsACgkQrX5LkNig
012OjggAhlT+6c9r+sU/dl6AwRA8DMn82g/OyItc9PJ4M4tfnzy1AM2xKAf73jsj
idD3BjI2fIG5fbANQjh9jMxTBWuPhV60uAZHcaDZQcRzU5iVA7hM3rcJdQu1gVAQ
z0q7aCVYnC/U3TQo4QrHqs/Iw3Dx8kqI9GP1fIo6P8UMjHRITxl+1Aw48MOYx9dW
fOL9Z+ahan8aez+7x07KDItFCGNmQrYn9IgnWkCnSnNkbR9/GDTtGgodl6eTGVOd
t7VGhRpQBSAeLXzyw6e0W1DTxygJ5ogZ8VrNQBo+5iH3ga9kaniQjx9JQ5zL1blc
IPcS5o/zFTzxGncfaH6Ggq75gRQy8Q==
=xf+B
-----END PGP SIGNATURE-----

--kfkwcanmbcjothur--
