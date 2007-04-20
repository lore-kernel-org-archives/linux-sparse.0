From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Fix the annotated inline call position
Date: Fri, 20 Apr 2007 03:09:32 -0700
Message-ID: <4628915C.2030009@freedesktop.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org> <20070322125911.GW4095@ftp.linux.org.uk> <20070323230817.GC27992@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2728D20EB8520A07BBE658F1"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:34319 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbXDTKJk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Apr 2007 06:09:40 -0400
In-Reply-To: <20070323230817.GC27992@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2728D20EB8520A07BBE658F1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Here is some diff comparing output between the sparse 0.2 and the tip o=
f git.
>=20
> -mm/mmap.c:1631:2: warning: context imbalance in 'expand_stack' - diffe=
rent lock
>  contexts for basic block
> +include/linux/rmap.h:55:2: warning: context imbalance in 'expand_stack=
' - diffe
>=20
> The change is introduced by the inline annotate instruction,
> which mark the bb->pos to the inline function.
>=20
> This change make it back to the caller position.

Applied, thanks.

- Josh Triplett



--------------enig2728D20EB8520A07BBE658F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGKJFcGJuZRtD+evsRAtUbAJ9HSwmX1Optnv9/oPx+CwGueEY9YwCbBSnv
AzTOrQU5lU30XKlf/xZuplI=
=HS8F
-----END PGP SIGNATURE-----

--------------enig2728D20EB8520A07BBE658F1--
