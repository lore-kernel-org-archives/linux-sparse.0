From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Wed, 6 Oct 2010 01:38:02 -0400
Message-ID: <201010060138.04508.vapier@gentoo.org>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org> <201010052134.42915.vapier@gentoo.org> <AANLkTi=_MVVqr_hBx9GbhB5pmJWznakp8bmUXggfZAOi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1673841.SLxWo6Zo0n";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:59390 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974Ab0JFFjW (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Oct 2010 01:39:22 -0400
In-Reply-To: <AANLkTi=_MVVqr_hBx9GbhB5pmJWznakp8bmUXggfZAOi@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, michael.hennerich@analog.com

--nextPart1673841.SLxWo6Zo0n
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 05, 2010 22:33:21 Christopher Li wrote:
> On Tue, Oct 5, 2010 at 6:34 PM, Mike Frysinger wrote:
> >> I wonder, does it make sense to support these kinds of
> >> architecture-specific builtins on all architectures, rather than
> >> limiting them based on some specified target architecture?
> >>=20
> >> Since Sparse doesn't generate code, it can easily target all
> >> architectures simultaneously, but that doesn't mean we couldn't tell it
> >> what architecture to target.  Sparse could default to targeting the
> >> host architecture, which would avoid the need to pass extra flags in t=
he
> >> common case.
> >=20
> > it does sound like it'd be useful to add an arch command line option.
> >  but i hoped we could sneak in the Blackfin stuff first since other
> > arches (like alpha) have been whitelisted.
>=20
> Can we have some "ifdef" for the blackfin architecture in the pre buffer?
> I agree with Josh, that do look like very much blackfin specific. We can
> leave the ignore attribute alone for now.

how would #ifdefs help ?  i'm not building sparse for a Blackfin arch, host=
 or=20
target wise.  if there's something more, you'd have to be specific as to wh=
at=20
you mean, otherwise i wont be able to send an updated patch.

yes, these things are completely Blackfin specific, but i dont see how that=
's=20
a barrier for entry when both attributes and the builtin ignore lists conta=
in=20
completely architecture specific stuff without any #ifdef logic.  using spa=
rse=20
on the Linux kernel for the Blackfin port is pretty useless atm because of=
=20
these missing pieces.
=2Dmike

--nextPart1673841.SLxWo6Zo0n
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMrAs8AAoJEEFjO5/oN/WBNPwP/j4mMoKlG+Ri5R5pBO/iUEog
t1TmKfRycFbPzLlH5hncn4zCd27oeOAriYiiN4Qr/ZDvlpHCGz18mdYyWifO0xfF
HdtIdTKIe89zQD5nLWgVZfmG8tocpOx8kJezSUeH9KUEfQ0lL4hSrLjkl5faR3v3
qP+XmKG3qZHD1ETK1kD8DAHFNJzu1txgiLUlqc+Y809aK5BgjLaWOaUXQJKk7Nox
Asg+O5r855fqLZsKjr/b4yGa/zSqTvQ1EDqqqjZg13HP+/OZXWenCHigrpNd9y2p
DLWXRMnge+9CMBiipZWnWJqw/pPWOO+GUTbDX2jRNbcvcihOz/vADXdI+KYneS/C
QJLEZsdSjqr8oFQOHgTPBDB06GNQOEL7p5Bv5pYXKJxry4s3pzZquDHImazSZvwF
OtgAAd0VpJiB3l7Q1sxYQkhxpqqxhWJNaMkn+bdtPXbbtfjcOcW23RqLa/2fgIpD
6pn5gQE2S2FwtYeAZKtcnqTPY2R6iFY5erqlkdYBkb0h3smuoE8yRlxDqm1giEpN
PUCC54kGaPl9+YdU2bJB6PBe5Fv6tz62Hy0Rl8b7xNrlC5pma2HpKKDYImBUEWv2
pV0MgnpVhIO+RDJdWZZULXsAFNVzOSqeynW2/xOoZN8OJ9W/+laioWXp49ke6ktf
HoF4mVs/CyNDeIKh6NJv
=oK0g
-----END PGP SIGNATURE-----

--nextPart1673841.SLxWo6Zo0n--
