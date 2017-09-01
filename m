From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Fri, 1 Sep 2017 09:57:09 +0200
Message-ID: <20170901075709.gkjnug4dmsyvji7i@taurus.defre.kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170901070212.7xurrbentxybdhfx@x>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="smtvbvvybsci347h"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:37694 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751237AbdIAH5L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Sep 2017 03:57:11 -0400
Content-Disposition: inline
In-Reply-To: <20170901070212.7xurrbentxybdhfx@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--smtvbvvybsci347h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2017 at 12:02:12AM -0700, Josh Triplett wrote:
> On Thu, Aug 31, 2017 at 08:47:55PM -0400, Christopher Li wrote:
> > On Thu, Aug 31, 2017 at 4:55 PM, Uwe Kleine-K=F6nig <uwe@kleine-> Yes
> > that works. So to address the Debian bug I can do:
> > >
> > >  - move sparse to /usr/lib
> > >  - teach cgcc about the move of sparse
> > >  - make /usr/bin/sparse call cgcc -no-compile "$@"
> >=20
> > I don't like that. It means the user can't invoke sparse directly.
> >=20
> > >
> > > or is it easier to teach sparse about the architecture stuff?
> >=20
> > First of all. It is not very trivial to teach sparse about the architec=
ture
> > stuff. To my mind, we need to move all the cgcc logic into sparse.
>=20
> Related to that: while it would mean we couldn't necessarily just rely
> entirely on GCC's definitions for a target platform, I think in an ideal
> world we could have a sparse binary that understood *all* target
> platforms at once, such that you could ask Sparse on x86_64 to "compile"
> as though targeting any arbitrary architecture. That would also have the
> major advantage of making it easy to run the Sparse testsuite for
> *every* target architecture without needing compilers for every such
> architecture.

You'd need the target arch's system headers though. But still it would
be great. In a first attempt something like:

	#ifdef __powerpc__
		add_pre_buffer("#weak_define __powerpc__ " __powerpc__ "\n");
	#ifdef _CALL_ELF
		add_pre_buffer("#weak_define _CALL_ELF " _CALL_ELF "\n");
	#endif
	#endif

would be helpful already.

Best regards
Uwe

--smtvbvvybsci347h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlmpEtEACgkQwfwUeK3K
7AktfQf+LFRb8UNWUUxxM5vDi1ZeiIhnHyjKfVkkbZbl+V4PCxJ1Uu+h7CC5XWLH
j/GQkWeUXNDh3hSU5kfPUUMdSPL1U9+TC+xYTDfvp6XEohD6XfBJvUAhDOsmQ46L
Qc7CVAKccWi0ftYHd/xCEB86pI+RMkI1CqManp2zI5F9LZDnLY2ntIF/HC7Nmu9Q
Uc0l+03A4ibv1oiHmxDKAyBg04CBuiOQL06gqI63xnaU1DRTeu2paaj1j6TcYkZq
Zx/mdIOvXnAUj7L4l/4vwNlofHFCcq4hlHFjnZapfaB4oUKAF3XI/gXlU4ClDRSo
Mws/CcV+S471+FSWE6yB33NyOEgKmQ==
=YICU
-----END PGP SIGNATURE-----

--smtvbvvybsci347h--
