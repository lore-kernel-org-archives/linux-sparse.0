From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] fix cgcc ELF version for ppc64/pcc64le
Date: Sat, 30 Sep 2017 10:49:13 +0200
Message-ID: <20170930084913.raksvxhqlceh6qgs@taurus.defre.kleine-koenig.org>
References: <20170927080007.jz2vfe4ekjjowkbe@taurus.defre.kleine-koenig.org>
 <20170927211137.16461-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3nb7obr4ooyru2vn"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:51477 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750968AbdI3ItS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 30 Sep 2017 04:49:18 -0400
Content-Disposition: inline
In-Reply-To: <20170927211137.16461-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>


--3nb7obr4ooyru2vn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Luc,

On Wed, Sep 27, 2017 at 11:11:37PM +0200, Luc Van Oostenryck wrote:
> Commit e0306fe0 "cgcc: teach cgcc about ppc64[le]" add support
> for PPC64 to cgcc by adding the needed options like '-m64' &
> '-m{little,big}-endian' and defines likes '-D__PPC64__=3D1'.
>=20
> In this commit the defined '-D_CALL_ELF=3D2' was also added
> but the value of 2 is for ELF v2 ABI, normally used for ppc64le,
> while the older ELF ABI, normally used for plain ppc64 should use
> '-D_CALL_ELF=3D2'.
>=20
> Fix this by using the value of 1 or 2 for '_CALL_ELF' depending
> if the architecture is ppc64 or ppc64le.
>=20
> Fixes: e0306fe0b725af6e2e7ff59d7f0d99c96315791a
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

I tested that patch on the following machines:

hostname/chroot                 uname -m        gcc -dumpmachine
partch/sid                      ppc             powerpc-linux-gnu
pizzetti/sid_ppc64-dchroot      ppc64           powerpc64-linux-gnu
plummer/sid_ppc64el-dchroot     ppc64le         powerpc64le-linux-gnu

and my test case (env CHECK=3D./sparse ./cgcc -no-compile memops.c) works
on all of them now.

Tested-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>

Thanks
Uwe

--3nb7obr4ooyru2vn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnPWoUACgkQwfwUeK3K
7AkRzgf9HyGKomI7ypXFN/ucoWhuUImga/NESn+pOPTntgzzIx7MI+orTR06u5ea
QM8uQg9wd7b8QTRlCDooTiIcEXFS+GBLH39AZwrYiq4MR4suLyQwy37LZ9kFRElV
lefUavoHpQtBmMKvpBRpJFMO+UfD48rPnjLwt+dq+07OlnU1KMrqdMgEGBtnbSIo
tQEEnHTO92W+u1yv/6wMsPSGIB+8m4FPF3NXvGUBec2CC4OtCMdkYoNNXGWnJS4x
bKjvGfEkQz4E3fQiZdBp/U7ycq6sBe0KZjSS599w4FyxsiryUZZCuW36T9D8boiB
8hHCwqC2p/2JSxftXt710fkVSZ4IGA==
=Q5na
-----END PGP SIGNATURE-----

--3nb7obr4ooyru2vn--
