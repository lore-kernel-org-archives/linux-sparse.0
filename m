From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: Bug#873508: sparse test failures on ppc32le (and other not so
 common archs)
Date: Thu, 21 Sep 2017 20:58:23 +0200
Message-ID: <20170921185823.5fnxchdowq5krxy3@taurus.defre.kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com>
 <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
 <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3us2cpllse3iam2r"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:52155 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751773AbdIUS60 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 21 Sep 2017 14:58:26 -0400
Content-Disposition: inline
In-Reply-To: <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--3us2cpllse3iam2r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Control: clone 873508 -1
Control: retitle -1 Please use cgcc to check hosted C code instead of sparse
Control: severity -1 normal
Control: reassign -1 horst

On Fri, Sep 01, 2017 at 09:46:44AM +0200, Uwe Kleine-K=F6nig wrote:
> @anarcat: Given that cgcc seems to work, would you agree to apply the
> following patch to horst:
>=20
> diff --git a/Makefile b/Makefile
> index 4f924fa..d563652 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -110,7 +110,7 @@ $(NAME): $(OBJS)
>  $(OBJS): .buildflags
> =20
>  check:
> -	sparse $(CFLAGS) *.[ch]
> +	cgcc -no-compile $(CFLAGS) *.[ch]
> =20
>  clean:
>  	-rm -f *.o radiotap/*.o *~
>=20

In the meantime I learned from upstream that sparse is not expected to
grok arbitrary hosted code. For that it is needed to use the cgcc
wrapper to handle the required cpp symbols. That it works on some
architectures with plain sparse is mostly luck.

I still expect some platforms to fail with the wrapper, too, because
cgcc doesn't know about all platforms yet. But I intend to upload a new
sparse package soon that includes a build time check for that, and the
respective fixes are easy.

> and downgrade the bug to "important"? That would be a compromise that
> buys us a bit of time.

I'd say sparse failing on hosted code isn't "important", but cgcc should
have all necessary definitions for Debian platforms. So I'm keeping this
bug at important and intend to close it once all platforms are known to
it.

Best regards
Uwe

--3us2cpllse3iam2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnEC8sACgkQwfwUeK3K
7Algrgf+NdflGLzJ2yt74LlEtKUJoSUJnBUm7HuZZXHUQ2AO4DqC7ZO0WvkIwv4j
soZVe5RCwmR97h4d1I2r0kEYqtVuM1qXW6uQgUXR/gRBsrYee0LfzhqlWMZ8y8Gk
96foK+f//z45pJVPGyL5leaX7UJmBZXrSvpAy6RG+FQJwQV6TwuONcS+1y0MG4j+
8dFRk1rLfhLVUBP0hC4naU3zfr5suJiL0t5DxzSqnLCSNz0NKC0gv7hdEfzkRhJH
jAQeSx97HyqkLJ89F39Bv36T8ZZS5PmPfX+plKmnlty9r1uD/M/uVUG4jiOY/jso
uqBVSe49SnOVVwOw6BWtrJo51bBQDw==
=8JvN
-----END PGP SIGNATURE-----

--3us2cpllse3iam2r--
