From: Pierre Habouzit <pierre.habouzit@m4x.org>
Subject: Re: for (int i = expr; ....)
Date: Sat, 23 Feb 2008 14:33:30 +0100
Message-ID: <20080223133330.GA10967@artemis.madism.org>
References: <20080221150527.GA7117@artemis.madism.org> <70318cbf0802221226l7888c24auafbe2aabfa9774b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="+QahgC5+KEYLbs62";
	protocol="application/pgp-signature"; micalg=SHA1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pan.madism.org ([88.191.52.104]:44948 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753738AbYBWNdm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 23 Feb 2008 08:33:42 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0802221226l7888c24auafbe2aabfa9774b9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: linux-sparse@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2008 at 08:26:30PM +0000, Chris Li wrote:
> On Thu, Feb 21, 2008 at 7:05 AM, Pierre Habouzit
> <pierre.habouzit@m4x.org> wrote:
> > Sparse doesn't support the C99 construct `for (int i =3D expr; ....)` p=
roperly.
> >  for example, the following C code:
> >
> >     #include <stdlib.h>
> >
> >     int main(void)
> >     {
> >         for (int i =3D atoi("12"); i < 10; i++);
> >         return 0;
> >     }
> >
> >  make sparse spit:
> >
> >     $ sparse -Wall test.c
> >     test.c:5:22: warning: call with no type!
> >
> >  In fact sparse doesn't support 'expr' to be a complex enough expression
> >  (expressions that can be folded work, but not any other afaict).
>=20
> Nah, sparse supports expression in initializer all right.
> It just need to evaluate them to give it the correct ctype.
>=20
> Please try the this one line patch I attached.

  Works for me, thanks.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHwCCqvGr7W6HudhwRAkr4AKCUly4QqE9lv6EIWzFvgg8NBlhAEwCeNip5
Qw+gzhnPw2qHWc+gptUNn6A=
=XhHj
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
