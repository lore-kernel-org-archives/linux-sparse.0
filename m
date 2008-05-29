From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/9] context tracking updates
Date: Fri, 30 May 2008 00:54:05 +0200
Message-ID: <1212101645.10109.7.camel@johannes.berg>
References: <20080529085402.814224000@sipsolutions.net>
	 <1212100516.28403.152.camel@brick>
	 (sfid-20080530_003519_648056_2583259D)  <1212101102.10109.5.camel@johannes.berg>
	 <1212101465.28403.156.camel@brick> (sfid-20080530_005109_203270_E4619B0E)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a0QGFiH5ZzVcMMy+7kek"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:37810 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYE2WzV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 18:55:21 -0400
In-Reply-To: <1212101465.28403.156.camel@brick> (sfid-20080530_005109_203270_E4619B0E)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org


--=-a0QGFiH5ZzVcMMy+7kek
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > What sort? Right now, it seems to go into a dead loop on
> > fs/minix/itree_v1.c for me?!
> >=20
>=20
> It's a problem introduced with 9/9 explicitly checking inlines.

Cool, thanks, I'm just looking at it.

johannes

--=-a0QGFiH5ZzVcMMy+7kek
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASD80C6Vg1VMiehFYAQLTbxAAn6tH+icJsewjX4DRXt914DFQsEaJatM9
lhENJHFC9by1as7SgeScFQs6qNaAXFecqOCh0JCtp3epSsklhmxlTPci9pyuwvsw
nCX7J0lrbu/TsxroMdU/+L3nc7n/jpjXOnRhHxcl6KSU+A3aKywyfu/pGfLyklTp
7ZUPOhV3JTgWmK/yRwWzu3NUdXWdk4RNPGhZ8Zz04638B2Y2a5wtJ0op/txknIrk
eU8j3CcTCZx9sq5e6j755lOkDiPedIbnTBIpyG1bj5o3gfLJk3xka5yvcTjTnmOT
nZmf42DoPscv3+568WI7XYSZXUG1qp6FnWiqlqO4gBqrLZ4J66dO5Zk/A6Lo/8zT
DKqAsXaQ6ZpgruViAwPqJB4pzKWIjUs2syZHXKj+y7m9q4+tZuOFbMPa19U4DG1S
E2T3jJbCFfXfbh/7tjidUcCuL2N6PFdVZe08YnDZtih2eMK0ry5ejH20PhHLQtGe
bVpp1FQbCc1XxOCdQcTFa5HLCGqvcIh9sqnL210jvRJvvFkzVI5n35UDe1sDpfDW
wXoNpQg9qXhmyxFnQNpw54TM1rO3oBoFSanji0LGleGswfDOJTrtxzkPkfJEAfh4
B8ghyhFEgdzGa/31/7+wu2FukI6ocDjTalvfU+EhTaWv0vxQswYdJmtpxFq/5fMM
KkklYqqHkR0=
=NMVE
-----END PGP SIGNATURE-----

--=-a0QGFiH5ZzVcMMy+7kek--

