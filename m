From: Josh Triplett <josh@freedesktop.org>
Subject: strict aliasing warnings in Sparse; -fno-strict-aliasing
Date: Sat, 01 Sep 2007 23:03:24 -0700
Message-ID: <46DA522C.4010209@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBF3C5C1D32440FC9C319248C"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:51165 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbXIBGEF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 2 Sep 2007 02:04:05 -0400
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.121]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 2 Sep 2007 06:04:02 -0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF3C5C1D32440FC9C319248C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Since commit 06bcf19cb8eb3cc3154ba6131477d742a9f0b4b6 switching sparse to=
 -O2,
building Sparse generates various warnings like this:

parse.c:676: warning: dereferencing type-punned pointer will break strict=
-aliasing rules

These occur because the ptrlist code breaks the C99 strict aliasing rules=
,
which require that conforming code not access the same memory through poi=
nters
of two different types.

I want to eliminate these warnings in Sparse, both because I want Sparse =
to
build without warnings and because at least in theory these warnings mean=
 that
GCC may generate incorrect code.

However, the more I stare at the ptrlist code, the more I think it can't
possibly work with strict aliasing on.  It intentionally uses pointers to=

different types to refer to the same memory, and I don't see any way to
transform it into code that follows the C99 strict aliasing rules

I found an approach that manages to fool GCC into not warning, but it sti=
ll
violates the strict aliasing standards, as well as the standards for dece=
ncy.

#define union_cast(type, value) (((union { __typeof__((void)0,value) v1; =
type v2; }) { .v1 =3D (value) }).v2)

Using that to convert pointers to struct ptr_list * or struct ptr_list **=

proves sufficiently complex that GCC's strict aliasing warnings don't fir=
e,
but it still ends up with two pointers of different types to the same mem=
ory,
so GCC could still generate incorrect code by assuming aliasing.

The strict-aliasing-compliant way to alias memory also involves a union, =
but
the union must represent the actual memory, not the pointers.

Now, as far as I can tell, nothing in the ptrlist code ever dereferences =
the
dummy field "list" of the structs declared via DECLARE_PTR_LIST, except t=
he
type-safety macros in ptrlist.h, which don't actually use the values they=

obtain.  I *think* that means aliasing issues can't actually cause a prob=
lem
here, because only one of the pointers to the same memory location get
dereferenced.  I'd welcome confirmation of this.

That still leaves the problem of how to handle the warnings.  GCC's
__attribute__((may_alias)) might work, but I don't see how to apply it he=
re;
I've tried various possibilities, and they don't work.  -fno-strict-alias=
ing
would also work.  Either of these approach may lead to suboptimal code
generation.

In the absence of a better suggestion, I intend to make Sparse use
-fno-strict-aliasing.

- Josh Triplett


--------------enigBF3C5C1D32440FC9C319248C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG2lIsGJuZRtD+evsRAjIkAKC0SfLNAFMP0rIO22s7iEfaBXb/cQCfeJ0G
yhha2mufO9tecw4fp5HGrTE=
=F7HZ
-----END PGP SIGNATURE-----

--------------enigBF3C5C1D32440FC9C319248C--
