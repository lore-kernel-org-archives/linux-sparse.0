From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Fix -E handling
Date: Wed, 13 Jun 2007 17:01:28 -0700
Message-ID: <46708558.7050009@freedesktop.org>
References: <20070612103702.GA5719@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig39DEE2919BD395D9C7ABF96D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:33448 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbXFNABm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Jun 2007 20:01:42 -0400
In-Reply-To: <20070612103702.GA5719@martell.zuzino.mipt.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39DEE2919BD395D9C7ABF96D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alexey Dobriyan wrote:
> sparse accepts -E[anything] as directive to preprocess only. On some mi=
ps
> targets -EL slips into command line resulting in 400-800M logs with
> preprocessing results :^) Accept '-E' only from now.

Applied, thanks.

- Josh Triplett



--------------enig39DEE2919BD395D9C7ABF96D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGcIVYGJuZRtD+evsRAuC5AJ0ZpZZ+LEMyM7fV+9m2CkeSzINz5gCdFxeJ
c+bjURtqqNN10I8I0svlZVI=
=8q9z
-----END PGP SIGNATURE-----

--------------enig39DEE2919BD395D9C7ABF96D--
