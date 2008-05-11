From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: sparse context warning problem ...
Date: Sun, 11 May 2008 02:40:47 +0200
Message-ID: <1210466447.3646.3.camel@johannes.berg>
References: <200805101724.04014.david-b@pacbell.net>
	 (sfid-20080511_023054_226815_6D0BCE82)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LQfrsCUzywanKqEh5pKh"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:48972 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757396AbYEKAlF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 May 2008 20:41:05 -0400
In-Reply-To: <200805101724.04014.david-b@pacbell.net> (sfid-20080511_023054_226815_6D0BCE82)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-sparse@vger.kernel.org


--=-LQfrsCUzywanKqEh5pKh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-05-10 at 17:24 -0700, David Brownell wrote:
> I just noticed this with some obviously correct code... and verified
> that it's a regression in current GIT version of "sparse" since it
> now rejects code which previously passed just fine.
>=20
> The issue is a not-uncommon idiom, where a function must be called
> with a lock held, and briefly drops it.  The way this has previously
> been addressed, originally suggested by Linus and used in various
> places in the kernel (but, I observe, not in the "sparse" internal
> validation test cases) is:
>=20
>   static void
>   finish_urb(struct ohci_hcd *ohci, struct urb *urb, int status)
>   __releases(ohci->lock)
>   __acquires(ohci->lock)
>   {
> 	...
>   }
>=20
> But current versions of "sparse" complain (wrongly):
>=20
>   drivers/usb/host/ohci-q.c:66:2: warning: context imbalance in 'finish_u=
rb': __context__ statement expected different context
>   drivers/usb/host/ohci-q.c:66:2:    context '<noident>': wanted >=3D 0, =
got -1
>=20
> Presumably this is this a known bug ... is a fix on the way?
> (Meanwhile, I can just ignore this bogus output.)

This is probably my mistake.

However, I took __releases and __acquires to mean that this function
*changed* the context, doing both doesn't really make much sense. I
think the function should actually be declared

static void
finish_urb(...)
__requires(ohci->lock)
{...}

where __requires is (for sparse) defined as

#define __requires(x) __attribute__((context(x,1,1)))

It's probably possible to merge the __acquires and __releases into one
though.

johannes

--=-LQfrsCUzywanKqEh5pKh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASCZAjqVg1VMiehFYAQJHGQ//VW2NJWIrgeT9bI1NlCTU7GRSyJGEt5oG
ekuPPNMmzBwL08AwYRNVhGNxEPicn9AA6HXpdEX3Lnhqf4/ql65IYv1pKmT/Vija
2Eic6lEHV05TRwdnBZDE/t4E1WIzuhWVjjNglpSCl2OlWurkqSMtVH13kGTnIASw
Ik9Lufm793ROXaTCPsI44VbxU4AYjjVGAbzPNUMJJ2J4jTPy7J7nThhooVfwD2bm
qHk2qVK1gsyNPO9zm34Fb7hfu6vPO3aGTfSgfeZ5Bist6+N9a3hg6MV03LLhmabu
az1P2mbYapQYiiFJMfe9SUlaX5akS3jXDkPoQEAAs1v0j32cqqyqHzAOx8wL5xmG
Km0+aPGCs7K49NVDKPv6nuKWOZQ6JmycNrnr3QF0h11HmULrPjNUTFxd10gPH3qP
a2ln3RBkzEJ4D0DVnPeD3zZQjnayVdygzO74CPn+5F1NdQMXCH6zybMUHq79ZD0L
biK8p6m3cinnC0FBxkVQ52OQ5bwXNFnZeZo2CfqmxSQicdjkL+dmVoc3GfDafxc1
YSLEWHfAXa14eDYe5I3vwbrMRNsFmw2NppHKRmD+Yx/wg/rWe3y9m8VsKqBsSlbY
XKNyeZKbJouiIppKt6YGCPS2P4gwl1DjM3cMxG0oyqn+2MoQEJqb7SMBOVK/oeZT
lRrNf1ywSY0=
=jIQT
-----END PGP SIGNATURE-----

--=-LQfrsCUzywanKqEh5pKh--

