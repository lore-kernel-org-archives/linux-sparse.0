From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: Bug#873508: sparse test failures on ppc32le (and other not so
 common archs)
Date: Tue, 26 Sep 2017 20:11:01 +0200
Message-ID: <20170926181101.jas3ytdiro7o7mj7@taurus.defre.kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com>
 <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
 <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org>
 <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
 <20170921185823.5fnxchdowq5krxy3@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75mntioxqsel7pmj"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:47591 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030929AbdIZSLD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Sep 2017 14:11:03 -0400
Content-Disposition: inline
In-Reply-To: <20170921185823.5fnxchdowq5krxy3@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--75mntioxqsel7pmj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Control: severity 873508 normal
Control: retitle 873508 Fix FTBFS for m68k, hurd, x32 and ppc64

On Thu, Sep 21, 2017 at 08:58:23PM +0200, Uwe Kleine-K=F6nig wrote:
> I still expect some platforms to fail with the wrapper, too, because
> cgcc doesn't know about all platforms yet. But I intend to upload a new
> sparse package soon that includes a build time check for that, and the
> respective fixes are easy.

I did that now, and at least all official Debian ports pass that new
check. I downgraded the severity accordingly to normal.
=20
Current build failures can be seen at

	https://buildd.debian.org/status/package.php?p=3Dsparse&suite=3Dunstable

hurd fails because it doesn't define PATH_MAX and NAME_MAX. m68k fails
with

	sparse: ptrlist.c:125: __add_ptr_list: Assertion `(3 & (unsigned long)ptr)=
 =3D=3D 0' failed.

(Didn't look into this one yet.) And ppc64 and x32 need the respective
cpp defines added I think. If noone beats me to it, I will look into the
latter at least during the next few days.

Best regards
Uwe

--75mntioxqsel7pmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnKmDEACgkQwfwUeK3K
7AljTAf/R1FRqci/rG10U9QWwKuNeo7AKCD3G8IV8i6KabAYvZnXgOTHPdc/hHDh
obS9k2EXMItpU2QPZAyZX442ePOSj10jjMoMPwh91m7HWI5pQKC54lBPnHCdIszw
VYgVzY0944bo/U4wMhsMeRvt81IWtats1qLLRfFIR33/uBNuprInpQbk35NVunHu
XiZZH1QDe9Kjkcva4u4Lgz4l9teZ04cbZcwIZu3VZ+UHi/AP5TTyxrbr9BZgg3cH
guSghzdMnTd6lA6aGwJCTVlYhFNj94tnI+mUocRC+Co4jVkAiM1sPpeiPExpmivA
I2aT9MGqRFHg1HS1uODSil3Vtg6fmQ==
=J/WR
-----END PGP SIGNATURE-----

--75mntioxqsel7pmj--
