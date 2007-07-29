From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [git pull] misc fixes
Date: Sun, 29 Jul 2007 01:11:26 -0700
Message-ID: <46AC4BAE.3070300@freedesktop.org>
References: <20070728235741.GB21089@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig83808B4E9EDA274659E1CF4D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:43579 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbXG2ILa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 Jul 2007 04:11:30 -0400
In-Reply-To: <20070728235741.GB21089@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig83808B4E9EDA274659E1CF4D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> Please pull from git://git.kernel.org/pub/scm/linux/kernel/git/viro/spa=
rse.git
> local15.
>=20
> A bunch of bug fixes + more typechecking sanitized.
>=20
> Contents:
>       add __builtin_strlen()
>       no such thing as array of functions
>       new helper: unfoul()
>       handling of typeof in evaluate_member_dereference()
>       file and global scopes are the same for purposes of struct redefi=
ning
>       ...,array should degenerate
>       sanitize evaluate_ptr_add(), start checking for pointers to funct=
ions
>       fix evaluate_compare()
>       sanitize evaluate_postop()
>       saner -Wtypesign
>       braino in conditional_expression()

Merged; thanks!

- Josh Triplett



--------------enig83808B4E9EDA274659E1CF4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGrEuvGJuZRtD+evsRApbZAJ4/qqB8Qq2tW3MIRY+nkV3CN/dqVgCfTr4B
KpvmIstTJj+PsKiVwUYOm3w=
=YkOD
-----END PGP SIGNATURE-----

--------------enig83808B4E9EDA274659E1CF4D--
