From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Thu, 10 Apr 2008 17:54:49 +0200
Message-ID: <1207842889.13354.15.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
	 <200804101724.27382.philipp.reisner@linbit.com>
	 <1207841454.13354.7.camel@johannes.berg>
	 <200804101746.14457.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QVF+I0oFPP7oba8YTSJi"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:42922 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556AbYDJPy5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 11:54:57 -0400
In-Reply-To: <200804101746.14457.philipp.reisner@linbit.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org


--=-QVF+I0oFPP7oba8YTSJi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> +# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)

> +#define try_inc_local() __cond_lock(local, _try_inc_local())
> +static int _try_inc_local(void)
> +{
> +	if (random() > RAND_MAX/2) {
> +		local_cnt++;
> +		return 1;
> +	}
> +	return 0;
> +}

That actually works? I guess it shows that I haven't slept enough while
working on this.

johannes

--=-QVF+I0oFPP7oba8YTSJi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/44SKVg1VMiehFYAQKhSg/7BErNaEn3qkhkalPE7bAZiFHm9Zn2AyNO
kd5WwUeBqv7OD/D5Tbxye47na3im74D6TzhAnI5sjc0MHUxK9rxmpuuFw8Kg+rCx
JQYbfBpJCLRePuqSRFtJiQ3LLFSDdqlEnPnOjXWy1zLm3XZ0gJ/b54z7BjcYgkjv
SQE0ZkftWGxHmGV8zZXlyKJ2BjCMTDKtji5NvFRq3fas1rnB33n2f3raInY4qPBL
SD7tKU6XPBAJP/rMGM0j0gFqDrHiy+O2IIroEzncg9BnK19RWetUl9VTtcVyv7hS
cytEnNJj5YGYn4jAVmdW+OOOIY+Hh5yXauOliC/4Yj2WwW+baLCIjAKUDjbtJhj5
w4yuYBsISD8vGV7ZE3WLSoH9+n39zYn/Bxar36CeVTTHM3LXer33ce6aC83v0NWH
lobGXsmINGjMp4o1XfNyCIT/aPY3NuhK2qvfIdAgVqUCN1w1BP93OjhgDGe7XVpI
XKsBRpMMzmf0j7JP49bW0AhBexXZRxMHsLVVqeGOIb4CM6nPlUVItEwavUQI0D68
JBr4+CdQm8aCq+5/xAPYKdTHD4XsmQaQBy7XIrl5CCKgCOQAmO5YrrRUhdd5xEuz
lQJUQHxpNQFBE7SrGfLiTFVwmflTkWW8VMFWsUdV3AZMAGhxPcjTqMZHlmuwPyAg
q0dW9kBWdl8=
=1pne
-----END PGP SIGNATURE-----

--=-QVF+I0oFPP7oba8YTSJi--

