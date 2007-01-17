From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 4] Update usage chain for dead instruction
Date: Tue, 16 Jan 2007 21:20:14 -0800
Message-ID: <45ADB20E.60002@freedesktop.org>
References: <20070117023717.GD962@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig150BFF8398D2B2AF37D85E2D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:54522 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbXAQFUR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Jan 2007 00:20:17 -0500
In-Reply-To: <20070117023717.GD962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig150BFF8398D2B2AF37D85E2D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> This patch address some of the dead instruction
> left in the usage chain.

Merged.

One minor style note:

> --- sparse.orig/simplify.c	2006-12-21 14:35:18.000000000 -0800
> +++ sparse/simplify.c	2006-12-21 14:35:55.000000000 -0800
> @@ -217,6 +217,11 @@ void kill_instruction(struct instruction
>  		kill_use(&insn->src2);
>  		kill_use(&insn->src3);
>  		return;
> +	case OP_BR:
> +		insn->bb =3D NULL;
> +		repeat_phase |=3D REPEAT_CSE;
> +		if (insn->cond)
> +			kill_use(&insn->cond);
>  	}
>  }

Despite redundancy, please include return or break statements in the last=
 case
of a switch, to make modifications less error-prone.

- Josh Triplett


--------------enig150BFF8398D2B2AF37D85E2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrbIOGJuZRtD+evsRAuDAAJ9BQ8FjN7hC4LJg6pkBYNC6yR4g4wCfQ1Cl
WUJlJNp9GzzqbYlmeQGoawY=
=5x0m
-----END PGP SIGNATURE-----

--------------enig150BFF8398D2B2AF37D85E2D--
