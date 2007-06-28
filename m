From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Wed, 27 Jun 2007 23:55:09 -0700
Message-ID: <46835B4D.1030008@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com> <20070628055850.GE21478@ftp.linux.org.uk> <46834FA0.8010201@freedesktop.org>  <46835471.4070000@garzik.org> <1183013061.32164.31.camel@dv> <46835989.5030805@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig498E2307D955878D82B8A57C"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:45209 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759272AbXF1GzM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:55:12 -0400
In-Reply-To: <46835989.5030805@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Pavel Roskin <proski@gnu.org>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig498E2307D955878D82B8A57C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Pavel Roskin wrote:
>> On Thu, 2007-06-28 at 02:25 -0400, Jeff Garzik wrote:
>>> Josh Triplett wrote:
>>>> While I agree that I'd like a better approach (specifically, I want =
any Sparse
>>>> build to support any target arch), I don't yet have a solution for t=
hat, and
>>>> this patch does at least seem like an improvement over the current h=
ardcoded
>>>> values.
>>> That's my desire as well:  My ideal sparse backend should be able to =

>>> compile x86, x86-64, ppc64, ia64, arm, etc. with just a change of=20
>>> command line switches.
>> That would probably mean having some runtime-loadable files describing=

>> the architectures,
>=20
> Runtime-loadable, or compiled in.  But in general... agreed.

Yes, I definitely want the ability to compile them in.

- Josh Triplett



--------------enig498E2307D955878D82B8A57C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg1tOGJuZRtD+evsRAo9jAJ9XwMt76mkwPcPfSyMXlgohvbTMKgCfQ1iB
KzpQmyJy7DQzEIorw8wA8i0=
=ggqd
-----END PGP SIGNATURE-----

--------------enig498E2307D955878D82B8A57C--
