From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Wed, 6 Oct 2010 12:32:50 -0400
Message-ID: <201010061232.51680.vapier@gentoo.org>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org> <201010060138.04508.vapier@gentoo.org> <20101006071018.GB2320@feather>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15521153.fnhVaFgWou";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:42117 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759371Ab0JFQeO (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Oct 2010 12:34:14 -0400
In-Reply-To: <20101006071018.GB2320@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, michael.hennerich@analog.com

--nextPart15521153.fnhVaFgWou
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 06, 2010 03:10:19 Josh Triplett wrote:
> On Wed, Oct 06, 2010 at 01:38:02AM -0400, Mike Frysinger wrote:
> > On Tuesday, October 05, 2010 22:33:21 Christopher Li wrote:
> > > Can we have some "ifdef" for the blackfin architecture in the pre
> > > buffer? I agree with Josh, that do look like very much blackfin
> > > specific. We can leave the ignore attribute alone for now.
> >=20
> > how would #ifdefs help ?  i'm not building sparse for a Blackfin arch,
> > host or target wise.  if there's something more, you'd have to be
> > specific as to what you mean, otherwise i wont be able to send an
> > updated patch.
>=20
> I suspect that Chris meant that you could add_pre_buffer an #ifdef and
> #endif surrounding the #define, so that the #define would only take
> effect if Sparse (or the command-line options passed by cgcc or Linux)
> defined some appropriate architecture-specific symbol for Blackfin.

i guess sparse doesnt automatically propogate defines that gcc uses, so i'd=
=20
have to add "-D__bfin__" to CHECKFLAGS in arch/blackfin/Makefile.  but that=
 is=20
what people are expecting, right ?
=2Dmike

--nextPart15521153.fnhVaFgWou
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMrKSzAAoJEEFjO5/oN/WBcsMP/2gzeBieiKZlGayW3DxBuIp8
kDRR4rnWAoUnBVOeMvH2HAQknbFxX3e/aj9IWmPzZVZgZkGGHM4swQfRjoftGl7q
ZUMD8QlXBWm063eYJ9dSkxgrVOTxVaEftwuQttyM6uZ8BwCAPoh5lYhySl+ZTkHY
T7MDJUqHmn3QMZ54MXmC+lAFt6S5zCY0GD/1SCTdlnKULIV4qJ+sgm01m09Nc1bc
lLxcSi6ALll2ORhvXY7dXjCfVgC1KeuYoRxfJ4jgiApJQmJSzFUA/Cr+Js1bHkoC
B784gHKOSVewoVW+WsH/tB3CxkB2gRVgRiWMlOlp7vtFx0Wk2ePGB0bG4Aa7v1J4
aPJ6DA66Y0Z7Vh70YLK5hvUu0shrPjBymtBkzeTxCvixR21eHcG94/cSry+PnXCH
95OVMSyMxJiOSrZQfX9NQvDwpvmHi7vDo5s87OAUQhFdqVdCy85yNlEiju/jQ43G
Y7rm515/Zc1Bfhl98u9DXQ888St7+bsDChfFkHer2PPa3I6mpn+CL1LPBFkugaxM
+hfjoB+/nkh36iKEY8nqsimvHJ/AOnHZQtY8GDaoBI8Crjmo77fSksmlbFZhdmIg
3pr31ZdGdImhzk1Wb4VFtujJ0Oc/apk8PcVL+VL9Cr+ayFNuX2u6qEq4Tm+P3Cep
ot8+KcuEQ5nnbRHmCk9X
=hBzz
-----END PGP SIGNATURE-----

--nextPart15521153.fnhVaFgWou--
