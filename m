From: Josh Triplett <josh@freedesktop.org>
Subject: Re: barrier macro
Date: Tue, 01 May 2007 20:17:53 -0700
Message-ID: <463802E1.4030303@freedesktop.org>
References: <20070501153448.a65c81c2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig859311D22C273CA43340E3AD"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:44649 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932975AbXEBDR4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 23:17:56 -0400
In-Reply-To: <20070501153448.a65c81c2.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig859311D22C273CA43340E3AD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Randy Dunlap wrote:
> (using sparse 0.3)
>=20
> ./compiler-gcc.h:10:#define barrier() __asm__ __volatile__("": : :"memo=
ry")
>=20
> causes this output:
>=20
> net/sunrpc/xprtsock.c:640:2: error: Expected ( after asm
> net/sunrpc/xprtsock.c:640:2: error: got __volatile__
> net/sunrpc/xprtsock.c:640:2: error: typename in expression
> net/sunrpc/xprtsock.c:640:2: error: Expected ) in function call
> net/sunrpc/xprtsock.c:640:2: error: got :
>=20
>=20
> Maybe sparse could allow modifiers between asm|__asm__ and the
> (...) ?

Sparse specifically allows volatile, and double-underscore variants, betw=
een the asm keyword and the open parenthesis:

static struct token *parse_asm_statement(struct token *token, struct stat=
ement *stmt)
{
        token =3D token->next;
        stmt->type =3D STMT_ASM;
        if (match_idents(token, &__volatile___ident, &__volatile_ident, &=
volatile_ident, NULL)) {
                token =3D token->next;
        }
        token =3D expect(token, '(', "after asm");
[...]


I cannot reproduce your report with the following test case (just added t=
o git
as validation/asm-volatile.c):

#define barrier() __asm__ __volatile__("": : :"memory")

static void f(void)
{
        barrier();
}


Perhaps something else has caused the problem.  Could you please generate=
 a
preprocessed file with "make net/sunrpc/xprtsock.i", and strip it down to=
 a
minimal test case that still generates the Sparse warning?

- Josh Triplett


--------------enig859311D22C273CA43340E3AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOALhGJuZRtD+evsRAk6KAJ9cnAIWQoxpyJX51BtlTt8DPO9ZdACeO94I
0VVkyqpTVmrCHthgCMvPuNw=
=HQMM
-----END PGP SIGNATURE-----

--------------enig859311D22C273CA43340E3AD--
