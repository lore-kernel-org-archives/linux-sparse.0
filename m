From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Wed, 27 Jun 2007 23:54:07 -0700
Message-ID: <46835B0F.4080606@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com> <20070628055850.GE21478@ftp.linux.org.uk> <46834FA0.8010201@freedesktop.org> <46835471.4070000@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB48F3C61F5C3CAE4349B4089"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:48588 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759062AbXF1GyK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:54:10 -0400
In-Reply-To: <46835471.4070000@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB48F3C61F5C3CAE4349B4089
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Josh Triplett wrote:
>> While I agree that I'd like a better approach (specifically, I want an=
y Sparse
>> build to support any target arch), I don't yet have a solution for tha=
t, and
>> this patch does at least seem like an improvement over the current har=
dcoded
>> values.
>=20
> That's my desire as well:  My ideal sparse backend should be able to=20
> compile x86, x86-64, ppc64, ia64, arm, etc. with just a change of=20
> command line switches.
>=20
> The gcc approach is just bloody awful.

I agree that the GCC approach to cross-compilation could use significant
improvement.  In particular, I'd like to just specify a set of architectu=
res,
or "all of them", at compile time, and have GCC support all of those
architectures in the same GCC binary.  Combined with GCC's existing "sysr=
oot"
approach to multiple architecture support, this would make cross-compilat=
ion
much easier.

However, in the meantime, GCC doesn't seem to have any such thing.  How d=
o we
want to implement it in Sparse?  I don't think we have enough information=
 on
the GCC command line.  I suppose we could allow specifying an architectur=
e
explicitly; for cgcc, we could also allow specifying the compiler name fo=
r
cross-compilation and then deriving the architecture name from the compil=
er
name if not explicitly specified.

I'd like to see much of cgcc disappear; it should do nothing except invok=
e GCC
and Sparse, and Sparse should handle the architecture issues that cgcc
currently handles.

- Josh Triplett


--------------enigB48F3C61F5C3CAE4349B4089
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg1sPGJuZRtD+evsRAhg2AJoCQ5BnHos0fBzrxbH1a0Zn2T3MWwCgmsBM
c5wxnjd/+f0C1H1tPZm+w0E=
=ietp
-----END PGP SIGNATURE-----

--------------enigB48F3C61F5C3CAE4349B4089--
