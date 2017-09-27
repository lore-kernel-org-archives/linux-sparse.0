From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: Bug#873508: sparse test failures on ppc32le (and other not so
 common archs)
Date: Wed, 27 Sep 2017 10:00:07 +0200
Message-ID: <20170927080007.jz2vfe4ekjjowkbe@taurus.defre.kleine-koenig.org>
References: <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com>
 <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
 <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org>
 <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
 <20170921185823.5fnxchdowq5krxy3@taurus.defre.kleine-koenig.org>
 <20170926181101.jas3ytdiro7o7mj7@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hb4smhc5jdd3gp7"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:48361 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751787AbdI0IAK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 27 Sep 2017 04:00:10 -0400
Content-Disposition: inline
In-Reply-To: <20170926181101.jas3ytdiro7o7mj7@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--2hb4smhc5jdd3gp7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 26, 2017 at 08:11:01PM +0200, Uwe Kleine-K=F6nig wrote:
> And ppc64 and x32 need the respective cpp defines added I think. If
> noone beats me to it, I will look into the latter at least during the
> next few days.

Looking at ppc64, the following fixes the build:=20

diff --git a/cgcc b/cgcc
index a8d7b4f217fe..a1c02899c623 100755
--- a/cgcc
+++ b/cgcc
@@ -286,7 +286,7 @@ sub add_specs {
     } elsif ($spec eq 'ppc64') {
 	return (' -D__powerpc__=3D1 -D__PPC__=3D1 -D_STRING_ARCH_unaligned=3D1' .
 		' -D__powerpc64__=3D1 -D__PPC64__=3D1' .
-		' -D_CALL_ELF=3D2' .
+		' -D_CALL_ELF=3D1' .
 		' -m64' .
 		&float_types (1, 1, 21, [24,8], [53,11], [113,15]));
     } elsif ($spec eq 's390x') {

I wonder if that could be right. Luc, you added =3D2 in
e0306fe0b725af6e2e7ff59d7f0d99c96315791a, maybe you can comment?

Best regards
Uwe

--2hb4smhc5jdd3gp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnLWoQACgkQwfwUeK3K
7Alekgf/dW4RbMhVlzCDAIEjGL6YodklVRQcazc4KaOn9pezEpFC1it+Aq3F23XR
Ha0qO8Cn7INhL10z5ZxPBqF3RWsY4RDMGdsanY/vUCyFWzlFgnEt1nXoQBK8z7H1
sXx8cAd4Za1Z/EdzwGTaOAcSOnGQUO6phwmuUDjtbHWQ5e94kopN1db1jHHI7nXW
Nh4tCs0fjBvwINvtnDBTB0mirszTAGS9eBct2s06+Ug1XwTWwo2PzNbtR07Fj4Tj
nV+3U1qh7IWi3jjkhylIToCVvbt2TSl+Ugqpg3hGYUfT0tVa4U5tOKxgJDt4U1XL
DzfJONYLe+ZaGYNFf8EXDQbNZIJxjA==
=vq7E
-----END PGP SIGNATURE-----

--2hb4smhc5jdd3gp7--
