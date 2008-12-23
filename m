From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Casting away noderef and address spaces?
Date: Tue, 23 Dec 2008 01:37:50 +0100
Message-ID: <1229992670.11628.4.camel@johannes>
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
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zmHeH2HI7OKeS8+Z5hm8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:42654 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbYLWAhz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 19:37:55 -0500
In-Reply-To: <f19298770812221620s7ef34b9co55f1650220750b38@mail.gmail.com> (sfid-20081223_012101_731914_21A61EE4)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>


--=-zmHeH2HI7OKeS8+Z5hm8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-23 at 03:20 +0300, Alexey Zaytsev wrote:

> By the way, are you sure the latest series you have sent is correct? To m=
e it
> seems that it does not make any warnings go away, and adds quite some mor=
e:
> http://zaytsev.su/tmp/build.diff.txt

include/net/sch_generic.h:225:2: warning: label 'continue' already bound

This, of course, shouldn't happen. I thought I'd fixed it, but who
knows. I think it should all just be reverted :)

johannes

--=-zmHeH2HI7OKeS8+Z5hm8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJUDLZAAoJEKVg1VMiehFYV5UQAIJhenCW4SqhUwJabrw6cQzO
axRdB5TWlzFmV8Pgd3PDAafECMRCmxz0RLun5d+k1mfUjozmXDOqOICGICxl6K0q
54Sy7uBMf1q/BCTQ/SjHPu28QhhD86VOZHOriPqXp9ORTnHRZUsFSsWDSyJCJhaB
VpL67ZavlItcOuDNRatWEY5uw/F8DoAJNVmVOh/XOx6Ae/PtBW2JnOlVj4GWNGos
Lebpx9nGJUVjoNr+QNO1t/PjIRembcXWgAHE43ibTZQCccwF/G3+OqZxIrrqST3v
H6vw2qFeR4jr4B0Q9in2ChV6XDjrCWCKljxrn42SHbfSC/T2vjDYTAO/3+W6YkgH
3vreSe/U26I3SU/WmZE/h77HT1b0+xiOaHQH9zXDVuniTcR4YhalDhL8sYeOCPeR
ZMRT54KeOTLgCt6M3v0Lj3Ewex+ai270T47Qkv+x/UO9NDwjjd055Q3OsMRfB1oO
VL31X/UxlsAvKj1yUQnsETUCk/ncQ6qcSuDaaZow64m8+cXCak0s7Ti8m8Ye5VDM
Q/5JznHzRXmdddUM4wYgMunds2aHesd0SFbhl0/E4ZYYIysUAen8kOEXFGBLWMQH
uHM6bCIoKqm5p8+JV7KWkE+ihDfAC1HBDYaMq8/+ql0KM+fOyHRd+UkbA+NQZwyz
m/wvww29RQXQDVvHak/M
=JToB
-----END PGP SIGNATURE-----

--=-zmHeH2HI7OKeS8+Z5hm8--

