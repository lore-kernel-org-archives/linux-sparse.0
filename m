From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Casting away noderef and address spaces?
Date: Tue, 23 Dec 2008 00:55:25 +0100
Message-ID: <1229990125.11628.0.camel@johannes>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
	 <20081222205750.GK28946@ZenIV.linux.org.uk>
	 <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
	 <20081222213953.GN28946@ZenIV.linux.org.uk>
	 <70318cbf0812221433y62197ec7y851f00fa5775f150@mail.gmail.com>
	 <20081222225708.GA4074@uranus.ravnborg.org>
	 <f19298770812221553n5281505ex611e8e6f6fa1f0c2@mail.gmail.com>
	 (sfid-20081223_005349_858840_91DB2CD5)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lvcnkKOnOn4bFgttTzj7"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:60744 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbYLVXzk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 18:55:40 -0500
In-Reply-To: <f19298770812221553n5281505ex611e8e6f6fa1f0c2@mail.gmail.com> (sfid-20081223_005349_858840_91DB2CD5)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>


--=-lvcnkKOnOn4bFgttTzj7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-23 at 02:53 +0300, Alexey Zaytsev wrote:

> The last time we spoke (yesterday) Josh was going to merge the patches re=
ally
> soon. The idea was to merge everything except the context patches, make a
> release, add the context patches, and wait for someone to fix them.

Make sure to revert those that are in the tree now though, before the
release.

johannes

--=-lvcnkKOnOn4bFgttTzj7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJUCjqAAoJEKVg1VMiehFYvt0P/158pMN68O2oUWFCdKBNeWFL
OKsXc579+HeYVfzG6s58PwuDSPhCgudGsy86QcjXQQUnm169BRuGsWYpXDbWASOI
3jPJCO0rHYCw3Zo4aH+bXJghFduaqZ5xjRiFUVdmC51JfY7zoUlo5ebv54OmU+zc
1UXvXD3F0LTN4a0XBiKHr2KFT7Dq14HXAEHCNab0NyDNi3KeM03i89fN43CcbQC1
33sBUO+ma06EbAyboxZeGAFOB30COtMZOBvW/91y0EizSNJ4LbPHYUSIWJZF4PfM
jinNjY9BJ4G1ZAUvIFc1M9PHwS2p4QnKAhVE9ZDFPFOx1szgLidThL8KK9uSBb92
NO+FQ1YZt1keG2vcXDtCldSQhiFt+c7K5bTyrtyH3fHAoJFyP+/8/tchlXxx6Xyd
J8BwPXDG516Yi4jOf1HdTyKCJMxIeJtcSpdl/UxhcZO9QvFjwUGU/w/Pk66as0Tu
qb0+Pcnk34305WelikTvzOmuhpOJ1XTWP2V+/NoMMMnRo2jSKsI4mylEpw7bY9km
/boKEqw5P8F60YFFRnuudKAaN4HXtaXnpYXDElV2R2vRT31Kdh3hQFRfX0MNyxno
RG+6xI6l8wJBFCGkuSlAp/0G4sY7vOuO73fqFoGUCcvY6xEzadt70sG7nDQNiWGl
uhPTXg6QzuQS55kJGSV5
=cQHN
-----END PGP SIGNATURE-----

--=-lvcnkKOnOn4bFgttTzj7--

