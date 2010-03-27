From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Sat, 27 Mar 2010 02:29:50 -0700
Message-ID: <20100327092949.GB9548@feather>
References: <1268097872.16227.10.camel@mj>
 <201003211627.14164.kdudka@redhat.com>
 <70318cbf1003240307m6be38384l3524923484e493ce@mail.gmail.com>
 <201003271016.39291.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:35266 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0C0JaE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Mar 2010 05:30:04 -0400
Content-Disposition: inline
In-Reply-To: <201003271016.39291.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Sat, Mar 27, 2010 at 10:16:38AM +0100, Kamil Dudka wrote:
> On Wednesday 24 of March 2010 11:07:04 Christopher Li wrote:
> > That is just too much. Most of the warning is coming from enum or
> > operation. e.g.
> > .type =3D KW_SPECIFIER | KW_SHORT,
> > lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
>=20
> Looking once again, I don't think that's the case.  The warnings do n=
ot come=20
> from the "enum or" operation, but they come from passing the integral=
 result=20
> to enum variable (or arg).  Instead of weaking my patch, we may impro=
ve the=20
> code of sparse and add explicit casts back to enum:
>=20
>     .type =3D (enum keyword) (KW_SPECIFIER | KW_SHORT),
>     lookup_keyword(token->ident, (enum namespace) (NS_KEYWORD | NS_TY=
PEDEF));

That looks wrong.  .type doesn't contain a value of type "enum keyword"=
,
it contains the bitwise or of such values, which won't represent a vali=
d
enum value.  Thus, .type should have an integral type, not an enum type=
=2E
The same goes for the second parameter of lookup_keyword.

> The whole problem can be narrowed down to a simple test-case:
>=20
>     int main()
>     {
>         enum {
>             A =3D 0x1,
>             B =3D 0x2
>         } val =3D A | B;

This code seems semantically wrong, as described above.  val should onl=
y
have values 0x1 or 0x2, and you've assigned it 0x3, which doesn't
represent a valid value of its enum type.

> Here is what sparse gives:
> $ ./sparse enum.c
> enum.c:1:10: warning: non-ANSI function declaration of function 'main=
'
> enum.c:6:15: warning: conversion of
> enum.c:6:15:     int to
> enum.c:6:15:     int enum <noident>
>=20
>=20
> Here is what g++ gives:
> $ g++ enum.c
> enum.c: In function =E2=80=98int main()=E2=80=99:
> enum.c:6: error: invalid conversion from =E2=80=98int=E2=80=99 to =E2=
=80=98main()::<anonymous enum>=E2=80=99

Yup, both of these warnings seem correct.  Don't fix them by casting,
fix them by declaring "val" with an appropriate integral type.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
