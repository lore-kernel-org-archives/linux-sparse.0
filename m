From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Sat, 16 Sep 2017 15:57:48 +0200
Message-ID: <20170916135748.grwftxoif42dr5dx@taurus.defre.kleine-koenig.org>
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
 <CANeU7QkUorcf-ADV+hKGBBkGpssL==tFtajikVDxug_Z4ffYNg@mail.gmail.com>
 <CAExDi1TpPbeYV+ryhbKh1pe88sGtnFKRd9_TNcbNJ0FgkmB=3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uvv6sklektiwf4n2"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:49810 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751211AbdIPN5v (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 16 Sep 2017 09:57:51 -0400
Content-Disposition: inline
In-Reply-To: <CAExDi1TpPbeYV+ryhbKh1pe88sGtnFKRd9_TNcbNJ0FgkmB=3A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Chris Li <christ.li@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>


--uvv6sklektiwf4n2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2017 at 09:50:07AM +0200, Luc Van Oostenryck wrote:
> On Fri, Sep 15, 2017 at 6:56 PM, Chris Li <christ.li@gmail.com> wrote:
> > On Thu, Sep 14, 2017 at 4:03 PM, Uwe Kleine-K=F6nig <uwe@kleine-koenig.=
org> wrote:
> >> +    } elsif ($spec eq 'gnu/kfreebsd') {
> >> +       return &add_specs ('unix') .
> >> +           ' -D__FreeBSD_kernel__=3D1'
> >
> > This looks good. I will apply it.
> > I don't have FreeBSD to test it though.
>=20
> FYI, this is not really FreeBSD, it's Debian's GNU/kFreeBSD:
> GNU for userland with a FreeBSD kernel.

ack

> > I assume you do
> > the sufficient testing on it already.
>=20
> Yes, my point of view too.

FTR: The difference is:

	(sid_k-a-dchroot)ukleinek@falla:~/sparse$ PATH=3D.:$PATH ./cgcc -c flow.c
	(sid_k-a-dchroot)ukleinek@falla:~/sparse$=20

with the patch applied vs

	(sid_k-a-dchroot)ukleinek@falla:~/sparse$ PATH=3D.:$PATH ./cgcc -c flow.c
	./cgcc: invalid specs: gnu/kfreebsd
	(sid_k-a-dchroot)ukleinek@falla:~/sparse$=20

in the current state.

Best regards
Uwe

--uvv6sklektiwf4n2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlm9LdkACgkQwfwUeK3K
7AkzqAf/dGPTekXAOyXkxUWwec1dy2CW+K8ko/Y9b3WpzDn8dKd+eJ/nZQpybW4n
wg+jw6ybpNWG6/lyIwFoodi9Vvq8xHB9B6h+rMD0mqOWthhA0jFL89KzsewYIEJS
aanCp9KI0NJj2cQVe99rXMz6xHh47TWDSd/lsXE+z7cisXgknn9ZimnL7U+rx8j8
jvjxFlAGL0pavqFhku3iSgZHx39wkbBLb6u+LlcEl5s9t0Naek9IfTeuMi71UsZg
PZqFY0zPGG24pMFUx5NjAnzAUPR5z2emAWK1ZpNDxhrspY01e0lAdIEEtzfxnOCV
dmuphoRHFs7iTBNQIuKHryDfSIERqw==
=GwQJ
-----END PGP SIGNATURE-----

--uvv6sklektiwf4n2--
