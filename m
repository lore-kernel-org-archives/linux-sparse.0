From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Thu, 14 Sep 2017 22:17:42 +0200
Message-ID: <20170914201741.lmzdhwlbi2jo2pfw@taurus.defre.kleine-koenig.org>
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xnzr7voriuu43zod"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:48639 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751342AbdINURo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 Sep 2017 16:17:44 -0400
Content-Disposition: inline
In-Reply-To: <20170914200327.15129-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--xnzr7voriuu43zod
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 10:03:27PM +0200, Uwe Kleine-K=F6nig wrote:
> ---
>  cgcc | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/cgcc b/cgcc
> index a8d7b4f217fe..0ab54f943578 100755
> --- a/cgcc
> +++ b/cgcc
> @@ -235,6 +235,9 @@ sub add_specs {
>      } elsif ($spec eq 'linux') {
>  	return &add_specs ('unix') .
>  	    ' -D__linux__=3D1 -D__linux=3D1 -Dlinux=3Dlinux';
> +    } elsif ($spec eq 'gnu/kfreebsd') {
> +	return &add_specs ('unix') .
> +	    ' -D__FreeBSD_kernel__=3D1'
>      } elsif ($spec eq 'openbsd') {
>  	return &add_specs ('unix') .
>  	    ' -D__OpenBSD__=3D1';

Alternatively to adding support for all platforms by hand, why not
use the output of

	cpp -dM < /dev/null

to get the predefined macros? On my Linux amd64 box it gives quite a
list, but I think this doesn't hurt, does it?

Even

	cpp -m32 -dM < /dev/null

works to give the i368 predefined macros (though I didn't find that in
the cpp manual).

Best regards
Uwe

--xnzr7voriuu43zod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlm64+IACgkQwfwUeK3K
7AkFkAf/X7Q1xuGhjgNRo78zBcqJmcbObRKOkogOizjDOt5A0S2imo5eNjdz/SLr
uUxqs8Hm6O94HsO+QjkLXVHX5sbiWvAmtqyU7H5oTLxKTHX0JPApS+N2sRKpRrNM
ub+9jlghfAq2dsjn44U7RZPA6Cb3kPU4w8VOOdQ5cx2Q7jGk3r9CX/FJBOj5kkEw
QMWL+MXmjQuqQvnye8eh1runyO9OQV3rxixl0h4DIgH6s4Lavrhuboi6ISo0Tsr1
wJERT7fupGExUDXW2FafYXoGpFa9qoKbOUQehXHtXOyRn+CTuLBzdMiAkSnWtJKv
pWY0to0uOJEkzQT/IwiGwbw5HxnVMg==
=SKXt
-----END PGP SIGNATURE-----

--xnzr7voriuu43zod--
