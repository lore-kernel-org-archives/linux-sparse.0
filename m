From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Casting away noderef and address spaces?
Date: Tue, 23 Dec 2008 01:35:06 +0100
Message-ID: <1229992507.11628.2.camel@johannes>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
	 <20081222205750.GK28946@ZenIV.linux.org.uk>
	 <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
	 <20081222213953.GN28946@ZenIV.linux.org.uk>
	 <70318cbf0812221433y62197ec7y851f00fa5775f150@mail.gmail.com>
	 <20081222225708.GA4074@uranus.ravnborg.org>
	 <f19298770812221553n5281505ex611e8e6f6fa1f0c2@mail.gmail.com>
	 <1229990125.11628.0.camel@johannes>
	 <f19298770812221620s7ef34b9co55f1650220750b38@mail.gmail.com>
	 (sfid-20081223_012101_731914_21A61EE4)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3GHpgsQWqPESx1PuNEHa"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:42566 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbYLWAfO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 19:35:14 -0500
In-Reply-To: <f19298770812221620s7ef34b9co55f1650220750b38@mail.gmail.com> (sfid-20081223_012101_731914_21A61EE4)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>


--=-3GHpgsQWqPESx1PuNEHa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-23 at 03:20 +0300, Alexey Zaytsev wrote:

> By the way, are you sure the latest series you have sent is correct? To m=
e it
> seems that it does not make any warnings go away, and adds quite some mor=
e:
> http://zaytsev.su/tmp/build.diff.txt

Yes, because the context name wasn't previously used it messes up in
places with that patch set... This was discussed a few times previously,
you should be able to find it on list archives.

johannes

--=-3GHpgsQWqPESx1PuNEHa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJUDI1AAoJEKVg1VMiehFYb2kQAJ8p60ZibstyJZGMz/ubeTIK
oVcus/pzi2bUlCx7KMjBNNX+fn2nuCbi7U6STPYwg6vjprBUAYZegJyWKUTuTe6v
8QH40405UmdsyJ++EyKtKALVnkvp0W1RqXehEQj/V/c5zEp0C8ddd0O4v2Sk922Z
nyguRHNzqnkhiGDORvfOZLE+eyIDKeR6iYD2RPp9l0gNEsPbzPDM4eyWKzpb0xCh
IumPmsgbo0EX786UOHnRgIaIBK75LX14UPn1PhTS+rqXm/TCIbXpYiDyy8+YteS+
N6a5ZDezTeKvQOwqQRU8P/m2vHRJ88l6QJX+YUmCCmRBpnebqjwafFW/h3LI6Bfo
zmYe1SP+8lBdQ/kmBAVksf97f969JmJAeSclqXJBP+7P1akcfWWcXCuDqoCbZGFb
HpA2EQki7X59mJkW/SD/8pV0l0cwa/Axz0NTpM/mzAEKWNVFRQs29vzeryPhvfkU
jszi1ul+THrRrZl3gNSWcylfrzuE+5SmbXLuhybrYdCClIFfd4n4AGD+Cq/T4aCc
SkCGuObKKI9dmuTwI0BilBcR+ii8ySKEwcwH16AWWSty/dZbYUSu3JnoqoT4JsHp
JvgbOwb3rlYFcBW3OjJEZBRjlJ8fCrn4/NzT/f0L3R/h/AC/NjRHfpmnEVxt69AG
kOEry2S4PuEVQ0qUb4r7
=Rwxs
-----END PGP SIGNATURE-----

--=-3GHpgsQWqPESx1PuNEHa--

