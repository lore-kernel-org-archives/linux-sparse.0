From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 11:02:55 -0700
Message-ID: <4676C8CF.6020201@freedesktop.org>
References: <20070618101929.GE21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706181002590.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9532DA3DA8CC3C138F622D99"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:58005 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764776AbXFRSDh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 14:03:37 -0400
In-Reply-To: <alpine.LFD.0.98.0706181002590.14121@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9532DA3DA8CC3C138F622D99
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> On Mon, 18 Jun 2007, Al Viro wrote:
>> 	Current tree handling of initializers is rather incomplete
>> and in many cases broken.  Patchset rewrites that stuff pretty much
>> from scratch; AFAICS it works.
>=20
> Josh - you may already be aware of it, but I thought I'd point it out=20
> anyway: when Al Viro sends me a patch (or set of patches), I personally=
=20
> just realize that a superior intellect has contacted me, told me I'm=20
> wrong, and given me the keys to fix it.
>=20
> IOW, Al's patches tend to be a good point to just say "Oh, ok, I was a =

> moron for ever writing anything else, thank you for not pointing it out=
=20
> any more impolitely and not chewing my head off", and then just applyin=
g=20
> or pulling them.
>=20
> Which is not to say that I've never gotten a patch without a bug in it =

> from Al, but I've never seen Al do something that wasn't fundamentally =
the=20
> "Right Thing(tm)" to do.
>=20
> IOW, Al is one of those few people where I can just close my eyes and s=
ay=20
> "yup, I'll apply it" without even bothering to look at the patch.

Yeah, I've observed the same thing from activity in both the kernel commu=
nity
and the Sparse community.  I still look at the patches, but primarily so =
I
can understand them and learn something from them, not because I expect t=
o
find anything wrong. :)

- Josh Triplett


--------------enig9532DA3DA8CC3C138F622D99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGdsjfGJuZRtD+evsRArqpAJoDblSma9P1Ygp4m087x1IGRF0GDwCcCBXE
ngpjVx2jhhNt+I2gm3PPQ40=
=eQrW
-----END PGP SIGNATURE-----

--------------enig9532DA3DA8CC3C138F622D99--
