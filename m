From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Wed, 6 Sep 2017 16:44:50 +0200
Message-ID: <20170906144450.tsa7dlmpeb4uz2pc@taurus.defre.kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170901070212.7xurrbentxybdhfx@x>
 <CAMHZB6En=BeF_6NBfEDr26hdP5rmTt+A4p5Y3Cn=nEzZDaTz9w@mail.gmail.com>
 <715b7059-4ff0-0982-ff92-56c13c4160e7@kleine-koenig.org>
 <CAMHZB6GHoA6v_RPtKF3WBbX0DPB5pqfz9wLf1iP8MWfUVdbteQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jiu5m5cgmgkvkptv"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:40686 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932546AbdIFOox (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 10:44:53 -0400
Content-Disposition: inline
In-Reply-To: <CAMHZB6GHoA6v_RPtKF3WBbX0DPB5pqfz9wLf1iP8MWfUVdbteQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--jiu5m5cgmgkvkptv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[readding people to Cc assuming that's ok]

Hello Luc,

On Mon, Sep 04, 2017 at 10:36:47PM +0200, Luc Van Oostenryck wrote:
> On Mon, Sep 4, 2017 at 10:57 AM, Uwe Kleine-K=F6nig <uwe@kleine-koenig.or=
g> wrote:
> > On 09/03/2017 11:14 PM, Luc Van Oostenryck wrote:
> >> On Fri, Sep 1, 2017 at 9:02 AM, Josh Triplett <josh@joshtriplett.org> =
wrote:
> >>> Related to that: while it would mean we couldn't necessarily just rely
> >>> entirely on GCC's definitions for a target platform, I think in an id=
eal
> >>> world we could have a sparse binary that understood *all* target
> >>> platforms at once, such that you could ask Sparse on x86_64 to "compi=
le"
> >>> as though targeting any arbitrary architecture. That would also have =
the
> >>> major advantage of making it easy to run the Sparse testsuite for
> >>> *every* target architecture without needing compilers for every such
> >>> architecture.
> >>
> >> I really think that the testsuite should not depend on system or libra=
ry
> >> header.
> >
> > Assuming it's intended that sparse should be able to check userspace
> > programs, I don't agree here.
>=20
> I understand this.
> I'll explain a bit better my point of view.
> First, I make a distinction between 'sparse core functionalities' and
> general usage.
> I was talking about this core usage and the testsuite is currently for th=
is core
> usage too.

and while it's ok to test the core stuff and not wanting the system
includes to interfere, there should also be tests that check "ordinary"
userspace programs which naturally depend on the system headers.

> Asking for the testsuite to not depends on system or library header is ex=
actly
> the same as GCC people asking bug reports to be done on pre-processed file
> (so that they focus on the core problem and not some problem with an head=
er).
> This, of course, doesn't mean that GCC should only be used on standalone
> source files nor that GCC shouldn't be tested on real code, using
> system headers.
> It's just something different.
>=20
> So to answer to your objection: yes, you're right but it should be done i=
n some
> specific tests, not the core ones.

ah, we agree. Fine.

> Secondly, about "intended to check userspace programs":
> It's clear that sparse's main use is for the kernel, but it's also
> clear that it can
> and is used on other (userspace) projects.
> However, as you have seen yourself, you can't use sparse as is and expect
> to work on any environment, on any architecture. Even for the kernel it d=
oesn't:
> each architecture has to specify a few flags (like -m32/-m64) and a few d=
efines
> (-D__arm__, ...). For userspace, cgcc can do a part of this job for you.
>=20
> Josh proposal to have what I called a 'universal' sparse, won't solve thi=
s,
> on the contrary.
> Compilers eschew part of this problem by having to configure the build
>=20
> I'm all in favor to move cgcc logic to sparse and/or it's build system so=
 that
> *for a native build* it can be used as-is in most cases.
> This would solve your problem, I think.
>=20
> BTW, sorry I didn't follow last week but is your problem solved now?

No, it's not solved. But given that it is somehow known that sparse
(without cgcc) fails to work well on userspace stuff, I think the
following would be fine for the Debian side:

 a) let horst use cgcc instead of sparse
 b) downgrade bug to important or even normal pointing out that cgcc
    should be used for userspace programs

For sparse it would be cool to:

 c) drop the #weak_define of __amd64__ to make this "problem" more
    apparent. (Assuming this doesn't break e.g. a kernel build.)
 d) fix the test suite, at least mark the tests that are expected to
    fail on !x86 as such to make $(make check) succeed. (Otherwise I'd
    have to disable or ignore the testsuite which isn't that great.)
=20
Best regards
Uwe

--jiu5m5cgmgkvkptv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlmwCd8ACgkQwfwUeK3K
7AmlgQf/dbCsL3RILRpOyYDJ1ZiSBVQE4Ac9+Ap0feqGqjXGYNAdX5p8E05Og/Qj
zVlm/mS2bK0eXd8jOm41lsMhi5ljSaWufQSK9ZwdtLK6A/8UHBJYe9bioj36q9AK
Ns3SBo59IXumB6dMvmFNEds+Tnyv2sbgTXkbQ3xgXL4Y0Bs6HP5+LVErQMP5dz81
7XgFgo2eliv623UibutZLaCKPZD2UG9dmc3AnESTAm6UCO4MRBPM297MlVtq0u3t
um1m8/DxhhmHhBOTFXsf4LKedbYWAMNwimoiKuXRYFNgBCJEZCULciwfxEnVog9C
EmGpyhLgfZI8ndrm1nciUeu6B0zz6w==
=9NJ9
-----END PGP SIGNATURE-----

--jiu5m5cgmgkvkptv--
