From: Pierre Habouzit <madcoder@debian.org>
Subject: Bug#505177: Hard-coded gcc header path
Date: Tue, 11 Nov 2008 21:13:28 +0100
Message-ID: <20081111201328.GA10073@artemis.corp>
References: <20081111135816.GA25986@logfs.org> <1226412106.4478.5.camel@johannes.berg> <20081111141459.GB25986@logfs.org>
Reply-To: Pierre Habouzit <madcoder@debian.org>, 505177@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wac7ysb48OaltWcw";
	protocol="application/pgp-signature"; micalg=SHA1
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.505177.B505177.122643441319616@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20081111141459.GB25986@logfs.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: =?UTF-8?Q?J=C3=B6rn?= Engel <joern@logfs.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, 505177@bugs.debian.org
List-Id: linux-sparse@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2008 at 02:15:29PM +0000, J=C3=B6rn Engel wrote:
> On Tue, 11 November 2008 15:01:46 +0100, Johannes Berg wrote:
> >=20
> > Well, sort of. The patch is actually determined at sparse build time, so
> > right now sparse requires you to build it against the same compiler that
> > you are currently using. If you rebuild sparse with your shiny new
> > compiler you'll notice that it'll end up with a different path in
> > pre-process.h.
>=20
> Then the short-term solution for debian is clear.  Simply rebuild the
> package and add a dependency on a specific gcc version.

Which sucks badly because the default gcc is not always the same on
every arch, and more importantly, people may want to use different GCCs.
It would look like a better idea to ask gcc for its include path
properly.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkZ52cACgkQvGr7W6HudhyzzQCfamDR5WrI5db3QVcphs1aIQ8B
4wkAoJG43+pK7G2zMzRNUHq3OeyUzE4x
=RDv/
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
