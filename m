From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Wed, 6 Sep 2017 17:36:03 +0200
Message-ID: <20170906153603.v2m3e6mqg62htwmg@taurus.defre.kleine-koenig.org>
References: <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170901070212.7xurrbentxybdhfx@x>
 <CAMHZB6En=BeF_6NBfEDr26hdP5rmTt+A4p5Y3Cn=nEzZDaTz9w@mail.gmail.com>
 <715b7059-4ff0-0982-ff92-56c13c4160e7@kleine-koenig.org>
 <CAMHZB6GHoA6v_RPtKF3WBbX0DPB5pqfz9wLf1iP8MWfUVdbteQ@mail.gmail.com>
 <20170906144450.tsa7dlmpeb4uz2pc@taurus.defre.kleine-koenig.org>
 <CANeU7QmOA4cC55zgiQ-ArySWQWzC-mMQAGF750PYRB=K-_ZPMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mul4zcz5moirtfxv"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:40737 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932823AbdIFPgF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 11:36:05 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QmOA4cC55zgiQ-ArySWQWzC-mMQAGF750PYRB=K-_ZPMQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--mul4zcz5moirtfxv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Christopher,

On Wed, Sep 06, 2017 at 11:18:04AM -0400, Christopher Li wrote:
> On Wed, Sep 6, 2017 at 10:44 AM, Uwe Kleine-K=F6nig <uwe@kleine-koenig.or=
g> wrote:
> > and while it's ok to test the core stuff and not wanting the system
> > includes to interfere, there should also be tests that check "ordinary"
> > userspace programs which naturally depend on the system headers.
>=20
> There is one. The "selfcheck" target was checking sparse on its own
> source file. That will definitively use the system header file. However,
> there are some warning trigger in the system header file can't be fixed
> in the sparse source code. It need to change the system header to make
> some warning go away, or disable that warning.
>=20
> >
> > No, it's not solved. But given that it is somehow known that sparse
> > (without cgcc) fails to work well on userspace stuff, I think the
> > following would be fine for the Debian side:
> >
> >  a) let horst use cgcc instead of sparse
> >  b) downgrade bug to important (or even normal) pointing out that
> >     cgcc should be used for userspace programs
>=20
> That seems to be the right thing to do for now. That is until
> sparse are smarter on user space header regarding architecture stuff.

ok, Antoine, can you talk to the horst people and ask them to switch to
cgcc then?

> > For sparse it would be cool to:
> >
> >  c) drop the #weak_define of __amd64__ to make this "problem" more
> >     apparent. (Assuming this doesn't break e.g. a kernel build.)
>=20
> You mean remove define of "__x86_64__".

ack.

> It will likely break some other stuff. For the record the "selfcheck" tar=
get
> already using cgcc. We still need to fix the breakage.
>=20
> Any suggestion how to test sparse running on other platform headfile
> without have to get access to ppc64 for example? I think that is the bigg=
est
> obstacle right now. I can make some changes, but I don't have a good way
> to test it other than x86 platform.

There is https://dsa.debian.org/doc/guest-account/ which would give you
the possibility to access some Debian machines. Other than that I intend
to upload 0.5.1 to Debian soon and then can provide you links to build
failures in the build server farm :-) And if you have a patch, I can
volunteer to make the test monkey for you.

> >  d) fix the test suite, at least mark the tests that are expected to
> >     fail on !x86 as such to make $(make check) succeed. (Otherwise I'd
> >     have to disable or ignore the testsuite which isn't that great.)
>=20
> We can make the test-suite not depend on system header files.
> That seems to be the right think to do. I also send out a patch
> to let the llvm back end test-suite use cgcc last week. Removing
> system header usage in test suite is better.

Testing that patch is on my todo list.

Best regards
Uwe

--mul4zcz5moirtfxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlmwFeAACgkQwfwUeK3K
7Am67wf+LYj3Q2WFy6VFyJNnxG/F46d/WslOyX1INMzPltytfAKGBw84VNwi4iBM
409dVN5EUZ4AiVBeyVoqzmgpDAtLcLzlbpDyNqWMtKA9maW41k5h0F5SPNFS9avm
taeRpac5rdOJyTXL/sjYePxKk7kzNkkZEeh4Kg0FHPIBB/L6r8tyFaVMtXB40frS
SPApWiL2plofk6EzLLcpL8RO4UC26D20cOGNSE1GeJ/ZDGhc7XwZCpoo1OosctgR
E2ceG1iysY9/n4kJpPxz/ItlK15QuK65/yz/0MskJLKCfQ3/aOtM3cvRiSa/gKg7
/Ru2Wevvq2uPpkNgRqG2KkNxkjNFrg==
=x4hK
-----END PGP SIGNATURE-----

--mul4zcz5moirtfxv--
