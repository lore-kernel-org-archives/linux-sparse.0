From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 0/5] keyword driven parsing
Date: Fri, 09 Mar 2007 15:29:32 -0800
Message-ID: <45F1EDDC.800@freedesktop.org>
References: <20070307100109.GA10577@chrisli.org> <45EFB34B.6030101@freedesktop.org> <20070308085925.GA19829@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD417D9E64282C09F2D4120E5"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:36192 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767643AbXCIXaA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Mar 2007 18:30:00 -0500
In-Reply-To: <20070308085925.GA19829@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD417D9E64282C09F2D4120E5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Wed, Mar 07, 2007 at 10:55:07PM -0800, Josh Triplett wrote:
>> Christopher Li wrote:
>>
>> Beautiful!  Looks far more elegant and maintainable; thanks.
>>
>> I've applied the first four patches in this series.  The fifth causes =
a
>> regression in validation/context.c; see the attached diff of the outpu=
t from
>> the fourth to the fifth patches.
>=20
> Hah. I misunderstand the syntax of context with only two arguments.
> This syntax sucks. The meaning of the each argument depends on the tota=
l
> number of arguments.

Guilty. :) I had to keep the two-argument version for backward compatibil=
ity,
but I still wanted what I considered a more intuitive argument order for =
the
new three-argument version.  Think of the two-argument version as depreca=
ted.

> The patch is updated.
>
> Chris
>=20
> Introduce keyword driven attribute parsing
>=20
> Now we are really parsing the attribute rather than building the
> expression tree first.
>=20
> Signed-Off-By: Christopher Li <sparse@chrisli.org>

Thanks, applied.

- Josh Triplett


--------------enigD417D9E64282C09F2D4120E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF8e3kGJuZRtD+evsRAqqiAJ9lR+t6uOfLqimT2wGD4lk/Y1VQ6wCgjAHZ
rT/BRMy6SSUGvXL5wJcjzko=
=cFlY
-----END PGP SIGNATURE-----

--------------enigD417D9E64282C09F2D4120E5--
