From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 0/5] Sparse on Cygwin (and git).
Date: Tue, 22 May 2007 16:44:43 -0700
Message-ID: <4653806B.1000901@freedesktop.org>
References: <46532ECD.2020502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8F6971FE1A14A5E57941EF6E"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:38351 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758337AbXEVXpZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 19:45:25 -0400
In-Reply-To: <46532ECD.2020502@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F6971FE1A14A5E57941EF6E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ramsay Jones wrote:
> Since git uses sparse in it's "check" make target,

Cool; I didn't know that. :)

> I decided to download the
> (then current) 0.2 tar-ball and see what sparse was about.

Great!

> Unfortunately, at present,
> I am using cygwin on win32 until I get around to installing Linux. ;-)

Fortunately, that resulted in some excellent patches. :)

[...]
> As I am somewhat bandwidth challenged, until recently, I had never clon=
ed a
> git repository (not even the git repo). So, last week I cloned the spar=
se
> repository; thankfully it only took about ten minutes (yep a slow pipe!=
).

I think you'll find that keeping the git repo up-to-date requires quite a=
 bit
less bandwidth than the initial checkout.

> Thus, again I had to update the patch series.

In general, you'll probably run into conflicts if you try to generate pat=
ches
from the last release tarball, especially on frequently changed files lik=
e
ident-list.h and the attribute table.

> Patch 0003 overlapped a
> recent commit (baf2c5a8) by Michael Stefaniuc and patch 0004 required a=
n
> update due to handle_attributes() gaining a third parameter. So the fin=
al
> patch series is:
>=20
> 0001-Fix-an-__sentinel__-attribute-directive-ignored.patch
> 0002-Fix-some-enum-value-XXX-not-handled-in-switch-wa.patch
> 0003-Add-more-support-for-WIN32-attribute-names.patch
> 0004-Fix-an-__attribute__-parsing-error.patch
> 0005-Add-cygwin-support-to-cgcc.patch
>=20
> which was built on top of: 0.3-15-gb5bd30f

Looks like a good set of patches.  However, only patches 3 and 4 seem to =
have
hit the list.

- Josh Triplett



--------------enig8F6971FE1A14A5E57941EF6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU4BrGJuZRtD+evsRArnHAJ959Eb1+3211w1xuI2ilQzXONXONQCfTNVj
pTjAFJGCnwvcAmJFUrhkl2w=
=K3gl
-----END PGP SIGNATURE-----

--------------enig8F6971FE1A14A5E57941EF6E--
