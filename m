From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Tue, 5 Oct 2010 21:34:41 -0400
Message-ID: <201010052134.42915.vapier@gentoo.org>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org> <20101005161829.GB1859@feather>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1570494.SSQOnzh4Eq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:35530 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab0JFBf5 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Oct 2010 21:35:57 -0400
In-Reply-To: <20101005161829.GB1859@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org, michael.hennerich@analog.com

--nextPart1570494.SSQOnzh4Eq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 05, 2010 12:18:30 Josh Triplett wrote:
> On Tue, Oct 05, 2010 at 04:34:30AM -0400, Mike Frysinger wrote:
> > The Blackfin port uses some custom attributes to control memory
> > placement, and it has some custom builtins.  So add the ones that the
> > kernel actually utilizes to avoid massive build errors with sparse.
>=20
> I wonder, does it make sense to support these kinds of
> architecture-specific builtins on all architectures, rather than
> limiting them based on some specified target architecture?
>=20
> Since Sparse doesn't generate code, it can easily target all
> architectures simultaneously, but that doesn't mean we couldn't tell it
> what architecture to target.  Sparse could default to targeting the
> host architecture, which would avoid the need to pass extra flags in the
> common case.

it does sound like it'd be useful to add an arch command line option.  but =
i=20
hoped we could sneak in the Blackfin stuff first since other arches (like=20
alpha) have been whitelisted.
=2Dmike

--nextPart1570494.SSQOnzh4Eq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMq9IyAAoJEEFjO5/oN/WBuBgQAJNstbxBNPl4jMU2p7C1NKCR
sb+iKuoyfidxMgqk/zvaIFVfaIqa1yEyZzoNdkPCWwDyAQF6ondSGpJwwMyue5b5
F8ZEdvcRm+bblOKVweNBMfWx+yg5R8G/HhwDOhImax2sojaDJMuYHKC8Gf7/Gpc2
zRpKGJOI6Jde+LMs+ELl+8Kx5RsTiURkAe2N1/7zmH9vLs2ghAunsq7QUKb+Kco/
giyyrscHT78YIK36GlC7Z4zxgfhjSHaxfWnqRgnPZkbQyGd8cVcwzwv+Uc5OicLL
YP89BWYenzGYtDKOWYhzCrCl/IMaHqknqw82ZwTvgeknzO59IpK8c3gxFrGKTTxY
A4lkQSATPgAEvcQM9UNvGyJH5WVS15ID/h9c+xRg8nFZWe6qPw5zP57n4xppZdK9
tn2p7PJTW6Pnbmw04pyBTv08u2TASNFCURQUx6YZ9wQuJb8but57u09SBa8vgkID
AYtKMj3X+jDk0cSavwOJg6vbjY42HehYoSRlUxmhxAV+aTsBcBfJ0ufaScfPHEVI
Cqe3YnUuKXjYIcPEtQ4AJZyPclL94GWdQrMIF9kHvcGAV29OWJ8K6ZrDzN/uUKtj
MBRkhLvXbEUOdYRciddjhpCf/7d2u8iainvN18T9Sg98uezqKVRTgMNqFFxfdo0G
5aTqP+bwRsvrSh9vNhkr
=a0kL
-----END PGP SIGNATURE-----

--nextPart1570494.SSQOnzh4Eq--
