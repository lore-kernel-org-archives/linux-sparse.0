From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Mon, 21 Apr 2008 11:51:18 -0700
Message-ID: <480CE226.3060602@freedesktop.org>
References: <20080410132519.049821000@sipsolutions.net>	 <20080410132617.720109000@sipsolutions.net> <480CD736.601@freedesktop.org>	 <1208801485.26186.131.camel@johannes.berg>	 <480CDC3C.4040808@freedesktop.org> <1208802634.26186.135.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE8D14D036AF8899E77E07B29"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:57183 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYDUSvF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 14:51:05 -0400
In-Reply-To: <1208802634.26186.135.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE8D14D036AF8899E77E07B29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Johannes Berg wrote:
>> And as for how to solve it: I think alias analysis might work.
>=20
> How would I do that?

Real compilers have alias analysis code, which builds up information
on which variables and expressions may/must alias each other.  I think
that that alias information might prove sufficient to compare
contexts: if two contexts alias each other then they represent the
same context.

Basic type-based alias analysis should prove sufficient to handle
cases like:

spinlock_t s;
struct something_with_a_spinlock st;

spin_lock(&st.s);
spin_unlock(&st.s); /* contexts match */

spin_lock(&st.s);
spin_unlock(&s); /* warn */

Flow-based alias analysis may also handle cases like you mentioned,
where you assign a lock to a variable and then use it through that
variable.


Alternatively, some simple dataflow analysis and symbolic execution
might let you figure out the lock a variable points to in most cases.


As a simpler solution, you could just do what lockdep does: make
assumptions that handle the common cases, and allow explicit overrides
for the uncommon cases.  I suspect that most code does not assign a
lock to a variable and use the lock through that variable.

In particular, you could perhaps make the assumption that any
expression which resolves to the "foo" field of a "struct bar"
represents the same context, rather than attempting to distinguish
between them.

- Josh Triplett


--------------enigE8D14D036AF8899E77E07B29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIDOInGJuZRtD+evsRAnknAJ9Ev/maHLFSSU9RfAmvj0sz0nQndwCghnZ6
7ORyHn8kfnfjqJ8SAg1J2ws=
=uCUC
-----END PGP SIGNATURE-----

--------------enigE8D14D036AF8899E77E07B29--
