From: Josh Triplett <josh@freedesktop.org>
Subject: Re: barrier macro
Date: Tue, 01 May 2007 21:24:09 -0700
Message-ID: <46381269.9090305@freedesktop.org>
References: <20070501153448.a65c81c2.rdunlap@xenotime.net> <463802E1.4030303@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigECB01B82DDB721897E912CB2"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:44936 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbXEBEYM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 00:24:12 -0400
In-Reply-To: <463802E1.4030303@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigECB01B82DDB721897E912CB2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

After analyzing net/sunrpc/xprtsock.i, I managed to reproduce the problem=
 with
the following test case:

#define barrier() __asm__ __volatile__("": : :"memory")

static void f(void)
{
	barrier();
l:
	barrier();
}


Apparently sparse doesn't like __asm__ __volatile__ after a label.  Looks=
 like
the change to enable attributes on labels makes Sparse interpret the __as=
m__
as an attribute on the label, not as a statement.  If I locally revert th=
e
label attributes change, aec53c938c34c47cdbdd6824552e0f2a5104b1cb, this t=
est
case compiles without warning, as does net/sunrpc/xprtsock.c.

The label attributes change needs some additional work, to make it only h=
andle
attribute and __attribute__, and nothing else.

- Josh Triplett


--------------enigECB01B82DDB721897E912CB2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOBJpGJuZRtD+evsRAg7+AJ9BzNjZ0YYrGrwz7swsg3E3ObFJ1gCglCF8
u2KpZyDF57AlN3KvvldWCpU=
=q/k7
-----END PGP SIGNATURE-----

--------------enigECB01B82DDB721897E912CB2--
