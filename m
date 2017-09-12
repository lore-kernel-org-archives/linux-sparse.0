From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Tue, 12 Sep 2017 08:27:10 +0200
Message-ID: <20170912062710.rd6jzjx3535l3agv@taurus.defre.kleine-koenig.org>
References: <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170901070212.7xurrbentxybdhfx@x>
 <CAMHZB6En=BeF_6NBfEDr26hdP5rmTt+A4p5Y3Cn=nEzZDaTz9w@mail.gmail.com>
 <715b7059-4ff0-0982-ff92-56c13c4160e7@kleine-koenig.org>
 <CAMHZB6GHoA6v_RPtKF3WBbX0DPB5pqfz9wLf1iP8MWfUVdbteQ@mail.gmail.com>
 <20170906144450.tsa7dlmpeb4uz2pc@taurus.defre.kleine-koenig.org>
 <CANeU7QmOA4cC55zgiQ-ArySWQWzC-mMQAGF750PYRB=K-_ZPMQ@mail.gmail.com>
 <20170906153603.v2m3e6mqg62htwmg@taurus.defre.kleine-koenig.org>
 <CANeU7Q=7VAN26GvJSf7ApTt6Y5ArQOnEJ7kASes9Suo67t_Rvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpjiacih7zqbua2b"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:46717 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751217AbdILG1T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 02:27:19 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Q=7VAN26GvJSf7ApTt6Y5ArQOnEJ7kASes9Suo67t_Rvg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--hpjiacih7zqbua2b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 01:59:47AM -0400, Christopher Li wrote:
> On Wed, Sep 6, 2017 at 11:36 AM, Uwe Kleine-K=F6nig <uwe@kleine-koenig.or=
g> wrote:
> > There is https://dsa.debian.org/doc/guest-account/ which would give you
> > the possibility to access some Debian machines. Other than that I intend
>=20
> Sorry for the delay. Thanks for the pointer of the guest account.

Tell me if you want to do that. And plan for a delay because there is
some "paper work" to be done before; mainly by other people, so it might
(or might not) take a moment.

> > to upload 0.5.1 to Debian soon and then can provide you links to build
> > failures in the build server farm :-) And if you have a patch, I can
> > volunteer to make the test monkey for you.
>=20
> BTW, if I want to get a PPC64 machine for Linux testing purpose, is the
> used apple G5 a good place to start?

Honestly I don't know. https://wiki.debian.org/ppc64el tells

	Debian/ppc64el requires, at minimum, a POWER8 processor machine.
	Although Debian was initially bootstrapped on a POWER7 set of
	servers. this class of server is not supported anymore, and you
	are not able to run Debian/ppc64el on a POWER7 processor without
	hitting an illegal instruction fault.

Hm https://en.wikipedia.org/wiki/POWER8 tells:

	Systems based on POWER8 became available from IBM in June
	2014. Systems and POWER8 processor designs made by other
	OpenPOWER members was available in early 2015.

So I think this rules out a G5.

https://wiki.debian.org/ppc64el/Installation mentions you can run this
under qemu however.

Best regards
Uwe

--hpjiacih7zqbua2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlm3fjoACgkQwfwUeK3K
7AlqQwf9EKsk8ziurgoWC6TPzJVQ1f3145EPg512pd9sdAN8ps1iSMSlUBMqRszf
aXDWrA4ip9tPr5ocdCZuDnCXVKnafATNshDyPFYipUVdmLvE6c4pwo+kPOLTGvDg
HuXThrTfQLAapa4/naNbjipUuLKQM4wfmm+MtEI+3o1H4zv4K0s1e9Iv1YlFya2W
6MCz4DukBh3I4pDVp0nQeOJ1nyNTz+GZqmUe3oinKYE567yIsNNqo/zybg5trzJD
qqJyRKsXpGnutUYn2tQHR/LW7Al5xQRt6vBE0DHAHY1wPkIVsk/5FbPKoGcPGION
4q3qCDtrjUNmAnkMV9eUn8p+L+5RfQ==
=ArRs
-----END PGP SIGNATURE-----

--hpjiacih7zqbua2b--
