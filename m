From: Josh Triplett <josh@freedesktop.org>
Subject: Re: barrier macro
Date: Tue, 01 May 2007 21:11:22 -0700
Message-ID: <46380F6A.8020909@freedesktop.org>
References: <20070501153448.a65c81c2.rdunlap@xenotime.net>	<463802E1.4030303@freedesktop.org> <20070501210413.d544d9eb.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig32A3C214C22EE25480C19B50"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:52241 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992705AbXEBELZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 00:11:25 -0400
In-Reply-To: <20070501210413.d544d9eb.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig32A3C214C22EE25480C19B50
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Randy Dunlap wrote:
> On Tue, 01 May 2007 20:17:53 -0700 Josh Triplett wrote:
>=20
>> Randy Dunlap wrote:
>>> (using sparse 0.3)
>>>
>>> ./compiler-gcc.h:10:#define barrier() __asm__ __volatile__("": : :"me=
mory")
>>>
>>> causes this output:
>>>
>>> net/sunrpc/xprtsock.c:640:2: error: Expected ( after asm
>>> net/sunrpc/xprtsock.c:640:2: error: got __volatile__
>>> net/sunrpc/xprtsock.c:640:2: error: typename in expression
>>> net/sunrpc/xprtsock.c:640:2: error: Expected ) in function call
>>> net/sunrpc/xprtsock.c:640:2: error: got :
>>>
>>>
>>> Maybe sparse could allow modifiers between asm|__asm__ and the
>>> (...) ?
>> Sparse specifically allows volatile, and double-underscore variants, b=
etween the asm keyword and the open parenthesis:
>>
>> static struct token *parse_asm_statement(struct token *token, struct s=
tatement *stmt)
>> {
>>         token =3D token->next;
>>         stmt->type =3D STMT_ASM;
>>         if (match_idents(token, &__volatile___ident, &__volatile_ident=
, &volatile_ident, NULL)) {
>>                 token =3D token->next;
>>         }
>>         token =3D expect(token, '(', "after asm");
>> [...]
>>
>>
>> I cannot reproduce your report with the following test case (just adde=
d to git
>> as validation/asm-volatile.c):
>=20
> I'm doing this on i386 (x86_32).  Maybe that would help you.

Same here.

> It's trivial to reproduce.

I've managed to reproduce it using a current Linux tree.  Let me look int=
o it.

>> #define barrier() __asm__ __volatile__("": : :"memory")
>>
>> static void f(void)
>> {
>>         barrier();
>> }
>>
>>
>> Perhaps something else has caused the problem.  Could you please gener=
ate a
>> preprocessed file with "make net/sunrpc/xprtsock.i", and strip it down=
 to a
>> minimal test case that still generates the Sparse warning?
>=20
> Sure, I'll trim the 35000 lines down to a test case and get back
> to you.

Ouch.  Nevermind, now that I've reproduced it I'll take care of it.

- Josh Triplett


--------------enig32A3C214C22EE25480C19B50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOA9qGJuZRtD+evsRAiijAJ4ioT4eBwFPgobewL4awAurj5VSLwCgqhx+
XJeKlsd30M0ytdejR444YWE=
=BNQv
-----END PGP SIGNATURE-----

--------------enig32A3C214C22EE25480C19B50--
