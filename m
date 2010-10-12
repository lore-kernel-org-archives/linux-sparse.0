From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: including sparse headers in C++ code
Date: Tue, 12 Oct 2010 12:42:31 +0200
Message-ID: <1286880151.24953.50.camel@thorin>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	 <20101009205930.GA4684@feather>
	 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	 <AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
	 <20101011233706.GA10991@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4039 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757179Ab0JLKmj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Oct 2010 06:42:39 -0400
In-Reply-To: <20101011233706.GA10991@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Tomas Klacko <tomas.klacko@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Mon, 2010-10-11 at 16:37 -0700, Josh Triplett wrote:
[....]=20
> Wow.  I had to double-check this because I couldn't quite believe C++
> had that degree of dain bramage, but sure enough:
>=20
> /tmp$ cat test.c
> extern void *pv(void);
>=20
> int *pi(void)
> {
>     return pv();
> }
> /tmp$ gcc -c test.c -o /dev/null
> /tmp$ g++ -c test.c -o /dev/null
> test.c: In function =E2=80=98int* pi()=E2=80=99:
> test.c:5: error: invalid conversion from =E2=80=98void*=E2=80=99 to =E2=
=80=98int*=E2=80=99
> (1) /tmp$

Welcome to one of the (more obvious) differences between C and C++: you
can't assign/convert/promote a "void *" to any other pointer type (and
vice versa) without explicit type-cast.
=46or a library written in C, that is the point where "compile it also =
as
C++" ends IMHO. Just keep the 'extern "C" {' stuff in headers (under
'#ifdef __cplusplus') and compile it as C (and not C++).

BTW there are other similar issues if one digs deep enough.
BTDT (read: looked after a library which was used in 2 "applications" -
one in pure C, the other C++. No way without explicit type-casts which
look somewhat funny and are surely superfluous in C as such).

> I can understand C++ having stronger typechecking, but void pointers
> *exist* for this purpose.  *Really* debatable whether Sparse should w=
ork
> around this.  Avoiding keywords, sure, but casting void pointers
> everywhere?  People *remove* these kinds of casts from C programs as =
a
> cleanup.

Type-casts are inherently evil. But in several situations there is in C
no other (or better) workaround. The above - kill warnings through "voi=
d
*" type-casts - makes it worse because some people (including /me) use
the type system in C and want the compiler to check as much as possible=
=2E

Bernd
--=20
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
