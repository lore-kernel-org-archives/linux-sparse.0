From: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Bug#906472: horst: FTBFS in buster/sid (unable to open 'stdarg.h')
Date: Fri, 14 Sep 2018 21:45:44 +0200
Message-ID: <20180914194543.GA22476@taurus.defre.kleine-koenig.org>
References: <E1fqkJB-0004Wc-55@paradis.debian.org> <E1fqkJB-0004Wc-55@paradis.debian.org> <1535227396@msgid.manchmal.in-ulm.de> <20180914140409.GA25593@localhost> <E1fqkJB-0004Wc-55@paradis.debian.org>
Reply-To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 906472@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <bounce-debian-bugs-rc=glddbr-debian-bugs-rc2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.906472.B906472.1536955363898@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20180914140409.GA25593@localhost>
List-URL: <https://lists.debian.org/debian-bugs-rc/>
List-Post: <mailto:debian-bugs-rc@lists.debian.org>
List-Help: <mailto:debian-bugs-rc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=unsubscribe>
To: Christoph Biedl <debian.axhn@manchmal.in-ulm.de>, Santiago Vila <sanvila@debian.org>
Cc: 906472@bugs.debian.org, linux-sparse@vger.kernel.org, Adrian Bunk <bunk@debian.org>
List-Id: linux-sparse@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Cc +=3D sparse mailing list]

On Fri, Sep 14, 2018 at 05:04:09PM +0300, Adrian Bunk wrote:
> Control: reassign -1 sparse 0.5.2-1
> Control: affects -1 src:horst
>=20
> On Sat, Aug 25, 2018 at 10:09:47PM +0200, Christoph Biedl wrote:
> > Santiago Vila wrote...
> >=20
> > > 	make -j1 check
> > > make[1]: Entering directory '/<<PKGBUILDDIR>>'
> > > sparse -g -O2 -fdebug-prefix-map=3D/<<PKGBUILDDIR>>=3D. -fstack-prote=
ctor-strong -Wformat -Werror=3Dformat-security -std=3Dgnu99 -Wall -Wextra -=
g -I. -DDO_DEBUG -I/usr/include/libnl3 *.[ch]
> > > /usr/include/err.h:25:11: error: unable to open 'stdarg.h'
> >=20
> > To reproduce this it's important to remove gcc-7 from the build chroot
> > (apt purge libgcc-7-dev ; apt --purge autoremove).
> >=20
> > Problem is, sparse appearently uses hardcoded paths and looks for
> > stdarg.h in (among other places)
> >=20
> > | /usr/lib/gcc/x86_64-linux-gnu/7//include/stdarg.h
> > |                               ^
> >=20
> > ... which fails.
> >=20
> > Solution is to rebuild sparse, building horst was successful then.
> > If this is true (please check!), the interesting question is why this
> > wasn't a problem in earlier gcc version bumps.

I think this is a known limitation of sparse and there are three
ways to fix this (in my order of preference):

 a) let horst use cgcc -no-compile instead of sparse; or
 b) let sparse depend on libgcc-7-dev (or whatever provides the
    necessary files); or
 c) use autodetection which gcc is used and pick its files.

I'm not sure if a) fixes the problem. It fixed another problem we had
with horst's usage of sparse in the past though[1].

The downside of c) is that running this autodetection on every call to
sparse is probably slowing down sparse a bit which isn't nice.

Best regards
Uwe

[1] https://bugs.debian.org/873508

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlucD+QACgkQwfwUeK3K
7AmwdQf+PuAzYgQgyvmQQ4VmxhkEjM5DT5qfn4mvrFoyE/vp3Vute6s3FivpIroW
G73W7gUyio9+aKAduWQnBPqXEnMwtnju7IC7NbMY9D13+pn0TAo00U2N5M2z1NqB
hCrc0rGSsr7ftTTiTqTNlIbIULhmPNHAFWjM1KM7vZ8S6zJCiCPtR1o+AnrTQpy0
UgEHWrJle4o6KtuWGcPJV6ASEDgeP1duRmgQIP47cDfRRSDFxiLa1wxmiGomiBpf
SwbBN5kpeAYRdSAQ0lLl7wGQQ9pNXzDrRYhAbbZZNQuUfkD2h4koksg/OzYiLXRr
YzswkknBnJ33POSk4uNEMLbmJwoaRQ==
=4NBx
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
