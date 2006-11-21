From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Debian package; trivial fixes
Date: Tue, 21 Nov 2006 09:08:42 -0800
Message-ID: <4563329A.9060801@freedesktop.org>
References: <20061109151912.GC8508@bee.dooz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF37251B830AA630D0A2403F2"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:56233 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1031109AbWKURIp (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Nov 2006 12:08:45 -0500
In-Reply-To: <20061109151912.GC8508@bee.dooz.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?B?TG/Dr2MgTWluaWVy?= <lool+kernel@via.ecp.fr>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF37251B830AA630D0A2403F2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Lo=C3=AFc Minier wrote:
>  It would also be more convenient to create BINDIR automatically on mak=
e
>  install.
[...]
> -bin-dir:
> -	@if ! test -d $(BINDIR); then \
> -		echo "No '$(BINDIR)' directory to install in"; \
> -		echo "Please create it and add it to your PATH"; \
> -		exit 1; \
> -	fi
> -
>  .PHONY: bin-dir

The .PHONY line for bin-dir should go away too.

- Josh Triplett



--------------enigF37251B830AA630D0A2403F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYzKaGJuZRtD+evsRAgRHAKCm+CmsETrJlv1EGfuuR3Fn+5Mk3gCeKNTp
M7N5DS4gsDFX+b1Wq87KlbU=
=Eu6k
-----END PGP SIGNATURE-----

--------------enigF37251B830AA630D0A2403F2--
