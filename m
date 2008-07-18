From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Context imbalance false positive
Date: Fri, 18 Jul 2008 10:25:25 +0200
Message-ID: <1216369525.27738.4.camel@johannes.berg>
References: <43e72e890807171652r133c973dh160ea28d361a4601@mail.gmail.com>
	 (sfid-20080718_015238_326183_A8E7DB76)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q8XlgAsHnCxpeCYAB+//"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:45298 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbYGRIZ2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Jul 2008 04:25:28 -0400
In-Reply-To: <43e72e890807171652r133c973dh160ea28d361a4601@mail.gmail.com> (sfid-20080718_015238_326183_A8E7DB76)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
Cc: linux-sparse@vger.kernel.org


--=-Q8XlgAsHnCxpeCYAB+//
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-17 at 16:52 -0700, Luis R. Rodriguez wrote:
> I'm not sure how to resolve a situation like this:

> static void lock(int bh_flag)
> {
>         if (bh_flag)
>                 spin_lock_bh(&some_lock);
>         else
>                 spin_lock(&some_lock);

The only generally accepted way is to not program locking dependent on
flags.

You can sneak in sparse annotations to do it anyway, but I won't tell
you how :)

johannes

--=-Q8XlgAsHnCxpeCYAB+//
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJIgFNvAAoJEKVg1VMiehFY+kAP/A/FgkyRFLBkrx0URLTSNLBa
/IEU+UawFdEsZDSSIdSZzZ0uD7kYONkTRDgIcvUHT8M7UN5UipxZ3jNH/1Urijzh
2JYY60S22AjGIBvl7vWe8w/CCAjguBifgWs6gJfI3ou0clunbMlodnJYga8NwuaN
I1vCDkONU+iXqS28cbVySG72SKyczEbG2CbzSYaD9v3Nvr0z41a85fES6S/dNQt5
XZ8/dDrtG8KzbZbBzMRDrJoBZMvZScPxQFYbZYuE47fA4/vNpbvjEquhYnV+EUGK
/kJMEB5xXj8mipqOSffqnPG1I9K68X6XR3BgOGioUNdX2Fj+BJdD70nNV64dRpMh
qI3lhZDwcHzib9LmfqHzqbPeafDK2rKll8dtdxprfue3d2Y/45OXm73UycYOK3lI
L2+v2URXAKp3TqSBPuQwy7Aib0w5dnlOOL4cldeU0U2lYa4XaF0xYJrQhquqlmrf
TNNBNiBStUoInUxtrwQkXp0lZ3dAn3BnuZVKWAU/Id3HKVNlxgsXw0Ir3SnGkUQ3
vBokt6h2M2Ewn7TBPeffuaMVI5sASW9sz89n1vpLajzsHxrH+Q0LA44nbOFKmQ4s
BXtKIk50McZmToSnD9z4pUA3jKxTrbwwwT2XXo8q3u2NOAd1Jg3CkqQ5Pl+BCfJC
Ia9mfZg2rxTau1+1R4wV
=kDYj
-----END PGP SIGNATURE-----

--=-Q8XlgAsHnCxpeCYAB+//--

