From: Pierre Habouzit <pierre.habouzit@m4x.org>
Subject: for (int i = expr; ....)
Date: Thu, 21 Feb 2008 16:05:27 +0100
Message-ID: <20080221150527.GA7117@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="3V7upXqbjpZ4EhLz";
	protocol="application/pgp-signature"; micalg=SHA1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pan.madism.org ([88.191.52.104]:60450 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134AbYBUPF3 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 21 Feb 2008 10:05:29 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2AA6A300ED
	for <linux-sparse@vger.kernel.org>; Thu, 21 Feb 2008 16:05:28 +0100 (CET)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sparse doesn't support the C99 construct `for (int i =3D expr; ....)` prope=
rly.
for example, the following C code:

    #include <stdlib.h>

    int main(void)
    {
        for (int i =3D atoi("12"); i < 10; i++);
        return 0;
    }

make sparse spit:

    $ sparse -Wall test.c
    test.c:5:22: warning: call with no type!

In fact sparse doesn't support 'expr' to be a complex enough expression
(expressions that can be folded work, but not any other afaict).

I assume something has to be done in parser.c, but I'm not really sure it's=
 the
sole place=E2=80=A6


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHvZM3vGr7W6HudhwRAj3eAJ4hZCudbEW+gEteveV0cpAAnrIQOwCggHXa
LQLFHweeUn1jEMw413Vo5NI=
=p+nO
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
