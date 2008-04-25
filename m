From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] allow context attribute on variables
Date: Thu, 24 Apr 2008 19:22:17 -0700
Message-ID: <48114059.6090103@freedesktop.org>
References: <1208955351.31429.81.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAA4819DD60B5A335BC2F3818"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:37417 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbYDYCWO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 22:22:14 -0400
In-Reply-To: <1208955351.31429.81.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse <linux-sparse@vger.kernel.org>, Philipp Reisner <philipp.reisner@linbit.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA4819DD60B5A335BC2F3818
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Johannes Berg wrote:
> This patch makes it possible to add the context attribute on
> variables, to warn for example in this case:
>=20
>     struct something {
>         int x __attribute__((context(L,1,1)));
>     };
>=20
>     extern struct something *s;
>=20
>     static void warn_access13(void)
>     {
>         s->x =3D 7;
>     }
>=20
> This is achieved by translating the context attribute on
> variables that are loaded from/stored to into a context
> expression internally. A number of tests are included,
> including tests for a struct member (as above) and array
> accesses.
>=20
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> I didn't see any need for distinguishing between rd/wr nor
> for a new attribute, so I just used the one we already have.
>=20
> The exact_context() attribute is also allowed so we have the
> same max/no-max semantics as functions.
>=20
> If read/write is necessary to distinguish (I don't see a use
> case) then we can do that fairly easily later.

I like the idea of matching the existing attributes as closely as
possible.  However, RCU provides a use case for distinguishing readers
and writers: you might have a variable that you can read if you hold
the RCU reader "lock", but you can only write if you hold a spinlock.

- Josh Triplett


--------------enigAA4819DD60B5A335BC2F3818
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIEUBZGJuZRtD+evsRAmzsAKCFo5BIA8J0PXKlFVxfbPjr94KLfQCbBQRc
/Isd0XxFBP326K53bzEw4Zo=
=6IOX
-----END PGP SIGNATURE-----

--------------enigAA4819DD60B5A335BC2F3818--
