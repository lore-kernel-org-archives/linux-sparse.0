From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sun, 16 Aug 2009 21:34:31 +0200
Message-ID: <1250451271.11216.0.camel@johannes.local>
References: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
	 <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
	 <1250367991.14751.1.camel@penberg-laptop> <20090815223602.GA4516@feather>
	 <1250406233.32343.9.camel@penberg-laptop> <20090816105114.GA6489@feather>
	 <1250420733.9535.1.camel@penberg-laptop> <20090816124157.GA6936@feather>
	 <70318cbf0908161050w4b95c04cme5f30157cba684df@mail.gmail.com>
	 <20090816185608.GA7806@feather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-6OthxtDxKp7yllpjhwud"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:51789 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932407AbZHPTeg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 16 Aug 2009 15:34:36 -0400
In-Reply-To: <20090816185608.GA7806@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-sparse@vger.kernel.org


--=-6OthxtDxKp7yllpjhwud
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-08-16 at 11:56 -0700, Josh Triplett wrote:

> > The linux kernel has a STRING macro. I will rename to match
> > that if nobody objects.
>=20
> Matching Linux seems sensible, but I don't see that macro in any general
> code, just a bunch of local defines with various names.  A few quick
> greps on current git master turned up at least:

> So, I don't see any particular consistency here that we can follow, other=
 than
> that the macro should probably have "str" in it somewhere. :)  And if we =
have
> to choose, I think STRINGIFY seems more descriptive than just STRING.

There's include/linux/stringify.h that all those instances you found
could use.

johannes

--=-6OthxtDxKp7yllpjhwud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJKiF9EAAoJEODzc/N7+QmaVYwP/2SdBcHwTJDT9oPyMkYnZnOZ
CTHrWryCZFCJafSRMO3CYyVTUoFdFLzsGUSILieGUoqy6E5qiTM4ItEJt/UvprrT
ABS5S9DooPSIlNAW6sh+rTC6n3wt52uASZB0sqoBM7pqkePKNGA+NbUbqLW47uLa
3UrjDj+6jW/Yb6MZDFYNqXlQ2iFp8PRgOROvB/uqdFwsY5Bx/qoWOgLdWEO0DPX+
qTZ+BSQKL+jpXyWvK3Tax5U2wRJ9Wqpx2i3RHdndjprS0tUBQnEhHDw81zZD4clo
Cej+VEk+kxu9peI+BR7/kKKiZPHF361Z9xDkCDTSw9uUoUj+DOQpgYHM3TiD40Jm
JitncWqi27YUmXI9a8q7a0ayx2vsDXZJapPwm/8ertDkhhyCvyvzOte9w4cNsIpT
fq2JIl0jY+Dkrdg0uSZmf6WWOZxIELY+IFZoWy7gxoBB96ZybcBhkiviGX7xaSxT
q41TsX+iL+7CVeO9VW+zvH/pIHkrewYneg8aHLxJal305WnvTEYzWNj9u5snfD96
K/sePK9BEttzvIgM0f7vKImro4/aaDonoMcuIr+g2bTO6DSZeuHc8nqG/wUkphpP
vn6JCylVQu+e62may++kgEWYaPJOqiWyEptGSy946BLmK7JR36Eh8gqJtW/o8LKb
LGExIYnLpabNv3zLcU8A
=26ap
-----END PGP SIGNATURE-----

--=-6OthxtDxKp7yllpjhwud--

