From: Josh Triplett <josh@kernel.org>
Subject: Re: Sparse and the Google Summer of Code 2008
Date: Tue, 11 Mar 2008 11:20:47 -0700
Message-ID: <47D6CD7F.6010800@kernel.org>
References: <f19298770803111038o3655a216vfe5a4b46876e7218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig40E6901E44CEFABE00CC4372"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:52640 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYCKS12 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Mar 2008 14:27:28 -0400
In-Reply-To: <f19298770803111038o3655a216vfe5a4b46876e7218@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40E6901E44CEFABE00CC4372
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alexey Zaytsev wrote:
> Is sparse going to participate in this year's soc?
> I e-mailed Josh a day or two ago, but got no answer,
> and the org application deadline is May 12, 12:00 PDT.
>=20
> I know, last year was not all that successful, but maybe
> there will be more applications this year. I've got some
> ideas about abstract interpretation for one. I can't promise
> that I'll choose sparse, there should be lots of interesting
> projects this year, but there are other people as well.

At least one other person has asked about Sparse and SoC, which
suggests that some interest exists.  I'll work on getting the
org forms filled out today.

If anyone else on the Sparse list has an interest in mentoring, please
let me know as soon as possible.

For anyone thinking about project ideas, I'd like to make two general
recommendations:

* Have specific goals, rather than just "improve support for $FOO".

* Release early, release often.  Please get comfortable with the idea
  of releasing your work to the Sparse mailing list, regardless of the
  current state of that work.

Regarding specific project ideas, I would have a particularly strong
interest in projects related to improved context checking (including
via abstract interpretation or similar), projects to make it easier to
add new checks to Sparse or maintain the existing checks, or projects
attempting to port C test suites (such as GCC's) to Sparse.

(In that last case, many tests will not apply due to the lack of code
generation, but if you want to write a code eneration backend do feel
free. :)  Also, many tests would still not apply due to lack of
specific optimizations.)

- Josh Triplett


--------------enig40E6901E44CEFABE00CC4372
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH1s1/GJuZRtD+evsRAoDQAJ0ZC+yRj6H77pb+G4XkjYNS2dDK3gCfaENT
Jp9g8aiF5b+W15e06zUPihI=
=WBaP
-----END PGP SIGNATURE-----

--------------enig40E6901E44CEFABE00CC4372--
