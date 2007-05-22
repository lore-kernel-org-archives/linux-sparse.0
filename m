From: Josh Triplett <josh@freedesktop.org>
Subject: Re: fun with ?:
Date: Tue, 22 May 2007 16:24:49 -0700
Message-ID: <46537BC1.9000808@freedesktop.org>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9FE4DAA7A1AB8C638AEC0D0F"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:42845 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173AbXEVXZc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 19:25:32 -0400
In-Reply-To: <20070522224619.GI4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9FE4DAA7A1AB8C638AEC0D0F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> On Tue, May 22, 2007 at 02:40:11PM -0700, Josh Triplett wrote:
>>> What's going on here is pretty simple: there are two degenerate cases=
 of
>>> conditional operator: pointer vs. null pointer constant and pointer v=
s.
>>> possibly qualified pointer to void.  Look at these cases:
>>> 	n ? p : NULL =3D> should be the same type as p
>>> 	n ? p : v =3D> clearly const void * - pointer to void with union of
>>> qualifiers; in this case we obviously lose any information about the =
type
>>> of object being pointed to.
>> I didn't actually know about the special case for a null pointer const=
ant.
>=20
> Rationale is pretty simple: normally if you have void * in the mix, you=

> _can't_ expect more type information from the result; i.e. you are not
> promised that result of ?: will point to int.  However, null pointer co=
nstant
> is a chameleon - it accepts whatever pointer type you might need in giv=
en
> context.  So in that case you do _not_ lose the type information.

Makes sense, except that in C you can assign a void pointer to an arbitra=
ry *
without a warning, so why can't conditional expressions do the equivalent=
?

>> In particular:
>>> n ? p : (void *)NULL		int *	=3D>	void *
>> Shouldn't this have type int * just like n ? p : NULL ?
>=20
> No.  It's "void * and I _mean_ it".  Well... actually (void *)(void *)0=
 if
> you want to be 100% portable and protect yourself against cretinous sys=
tems
> that define NULL to 0.
>=20
> Again, null pointer constant is not the same thing as null pointer to v=
oid.

I see.  I find it very strange that (void *)0 and (void *)(void *)0 have
different behavior.  I also find it strange that conditional expressions =
can't
convert void * to an arbitrary pointer as assignment can.

> BTW, there's another painful area: what do we do to somebody who uses
> (void *)(69 + 1 - 70) as null pointer constant?  Currenly sparse doesn'=
t
> recognize it as such; C standard does.  IMO the right thing to do is
> to add a flag that would switch to full-blown standard rules in that ar=
ea
> ("integer constant expression returning 0" instead of basically "0 in s=
ome
> layers of ()") and flame to the crisp any wanker caught at actually doi=
ng
> that.  Any suggestions re sufficiently violent warning messages?

I didn't know that the C standard actually *required* constant folding.
Interesting.  Would it add excessively to compilation time to apply the u=
sual
Sparse constant folding here?  If so, and if you really think this case
matters, let's have an option to turn on this constant folding, and warn
whenever we see it.  I'll let you come up with the wording; flame away. :=
)
Anyone expecting that behavior has some serious dain-bramage.  If constan=
t
folding *wouldn't* add excessively to the compilation time, go ahead and
handle the insanity the standard way by default, but still warn for the i=
nsane
case.

- Josh Triplett


--------------enig9FE4DAA7A1AB8C638AEC0D0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU3vBGJuZRtD+evsRAtlzAJ4xcNJK+K3/DKXgdzkP6maz6xe/kACgg62x
owWcSQlYOrN8TMnKt82OpTo=
=enTl
-----END PGP SIGNATURE-----

--------------enig9FE4DAA7A1AB8C638AEC0D0F--
