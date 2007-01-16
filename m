From: Josh Triplett <josh@freedesktop.org>
Subject: Re: How do I get the latest sparse?
Date: Tue, 16 Jan 2007 04:14:21 -0800
Message-ID: <45ACC19D.2080508@freedesktop.org>
References: <20070115165947.f2d4af01.rdunlap@xenotime.net> <AKEOJDDJLNPHDAKOMMBHCEGJCPAA.mshah@teja.com> <20070115181515.a2573235.rdunlap@xenotime.net> <20070116031637.GA18993@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig192A9FF314D70B732E6B9C9C"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:33148 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbXAPMVF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 07:21:05 -0500
In-Reply-To: <20070116031637.GA18993@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Mitesh Shah <mshah@teja.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, davej@codemonkey.org.uk

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig192A9FF314D70B732E6B9C9C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dave Jones wrote:
> On Mon, Jan 15, 2007 at 06:15:15PM -0800, Randy Dunlap wrote:
>  > On Mon, 15 Jan 2007 17:07:10 -0800 Mitesh Shah wrote:
>  >=20
>  > > > http://www.codemonkey.org.uk/projects/git-snapshots/sparse/ says=
:
>  > > >
>  > > > [ ]	sparse-2007-01-10.tar.gz	10-Jan-2007 23:01 	169K
>  > > > [ ]	sparse-2007-01-11.tar.gz	11-Jan-2007 23:01 	169K
>  > > > [ ]	sparse-2007-01-12.tar.gz	12-Jan-2007 23:01 	169K
>  > > > [ ]	sparse-2007-01-13.tar.gz	13-Jan-2007 23:00 	169K
>  > > > [ ]	sparse-2007-01-14.tar.gz	14-Jan-2007 23:00 	169K
>  > > > [ ]	sparse-2007-01-15.tar.gz	15-Jan-2007 23:01 	169K
>  > > > [ ]	sparse-2007-01-16.tar.gz	16-Jan-2007 00:01 	169K
>  > > > [ ]	sparse-latest.tar.gz		16-Jan-2007 00:01 	169K
>  > > >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  > > >
>  > > > ---
>  > > > ~Randy
>  > > >
>  > >=20
>  > > Yes, but if you unzip and untar that file, you will see that the s=
ources
>  > > are not updated since Nov 6, 2006. So my guess is that the tar is =
being
>  > > built everyday but the checkout is not happening from the correct =
source
>  > > repository.
>  >=20
>  > Oh, OK, thanks.  We'll let the codemonkey know.  :)
>=20
> Odd. It's doing a clone of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/josh/sparse.git
> I'll poke at it some more when I get back from LCA, latency to that
> box is pretty awful from here.

I just checked, and the snapshots appear to have current bits from git,
definitely newer than November 6.

- Josh Triplett


--------------enig192A9FF314D70B732E6B9C9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrMGdGJuZRtD+evsRAiMAAJ9CLWEpsZ9xX10bupf8M3e4z00arQCaAmwH
DM7bF5DTUMGyXpuCOCDeLRk=
=ENfU
-----END PGP SIGNATURE-----

--------------enig192A9FF314D70B732E6B9C9C--
