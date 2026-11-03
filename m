Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748104;
	b=fOCvktYrgy0aO+LG7rZ2eyEc6dReUfVSqjqd3v+Xoit3aIWmDba3NZOV2Kg0B69iqCiT
	 6klGDmTWQjHJ5UlZnFxFu2aR21yUql5B8V16Luq5prvhaSumHUVkQyuCKLBMiqpUvo9BR
	 LZTv0X1mcMNBRXcYH2JKce9GJjZ5c1canAc+QkSNq8qmAYVb6Cv3JHdanzQUMJYUpG4de
	 HMiVMScdqnjmuV/vNPVlj8ghzohfCkp7sySNNF5RZ0LctHTFl7HKMADU8MsfPBhIl/eaB
	 rj4apMesR36Q+AfJqavwSTCPoWlpwOAo1S+1ObdDBjBQaG+6sAYEWkd29M1B+5z9XIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748104;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1BLBzDgyH4D0f7Nlpo8pZW2IwEta3qwghWOoH3Ds6Cc=;
	b=TqAfv0a3JFNDITYH2zPC4NY3thcaFefT1UzAQ5QFmyx2v4O5uzhhYfFGK0mKp+IfkpXO
	 Pb0t3WXfWyntRrFVYyf5VMOduKhW+DcQS5Z4LUqG+lpMIcogljEcr2G4Lbz5qdu+DWQBu
	 1ptaeJB/MBx0A7i43shFlZWkgIEcHnK0vOfLKskWtffivIjHIIau4xTlXLX3CkKw6REwa
	 xu145zyXlGWW4M/rbgkKVnQM8W3vuXEejL7azBS8atl/6A4ShVjTYgfKcGX3MANbWCRD4
	 UZmburq+kNTKuOoBlYX6VuTvre9hcOOgzBCAs0VRswRYR6Aha1cz1jJ+apm0kAw8ILw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYj8xxwJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F155606A31B;
	Tue,  3 Nov 2026 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYj8xxwJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823BF1F00919;
	Tue,  3 Nov 2026 23:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793748104;
	bh=1BLBzDgyH4D0f7Nlpo8pZW2IwEta3qwghWOoH3Ds6Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PYj8xxwJb91gicJm4gm1fLpxTfeGOHsa7btTMWJ8JZvODnqrZOMK2RfIQM45vswyT
	 Fm0yJKs4JVWZK+MgMlbkwtI8xkocRo1ysuwYChJLSqbGBXLUx/U2yT3Dn//jKPG5Ye
	 Xk5ImbQhvwp2mbmuB16t1wHu4rM1r/DXzctyP7SEOICHqkz9phuSZfXTE/04B0Ifpj
	 rvrWs9nCWUb6DAg+LzaWJnIPSzibubPF2PR14XZbTCkfEZBd3sI0dS6ZuXUIEccaAD
	 3ZuP5pFxlYfR5D+JMEJYbTgdDA+r4tUVsSgMQRXDulSvkSm5fe+//nf1+i6jqGmsY3
	 TRoy5+HZhJFzg==
Date: Wed, 4 Nov 2026 00:21:39 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Chris Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 0/2] Simplify implementation of strscpy()
Message-ID: <auprDNQJl90tLBrQ@devuan>
References: <cover.1793712214.git.alx@kernel.org>
 <auoxn2Pe10D4HPKm@ashevche-desk.local>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oi66qub5e35lwsy5"
Content-Disposition: inline
In-Reply-To: <auoxn2Pe10D4HPKm@ashevche-desk.local>


--oi66qub5e35lwsy5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Chris Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 0/2] Simplify implementation of strscpy()
Message-ID: <auprDNQJl90tLBrQ@devuan>
References: <cover.1793712214.git.alx@kernel.org>
 <auoxn2Pe10D4HPKm@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <auoxn2Pe10D4HPKm@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-03 21:10:23+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Tue, Nov 03, 2026 at 02:27:08PM +0100, Alejandro Colomar wrote:
> >=20
> > Here's a simpler implementation of the default arguments in strscpy(9).
> > It avoids having to build concatenated names, the ignored '...' in
> > __strscpy0, counting arguments, etc.  It's replaced by a quite simple
> > macro that takes two arguments, and picks the last non-empty one.
> >=20
> > It requires a C23 feature, but it's supported as a GNU extension in
> > GNU C11 mode, and was implemented a long time ago, so it should be fine.
>=20
> Yes and no.
> See 551d44200152 ("default_gfp(): avoid using the "newfangled" __VA_OPT__=
 trick")
> for the details.

Hmmmm, so sparse is a problem.  DEFARG() cannot be implemented with
##__VA_ARGS__ (I believe), so I think this is frozen until sparse is
improved to add support for __VA_OPT__.

The implementation in that commit you pointed takes advantage of the
fact that the default value is hard-coded in the macro, and the macro
has zero fixed parameters, which makes it work, but if you add one fixed
parameter (which we need for a generic DEFARG() macro), then it doesn't
work.  GCC's ## is quite limited compared to __VA_OPT__().

I've CCed the sparse matinainer and mailing list.  Let's see if they can
add support for __VA_OPT__().

> So far NAK from me.

Makes sense.  Thanks for the review!


Have a lovely night!
Alex

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--oi66qub5e35lwsy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrqbH0ACgkQ64mZXMKQ
wqkllw/+MNLFZy2UY09IjzXaCkcbHoGv9kywCSe8aJVa7WVh33CZtBb4cZQ2LwbH
hoJV7PWzfZZVR6xn7/l6igHw3T/d8IE7dO0EPj8iMdiUr5gRaBONZPo/H9Cz7aNa
C710oEaUDYVzYyt3+dMkFE3YPNuwQKqDrY7uxUOZVYENc/o4Nck57MMdknWA+wU1
e7N4lzoWp+xelXPKpW7HE2D/D1IUOc6lkicka/QNkk9PhzofUMKxj8+MUFJth480
tAi3D5VAkQV6vypgGawZP/BHHQDxgaExzGbUK2mkTH9PhrzqmLPr3AzA+4sFzD9Y
7Yg68UT/ZJhbD571HfnW/MxqpOIHZscKZd2c0pDDnO0KWSCAiw8OAoOLx+GizGen
SpkZokhOiLg9AN9ySPHGyYFzlUsOnzJZTXx0Lk/8IEpodhc6sFsTK7EcE0Tg0g1I
Ic1/ZoiuDzJQUwj42jVFQMbz+no1EduHY1lo/43nNU6RQFU7yL0tDSH7sFAPMnDw
qsBymtD0UhHPZ/Ltqt2JzZJg5LFaFgFdsgDMuOX4WAKr+niRTv9P3cEn55aqqroE
gMwdkpwkCt1aLCalkujcjnxeWnfcyu++CFjdyCKJqlPnvzt4LE1qVVYx5wLTwZ30
FkwhxIlQYy0JtJVZFRJYxvAsWoOSfyq9pFMUmMqRBFPtNspA4nQ=
=/std
-----END PGP SIGNATURE-----

--oi66qub5e35lwsy5--
