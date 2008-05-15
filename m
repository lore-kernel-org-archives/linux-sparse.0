From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Sparse annotation for "context imbalance" false positives?
Date: Thu, 15 May 2008 17:20:02 +0200
Message-ID: <1210864802.3900.8.camel@johannes.berg>
References: <adaod78fe94.fsf@cisco.com>
	 <1210841663.4282.9.camel@johannes.berg>  <ada7idvfw0c.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PVlW/DD8BTDL2ypw2Hru"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:55475 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564AbYEOPU5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 15 May 2008 11:20:57 -0400
In-Reply-To: <ada7idvfw0c.fsf@cisco.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, David Brownell <david-b@pacbell.net>


--=-PVlW/DD8BTDL2ypw2Hru
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> but the problem sparse sees is not that some paths take only one lock
> and some take two -- sparse is complaining that this function is
> returning without unlocking the locks that it takes.  Even if I change
> the function to something as simple as:
>=20
> 	static void mlx4_ib_lock_cqs(struct mlx4_ib_cq *send_cq, struct mlx4_ib_=
cq *recv_cq)
> 	{
> 		spin_lock_irq(&recv_cq->lock);
> 	}
>=20
> I still get
>=20
>     drivers/infiniband/hw/mlx4/qp.c:603:13: warning: context imbalance in=
 'mlx4_ib_lock_cqs' - wrong count at exitn

Oh. Well yes, you also have to annotate the function:

static void =EF=BB=BFmlx4_ib_lock_cqs(struct mlx4_ib_cq *send_cq, struct ml=
x4_ib_cq *recv_cq)
	__acquires(&recv_cq->lock) __acquires(&send_cq->lock)
{
	...
}

but we're still discussing whether the & should be in there or not. I'd
think right now is a bad time for you to be working on this unless you
want to help with how sparse should behave too.

johannes

--=-PVlW/DD8BTDL2ypw2Hru
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASCxUoaVg1VMiehFYAQLXwg/+LiE4kk01kIQX9Hn05sT6ZEIjm2ADpZVM
ngeN50RkeIwRvj87T79MuCJvdTJkRlQp8Be+FujKO4+7DGPjtaRUx8/bgmWSD36t
Jp/H0S7v3xLgQRj6WH6ke9Xpw5J+ow3a/soT+bV8TdUqqInHlw0TzZiDlITLR4do
X+MC2+3xN4YM652aH/a79tatxc2UIesKkf303DINKLXv6xATo4pQkGsHcQhLTulC
tI8dFTjMpOA+T9Hn1ZH59Zi/M0aJml/73XHi2HEkmPJqU2SzNXgmYZABRgpyJvWv
F5VLvNRG1t+ydUl6LY0mBjgn6EX2W1X/AE22u6FLf6emL1Gkz8Blpu7z7CWp6zXr
CwX59v59oz5YRJMqmfywmqp0rH9ahdiz/gIDDBeFmBMwOnBvIVJtITKHDmQZWZQt
7ubjsDrcKSTQ8nqh4LuJ6+9zmUpaoznuxWJHysQiU6Viz0lCWEZ9NJ0iIfBWwm9f
sVQR/EGm3EZVUdqr38A0iZyQQgwFuVvCpHrb0xteIwWtaOtZF1KlrDrJ+1Q/g5T/
Nqi+j8WbAk6K40f/g//Vh6vZ0w5DgCDsA1dLZkB2UVX1NpZ76UBSx/aZqgse3iCA
Vwit35yvdeCvLuUf1/kdsnuZUoTrunpbQesUN+WmukuNnSOKFfeaM139bMmnBRG1
oElfChxZedQ=
=FdzP
-----END PGP SIGNATURE-----

--=-PVlW/DD8BTDL2ypw2Hru--

