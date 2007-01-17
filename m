From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Change the symbol access list to pseudo list
Date: Tue, 16 Jan 2007 20:43:48 -0800
Message-ID: <45ADA984.6060509@freedesktop.org>
References: <20070117023441.GB962@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC50E0216E8DD22F176526AF"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:35026 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbXAQEnu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 23:43:50 -0500
In-Reply-To: <20070117023441.GB962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC50E0216E8DD22F176526AF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> The pseudo list contain more information. It can
> get to the symbol as well as the usage information.
> Now it is much easier to answer the question like:
> "what function does this functions calls to."
>=20
> Signed-Off-By: Christopher Li <sparse@chrisli.org>

Good idea.  Merged.

- Josh Triplett



--------------enigBC50E0216E8DD22F176526AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFramEGJuZRtD+evsRAir1AKCzUZqo2rqWqg/5UTCpdOqjE+3WZwCgtDLA
+PY2S4pl6F8LzKhBHTTX/hg=
=aZsy
-----END PGP SIGNATURE-----

--------------enigBC50E0216E8DD22F176526AF--
