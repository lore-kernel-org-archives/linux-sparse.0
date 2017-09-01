From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Fri, 1 Sep 2017 09:46:44 +0200
Message-ID: <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrkrfczerr6cvbjz"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:37682 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751404AbdIAHqq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Sep 2017 03:46:46 -0400
Content-Disposition: inline
In-Reply-To: <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--lrkrfczerr6cvbjz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 31, 2017 at 11:43:53PM +0100, Ramsay Jones wrote:
> On 31/08/17 21:55, Uwe Kleine-K=F6nig wrote:
> > On Wed, Aug 30, 2017 at 08:11:49PM -0400, Christopher Li wrote:
> >> That is very much like on x86_64 missing define "#weak_define __x86_64=
__ 1"
> >>
> >> Does cgcc work for you? In the future we do want to move the archetect=
ure
> >> related define from cgcc into sparse by itself. For now you can set
> >> "sparse" as "cgcc -no-compile"
> >=20
> > Yes that works. So to address the Debian bug I can do:
> >=20
> >  - move sparse to /usr/lib
> >  - teach cgcc about the move of sparse
> >  - make /usr/bin/sparse call cgcc -no-compile "$@"
>=20
> Hmm, I don't think that would be a good idea ...
>=20
> > or is it easier to teach sparse about the architecture stuff?
>=20
> I now understand (I think!) that you are building a sparse
> package (presumably a .deb) and you are concerned that sparse
> does not pass it's own testsuite on those platforms.

Nearly right. I'm responsible for the sparse Debian package and the
problem at hand is https://bugs.debian.org/873508. This bug report has
"Severity: serious" wihch might eventually result in the removal of
sparse from the Debian archive.

@anarcat: Given that cgcc seems to work, would you agree to apply the
following patch to horst:

diff --git a/Makefile b/Makefile
index 4f924fa..d563652 100644
--- a/Makefile
+++ b/Makefile
@@ -110,7 +110,7 @@ $(NAME): $(OBJS)
 $(OBJS): .buildflags
=20
 check:
-	sparse $(CFLAGS) *.[ch]
+	cgcc -no-compile $(CFLAGS) *.[ch]
=20
 clean:
 	-rm -f *.o radiotap/*.o *~

and downgrade the bug to "important"? That would be a compromise that
buys us a bit of time.
=20
> As I said before, the additional failures you are seeing are
> in the 'llvm backend' code (which, as far as I know, only passes
> on x86_64 Linux), and in my opinion the llvm-backend programs should
> not be installed. (The Makefile will build them automatically if
> you have llvm installed, likewise for c2xml/libxml and test-inspect/gtk).

Currently the sparse package contains /usr/include/sparse/, c2xml, cgcc,
sparse, sparse-llvm, sparsec and a separate package sparse-test-inspect
includes test-inspect. (That's how I inherited the package some time
ago.)
=20
> [I would like to see build variable(s) to allow the user to suppress
> the build (or installation) of the other 'non-primary' sparse programs.]
>=20
> Anyway, if you were to un-install llvm, sparse-llvm etc., would not
> be built, and the tests would not be run ... ;-)
>=20
> Christopher, as the project maintainer, has the joy of making these
> kinds of decisions! :-D

This only solves a part of the problem because the bug report is about
sparse itself, not it's llvm part.

Best regards
Uwe

--lrkrfczerr6cvbjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlmpEGAACgkQwfwUeK3K
7AnOngf/TVPAbniItWbkz+zgp0Ejkw1efM+2s0SpWe1OlLRJXUOuPZs1i/ZWI5sH
0tt0SgCAgG6yZYXcAK0dsr3Ua1lj0hiz63HRPyvQ3fbmX0oHEKnKvu8gMZ5UBEg6
i52aFuOomNKONDroDv0PaQygqOINuAaJuKcDVq4PDOgXQVo2X+cwioBrZzR+aBYG
Udn0UcUJvhsEIMS7lh0hH+7CBquP5n6eK3bUbJUnkm6sElRa3DZzlyXzJnKKNjFj
xv4OAr/CahUQhDhxX4ecPo4nKtTYHIrkMaDIbza0uLXBSUApOm6L75mIbBrq8z67
HaK3mo0oqUivfZRlIQtzpdNJPneoAg==
=mWqX
-----END PGP SIGNATURE-----

--lrkrfczerr6cvbjz--
