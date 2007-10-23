From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Bogus 'not declared' warning
Date: Tue, 23 Oct 2007 12:23:23 -0700
Message-ID: <471E4A2B.3080500@freedesktop.org>
References: <20071023142450.GP27248@parisc-linux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7FCE9F8F6F0ECCAE1CC89FBE"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:48848 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbXJWTYY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Oct 2007 15:24:24 -0400
In-Reply-To: <20071023142450.GP27248@parisc-linux.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7FCE9F8F6F0ECCAE1CC89FBE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox wrote:
> Seems to me that sparse ignores 'static' forward declarations, leading
> to false warnings like this:
>=20
> /home/willy/kernel/linux-2.6/drivers/scsi/sym53c8xx_2/sym_hipd.c:3786:5=
: warning: symbol 'sym_compute_residual' was not declared. Should it be s=
tatic?
>=20
> $ grep -n sym_compute_residual drivers/scsi/sym53c8xx_2/*
> drivers/scsi/sym53c8xx_2/sym_hipd.c:61:static int sym_compute_residual(=
struct sym_hcb *np, struct sym_ccb *cp);
> drivers/scsi/sym53c8xx_2/sym_hipd.c:3033:               cp->sv_resid =3D=
 sym_compute_residual(np, cp);
> drivers/scsi/sym53c8xx_2/sym_hipd.c:3786:int sym_compute_residual(struc=
t sym_hcb *np, struct sym_ccb *cp)

Interesting; yes, it looks like the routine emitting that warning
doesn't check for a symbol marked static by having a previous static
declaration.  That warning comes from check_duplicates in evaluate.c.
Seeing it means Sparse didn't see any previous declaration of the
symbol by checking the same_symbol linked list, which seems wrong.
check_declaration in symbol.c hooks symbols into those lists.  That
implies 1) the scopes don't match and 2) one or the other symbol
doesn't have extern.  The latter should clearly hold true (that case,
IIRC, handles letting you put extern declarations inside inner
scopes).  I think the former occurs because one declaration has file
scope and the other one global scope, but that has a chicken-and-egg
issue in the case of a static forward declaration: the static forward
declaration applies, and makes the later declaration have file scope.

I *think* the right fix involves changing check_declaration to check
for this case specifically:
if (next->scope =3D=3D file_scope && sym->scope =3D=3D global_scope) {
	sym->scope =3D file_scope;
	sym->same_symbol =3D next;
	return;
}

Will test this later.

- Josh Triplett



--------------enig7FCE9F8F6F0ECCAE1CC89FBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHHkorGJuZRtD+evsRAhIkAJ0QjfaDwbAq1dzheGTyCcTbXeCslgCfVy6R
rmvcDmaljCt0+aIh8fPRFSU=
=a5TH
-----END PGP SIGNATURE-----

--------------enig7FCE9F8F6F0ECCAE1CC89FBE--
