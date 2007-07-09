From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] make size_t better approximate the reality
Date: Sun, 08 Jul 2007 19:24:17 -0700
Message-ID: <46919C51.1080903@freedesktop.org>
References: <20070701074953.GC1101@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBAF72CB34D0EBDE062C83886"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:44603 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872AbXGICYd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Jul 2007 22:24:33 -0400
In-Reply-To: <20070701074953.GC1101@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBAF72CB34D0EBDE062C83886
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> Instead of "always unsigned long" go for "unsigned int unless
> -m64 is given, unsigned long otherwise".  Add an option (-msize-long)
> forcing to unsigned long regardless.  Make __SIZE_TYPE__ expansion
> match that.
>=20
> The thing is, addition of checks on comparisons make for very unhappy
> min() on (kernel) size_t and sizeof(something) on the targets where
> the former is unsigned int.  Which is to say, more than half of them...=

> AFAICS, the only place needing explicit -msize-long in CHECK_FLAGS
> is s390 (it's using unsigned long both for 31- and 64-bit).

Seems reasonable.  One comment, though:

> @@ -599,7 +604,10 @@ void create_builtin_stream(void)
>  	// it is "long unsigned int".  In either case we can probably
>  	// get away with this.  We need the #weak_define as cgcc will define
>  	// the right __SIZE_TYPE__.
> -	add_pre_buffer("#weak_define __SIZE_TYPE__ long unsigned int\n");
> +	if (size_t_ctype =3D=3D &ulong_ctype)
> +		add_pre_buffer("#weak_define __SIZE_TYPE__ long unsigned int\n");
> +	else
> +		add_pre_buffer("#weak_define __SIZE_TYPE__ unsigned int\n");

I think the comment above this needs updating for this change, as it desc=
ribes
the situation created by the code you've removed, not the new situation.
Perhaps the comment should just go away?

In any case, I've applied the patch anyway.

- Josh Triplett



--------------enigBAF72CB34D0EBDE062C83886
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkZxRGJuZRtD+evsRArN+AJ9MTz7S2tYJwWh74vx+N4KV6M5IIgCeLJF7
HSNM9zVofyi7dO43PYhKW+4=
=dI8e
-----END PGP SIGNATURE-----

--------------enigBAF72CB34D0EBDE062C83886--
