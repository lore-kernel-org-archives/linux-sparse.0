From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] build: make PREFIX overwritable on the commandline
Date: Sat, 23 Sep 2017 20:31:53 +0200
Message-ID: <20170923183153.i4mt4zlsniv22jbv@taurus.defre.kleine-koenig.org>
References: <20170922212524.8095-1-uwe@kleine-koenig.org>
 <CANeU7QnCU7qfFzRGMC-v=Q5onaJgSUvAqiUWJT0FaKHc_Qp2RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5or4puarkrrril6i"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:46057 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750839AbdIWScD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 23 Sep 2017 14:32:03 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QnCU7qfFzRGMC-v=Q5onaJgSUvAqiUWJT0FaKHc_Qp2RQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>


--5or4puarkrrril6i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2017 at 07:20:27AM -0400, Christopher Li wrote:
> On Fri, Sep 22, 2017 at 5:25 PM, Uwe Kleine-K=F6nig <uwe@kleine-koenig.or=
g> wrote:
> > This way I can just use
> >
> >         make install PREFIX=3D/usr
> >
> > on the command line to install sparse into the system.
> >
> >  DESTDIR=3D
> > -PREFIX=3D$(HOME)
> > +PREFIX ?=3D $(HOME)
>=20
> Are you sure you need this patch to use "make install PREFIX=3D/usr" ?

Oh, you're right. I pass PREFIX via the environment. But as there are
already other things I pass on the command line I can also pass PREFIX
there. I still consider ?=3D as the right thing to do there, but it's not
important any more. If you still consider the patch fine, I can update
the commit log accordingly.

Best regards
Uwe

--5or4puarkrrril6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnGqJYACgkQwfwUeK3K
7AmeUwgAkxO061p5nGFxJstStE+wQV1OVJVnrvFp7PlMnJQaoggbs4INDKx2Goz/
jaWyHeKSoVKoOojNENrjKaiu0KxGRJ/WGfIXDQe0At3U63dWI0F8Ao9BUi54il1O
OqRzZvrarKGL7xsEFcjQdrpBfnlGjhWHADB2+hRy7TevspqS5RYqymKFYhK9HzIz
KpfkOEzY/HL7dprVgtwwSM5x94leXpt6UhAfRjkBnAEKB4OAa38vBycs7b+x08j4
TrleupvntjRCPiGb6OvcjauWFTSF+JwP+QLoBszYQLleatanjPd+oaUdlGJQ/wSh
fueBrQrMT7M+RKcvJqFDLheCgjjzdw==
=gI+S
-----END PGP SIGNATURE-----

--5or4puarkrrril6i--
