From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: Using c2xml on kernel sources
Date: Tue, 20 Mar 2012 13:37:02 +0300
Message-ID: <20120320103702.GN3163@mwanda>
References: <CABG-yt06Kw2uFnmrshcHYjgf_cMgzKVdMPe6BXOP2nryhRjBpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hD6P3ib1XCFtz2ni"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:24920 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab2CTKeb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 20 Mar 2012 06:34:31 -0400
Content-Disposition: inline
In-Reply-To: <CABG-yt06Kw2uFnmrshcHYjgf_cMgzKVdMPe6BXOP2nryhRjBpg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Shakthi Kannan <shakthimaan@gmail.com>
Cc: linux-sparse@vger.kernel.org


--hD6P3ib1XCFtz2ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2012 at 02:30:18PM +0530, Shakthi Kannan wrote:
> Hi,
>=20
> I would like to run c2xml on the Linux kernel sources. Is there a
> recommended way of using the tool on kernel code?
>=20
> I tried running it directly on a source file, but, get the
> 'header-file "unable to open" error.
>=20
>   $ c2xml linux-3.0.4/net/ethernet/eth.c
>=20

make C=3D2 CHECK=3D"c2xml > foo.xml" net/ethernet/eth.o


regards,
dan carpenter


--hD6P3ib1XCFtz2ni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaF3OAAoJEOnZkXI/YHqR89wP/ibK7O1W6R+4ltazfd3hDk5J
JFj6dniZ7V+W6W2FDpAm3vgOrDnx2DUXhH/5HSbMewBbj7MXlvVZcWWgvtYBeOdB
CHyu8julCSwY8eWgPiNbm0hVZuhA1LWIm003TI9hYbXJM5nijMWgrv17vV5kjRiX
QOf0XYxokjx/YfiokgRINrK7Wnkt5KkXX7uDToJ0y2dhuOXkW8CSnFhkx2Y+Eabi
ybNpFKWrnn5+CJnH5SWKEfUyn3N4f5l4NkHtOuYzua3BN0ED+OSL0HjnDNS6VgKu
LlB47pyMRmJnDvPEP7y9yS+kpL2VchInhuEAo31aTMgCuGyXxEqJZuceJmuJ6+ct
512G/KJzBzt1kKo6oFQEfBgfOpLcp0j1w6xPLpPIgABJYuHPFrOr5NepFwB33W6B
ChokPJ3cajTCFu1S1UFCGagq+3V4Ph/dLXZWSeCBcfxvNZKsqzrssobubuBtreMO
cSN3PF2rrqWBvJQ2SshOjgXkFZqNWrReHJAM8ziXVOJInQ+KtmwwaFKMZM1PeXT7
mvHTE30M4pZHTF18eh9zHhWB4b1XI2SAJzRUYKrYoPSxyiXFzWFPY3HnP8AiqbqA
v1VfoReScxu2F1JQdG7Z/FAg4REDBeKiLUL1dcmLOd2kBbB/6YbQf5SmrtwUmLzY
8kIhz/4TLrnFsIyNcAmG
=wiHv
-----END PGP SIGNATURE-----

--hD6P3ib1XCFtz2ni--
