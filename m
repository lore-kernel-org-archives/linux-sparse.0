From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Bogus 'not declared' warning
Date: Tue, 13 Nov 2007 04:13:32 -0800
Message-ID: <473994EC.8080306@freedesktop.org>
References: <20071023142450.GP27248@parisc-linux.org> <471E4A2B.3080500@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC9F2E1B7F13980552FEDD94"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:48253 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbXKMMNp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Nov 2007 07:13:45 -0500
In-Reply-To: <471E4A2B.3080500@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC9F2E1B7F13980552FEDD94
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Josh Triplett wrote:
> Matthew Wilcox wrote:
>> Seems to me that sparse ignores 'static' forward declarations, leading=

>> to false warnings like this:
>>
>> /home/willy/kernel/linux-2.6/drivers/scsi/sym53c8xx_2/sym_hipd.c:3786:=
5: warning: symbol 'sym_compute_residual' was not declared. Should it be =
static?
>>
>> $ grep -n sym_compute_residual drivers/scsi/sym53c8xx_2/*
>> drivers/scsi/sym53c8xx_2/sym_hipd.c:61:static int sym_compute_residual=
(struct sym_hcb *np, struct sym_ccb *cp);
>> drivers/scsi/sym53c8xx_2/sym_hipd.c:3033:               cp->sv_resid =3D=
 sym_compute_residual(np, cp);
>> drivers/scsi/sym53c8xx_2/sym_hipd.c:3786:int sym_compute_residual(stru=
ct sym_hcb *np, struct sym_ccb *cp)
>=20
> Interesting; yes, it looks like the routine emitting that warning
> doesn't check for a symbol marked static by having a previous static
> declaration.  That warning comes from check_duplicates in evaluate.c.
> Seeing it means Sparse didn't see any previous declaration of the
> symbol by checking the same_symbol linked list, which seems wrong.
> check_declaration in symbol.c hooks symbols into those lists.  That
> implies 1) the scopes don't match and 2) one or the other symbol
> doesn't have extern.  The latter should clearly hold true (that case,
> IIRC, handles letting you put extern declarations inside inner
> scopes).  I think the former occurs because one declaration has file
> scope and the other one global scope, but that has a chicken-and-egg
> issue in the case of a static forward declaration: the static forward
> declaration applies, and makes the later declaration have file scope.
>=20
> I *think* the right fix involves changing check_declaration to check
> for this case specifically:
> if (next->scope =3D=3D file_scope && sym->scope =3D=3D global_scope) {
> 	sym->scope =3D file_scope;
> 	sym->same_symbol =3D next;
> 	return;
> }

Turns out this will take a bit more work to fix.  check_declaration
seems like the wrong place for this check, and in any case the code
above won't properly hook the symbol into its scope since it doesn't
call bind_symbol.  bind_symbol in turn has some dead code and other
problems.  I don't plan to address this for the 0.4.1 release,
other than by adding a test case for this, because I don't want to
further delay the other bugfixes in 0.4.1.

- Josh Triplett


--------------enigBC9F2E1B7F13980552FEDD94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHOZTsGJuZRtD+evsRAksWAJ4oRCgSEnKquC99xEochMfmo+RJHACfbejZ
ip8DA4O0dDj3xbq/vxiDNyw=
=3BDM
-----END PGP SIGNATURE-----

--------------enigBC9F2E1B7F13980552FEDD94--
