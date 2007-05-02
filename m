From: Josh Triplett <josh@freedesktop.org>
Subject: Re: barrier macro
Date: Tue, 01 May 2007 22:37:11 -0700
Message-ID: <46382387.4010903@freedesktop.org>
References: <20070501153448.a65c81c2.rdunlap@xenotime.net> <463802E1.4030303@freedesktop.org> <46381269.9090305@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD8A0D70FB15548F6850360E1"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:34030 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbXEBFhQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 01:37:16 -0400
In-Reply-To: <46381269.9090305@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8A0D70FB15548F6850360E1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Josh Triplett wrote:
> After analyzing net/sunrpc/xprtsock.i, I managed to reproduce the probl=
em with
> the following test case:
>=20
> #define barrier() __asm__ __volatile__("": : :"memory")
>=20
> static void f(void)
> {
> 	barrier();
> l:
> 	barrier();
> }
>=20
>=20
> Apparently sparse doesn't like __asm__ __volatile__ after a label.  Loo=
ks like
> the change to enable attributes on labels makes Sparse interpret the __=
asm__
> as an attribute on the label, not as a statement.  If I locally revert =
the
> label attributes change, aec53c938c34c47cdbdd6824552e0f2a5104b1cb, this=
 test
> case compiles without warning, as does net/sunrpc/xprtsock.c.
>=20
> The label attributes change needs some additional work, to make it only=
 handle
> attribute and __attribute__, and nothing else.

Fixed in current Git.

- Josh Triplett



--------------enigD8A0D70FB15548F6850360E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOCOHGJuZRtD+evsRAp6rAJ0buWJSry3XihEBa9V4wzX2yI9xBgCcDJzx
lwoJKD1e0vzDv2bh9YXVlb0=
=J5B9
-----END PGP SIGNATURE-----

--------------enigD8A0D70FB15548F6850360E1--
