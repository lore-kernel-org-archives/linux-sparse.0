From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] build: only generate version.h when needed and remove it
 in clean target
Date: Tue, 19 Sep 2017 20:19:08 +0200
Message-ID: <20170919181907.aa2pk5o2exa5e63c@taurus.defre.kleine-koenig.org>
References: <20170914184540.26650-1-uwe@kleine-koenig.org>
 <CANeU7QnQ-fFvvUfqjCjXfUT5Dn-+vEY-u0KxnNPML3G3iuNBZw@mail.gmail.com>
 <8d555c9d-6eb0-85a2-5f78-999aaf0b12e7@kleine-koenig.org>
 <CANeU7Q=+pM5=Lezf1Wo750ULaKGvLTOMCvTMp6zvPdiKzu_S3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4p4eqcgytzdnszc"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:51389 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751519AbdISSTL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 Sep 2017 14:19:11 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Q=+pM5=Lezf1Wo750ULaKGvLTOMCvTMp6zvPdiKzu_S3w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>


--b4p4eqcgytzdnszc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 11:42:30AM -0400, Christopher Li wrote:
> On Tue, Sep 19, 2017 at 10:50 AM, Uwe Kleine-K=F6nig
> <uwe@kleine-koenig.org> wrote:
> >> You can use "ifneq ($(MAKECMDGOALS),clean)"
> >
> > So it still triggers when doing
> >
> >         make clean all
>=20
> That is the correct behavior. Because "all" require version.h.

After just adding version.h to clean (which might be a sensible separate
change?) but without your proposed change I get this:

	uwe@taurus:~/sparse$ make clean all
	find validation/ \( -name "*.c.output.expected" \
			 -o -name "*.c.output.got" \
			 -o -name "*.c.output.diff" \
			 -o -name "*.c.error.expected" \
			 -o -name "*.c.error.got" \
			 -o -name "*.c.error.diff" \
			 \) -exec rm {} \;
	rm -f *.[oa] .*.d *.so test-lexing test-parsing obfuscate compile graph sp=
arse test-linearize example test-unssa test-dissect ctags c2xml test-inspec=
t sparse-llvm libsparse.so pre-process.h sparse.pc version.h
	     CC       test-lexing.o
	     CC       target.o
	     CC       parse.o
	     CC       tokenize.o
	     CC       pre-process.o
	     CC       symbol.o
	     CC       lib.o
	lib.c:46:10: fatal error: version.h: No such file or directory
	 #include "version.h"
		  ^~~~~~~~~~~
	compilation terminated.
	Makefile:212: recipe for target 'lib.o' failed
	make: *** [lib.o] Error 1

I'd say this is not correct behaviour. The problem is that as is done now,
version.h is created while make parses the Makefile and doesn't really
know about the dependencies (yet). As a consequence make doesn't notice
that version.h is missing while compiling lib.c.

So here are needlessly two things mixed: parsing the Makefile and
generating version.h. It all gets easier if Makefile is parsed first
without caring about version.h as something special and then treat the
header just like every other target.

> It is a silly thing to put clean and all together, but the makefile
> actually do the right thing.

I'd say it's subjective if you consider that silly or not. I usually do
this if I don't trust the build system (e.g. because the build system
contains strange constructs involving MAKECMDGOALS :-)

> > Also you don't want to generate it for $(make check).
>=20
> check is depend on all which depend on version.h.
> So that seems acceptable to me.

ok

> Plus in the make check case, it will only look at the version.h,
> it will not regenerate it if data is the same.

That's shared with my approach.

> > IMHO that's hardly manageable to get done consistently this way and the
> > easiest is a separate rule for version.h that is triggered by make
> > dependencies as I suggested
>=20
> The problem is that, you end up updating the version.h from make's
> point of view. Then make detect the version.h's time stamp haven't
> change and take a short cut. That is the part I consider not clean.

I cannot follow here. lib.c depends on version.h and always when you
update version.h you want to recompile lib.c, don't you? Checking
timestamps is what make is good at (and there for), so I don't
understand your concern. And conditionally updating a target to keep the
old file if no update is needed is a usual approach.

> In other words, if you only look at the make rules and ignore the
> time stamp short cut. "version.h" will be force to update every
> time. It should also recompile lib.o without the short cut.

I'd not call it "time stamp short cut" but version.h being a target that
is only updated when necessary. Looks like plain make for me.

Another "problem" with the current approach is that version.h is
generated synchronously and so it is not parallelized as it should.
(IMHO doesn't matter much because build time is short enough, but IMHO
still a good hint that the construct is broken.)

> >> to wrap it. GNU make document even show that as examples
> >> of using $(MAKECMDGOALS).
> >
> > IMHO that is no prove that the idea is sane.
>=20
> All the example you give seems give sane result.

Do you still think that after the failure reported above?
=20
> >> The above section is not needed if you use the ifneq test on $(MAKECMD=
GOALS).> I also test it and found the problem that, the version.h was force
> >> to obsolete. Two consequent make will always show "GEN version.h"
> >> line.
> >
> > Then maybe split it into
> >
> >         CHECK version.h
> >         GEN   version.h
> >
> > ? The GEN would be skipped if version.h doesn't need an update.
>=20
> Then there is another thing I consider slightly unclean.
> The check rules will optionally update another target "version.h" without
> specificity in its rules.

I don't understand that.

> We can use order only rules for check target. The whole thing seems
> gets more complicated than it needs to.

I don't follow.

Best regards
Uwe

--b4p4eqcgytzdnszc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnBX5gACgkQwfwUeK3K
7AmCRwf/R/KjIhKKcWrilVyZys5woueGk1Xl6/t3q0z1ykJ376iSLF8g9E+IZYNY
Kv+utypW9U0AVs31LOx91ZCRANOd/SvG7vXKDLNF+2u5Ef7uEnwfwi1geeBfATpT
BFWwQpZi373HuB8AdptKCTwenQA6/GEpf6WBY6F7Zoe7RR+nF2IifB/JJmNWAoVq
TvjMXRUEmdIOPUqlI++fJ0QmTGKYgb3XcuhS1m9/n4RvHDNTR0v6wZ9cRMqtL9DH
49wzbZihe9XOhJDcQOFAktWxPsm3P4Qblhxc/IPah6UylweGDTBB2yPFuD6RTzBB
wjEHfH3toCPHbzsbDVuMK/iLkRFNqw==
=R5ha
-----END PGP SIGNATURE-----

--b4p4eqcgytzdnszc--
