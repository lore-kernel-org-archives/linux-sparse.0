From: Josh Triplett <josh@freedesktop.org>
Subject: Re: constness bug in include/linux/compiler.h
Date: Wed, 14 Mar 2007 09:18:54 -0700
Message-ID: <45F8206E.8030706@freedesktop.org>
References: <ee9e417a0703131523x2cc701f7l7938624175bf1fe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4332FB3A0471FB42255BB79B"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:33268 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411AbXCNQTS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Mar 2007 12:19:18 -0400
In-Reply-To: <ee9e417a0703131523x2cc701f7l7938624175bf1fe0@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Russ Cox <rsc@swtch.com>
Cc: linux-sparse@vger.kernel.org, Tom Bergan <tbergan@ucla.edu>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4332FB3A0471FB42255BB79B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Russ Cox wrote:
> Probably sparse just doesn't pay attention to const,

Actually, it does:

$ cat /tmp/const.c
void f(int *p)
{
}

void g(void)
{
    int i =3D 0;
    const int *p =3D &i;
    f(p);
}
$ ./sparse /tmp/const.c
/tmp/const.c:9:7: warning: incorrect type in argument 1 (different modifi=
ers)
/tmp/const.c:9:7:    expected int *p
/tmp/const.c:9:7:    got int const *p

> but shouldn't the definitions of __chk_user_ptr
> and __chk_io_ptr be
>=20
>     extern void __chk_user_ptr(const void __user *);
>     extern void __chk_io_ptr(const void __iomem *);
>=20
> instead of
>=20
>     extern void __chk_user_ptr(void __user *);
>     extern void __chk_io_ptr(void __iomem *);
>=20
> ?

Yes, that makes sense.  These functions just check for the annotation on =
their
pointer argument, and having the const annotation would allow them to che=
ck
const pointers without provoking a warning due to the lack of const.

- Josh Triplett


--------------enig4332FB3A0471FB42255BB79B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF+CBuGJuZRtD+evsRAoHlAJ9IQjjftQE9dxWhIgJf9pt5c4JZmQCfSxzL
bUiwEJfoXr2JAZfC6w0D4Ac=
=BgNL
-----END PGP SIGNATURE-----

--------------enig4332FB3A0471FB42255BB79B--
