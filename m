From: Josh Triplett <josh@freedesktop.org>
Subject: Re: fun with ?:
Date: Tue, 22 May 2007 18:03:31 -0700
Message-ID: <465392E3.3000300@freedesktop.org>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB70B423F60D2A8D1D0C3E576"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:47079 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756880AbXEWBEQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 21:04:16 -0400
In-Reply-To: <20070523000234.GJ4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB70B423F60D2A8D1D0C3E576
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> On Tue, May 22, 2007 at 04:24:49PM -0700, Josh Triplett wrote:
>> Makes sense, except that in C you can assign a void pointer to an arbi=
trary *
>> without a warning, so why can't conditional expressions do the equival=
ent?
>=20
> {in sparse it's obviously not true due to address_space, but that hadn'=
t
> affected C standard decisions; the rest applies to standard C}
>=20
> For one thing, no, you can't (pointers to functions have every right to=

> be unrelated to void *).  For another, you are not guaranteed that
> conversion from void * to int * will not yield undefined behaviour.
> It is OK if the value of void * is properly aligned; then you know
> that conversion back to void * will give the original pointer.  Otherwi=
se
> you are in nasal demon country.  The other way round (int * to void *
> to int *) you are always safe.
>=20
> Rationale: systems that have pointers to words and char smaller than wo=
rd.
> There you can very well have pointers to void and pointers to less-than=
-word
> objects bigger than pointers to anything word-sized or bigger (e.g. the=
y
> can be represented as word address + bit offset).  Conversion to the la=
tter
> will lose offset and compiler is allowed to throw up on that at runtime=
=2E

Go Cray go.

> Moral: void * -> int * may lose parts of value and trigger undefined be=
haviour;
> int * -> void * loses information about type, is always revertible and =
always
> safe.  In assignment operator it's your responsibility to make sure tha=
t
> void * you are converting to int * is properly aligned (anything that s=
tarted
> its life as int * will be).  In ?: C could
> 	* lose type information, allowing any values (result is void *); if
> you are sure that it's well-aligned, you can cast void * argument to in=
t *
> or cast the result.
> 	* require the void * argument to be well-aligned, keep the type.
>=20
> The former makes more sense...

Fair enough.

>>> Again, null pointer constant is not the same thing as null pointer to=
 void.
>> I see.  I find it very strange that (void *)0 and (void *)(void *)0 ha=
ve
>> different behavior.  I also find it strange that conditional expressio=
ns can't
>> convert void * to an arbitrary pointer as assignment can.
>=20
> It would be nicer if C had __null__ as the *only* null pointer constant=

> (with flexible type) and could refuse to accept anything else.  Too lat=
e
> for that, unfortunately.  As for conversions - see above.

Agreed; that seems far saner.  (Or, as long as we wishfully redefine the
original C spec, just NULL or null, sans underscores.)

>>> BTW, there's another painful area: what do we do to somebody who uses=

>>> (void *)(69 + 1 - 70) as null pointer constant?  Currenly sparse does=
n't
>>> recognize it as such; C standard does.  IMO the right thing to do is
>>> to add a flag that would switch to full-blown standard rules in that =
area
>>> ("integer constant expression returning 0" instead of basically "0 in=
 some
>>> layers of ()") and flame to the crisp any wanker caught at actually d=
oing
>>> that.  Any suggestions re sufficiently violent warning messages?
>> I didn't know that the C standard actually *required* constant folding=
=2E
>> Interesting.  Would it add excessively to compilation time to apply th=
e usual
>> Sparse constant folding here?  If so, and if you really think this cas=
e
>> matters, let's have an option to turn on this constant folding, and wa=
rn
>> whenever we see it.
>=20
> Usual sparse constant folding is _almost_ OK, provided that we play a b=
it
> with evaluate_expression() and let it decide if subexpression is an int=
eger
> constant expression.  No prototype changes, we just get a global flag
> and save/restore it around sizeof argument handling and several other
> places.  It's actually pretty easy.  And if we get "it is an integer
> constant expression", well, then caller can call expand stuff.

Sounds reasonable to me.  Possibly better written as some kind of generic=

parse-tree-walking operation, but this approach should work fine.

> "Almost" bit above refers to another bit of insanity, fortunately easil=
y
> handled; we need division by zero to raise no error and just yield "the=

> entire thing is not an integer constant expression with value 0".  That=
's
> exactly what longjmp() is for...

$ egrep -r 'setjmp|longjmp' ~/src/sparse/*
$

Let's keep it that way, please. :) Evaluation almost certainly should war=
n for
a compile-time divide-by-zero regardless, though we don't want to warn tw=
ice
for the same expression.  With the global "check for integer constant
expression" flag set, if evaluation encounters a compile-time divide-by-z=
ero,
evaluation could just set a divided_by_zero flag.  Or something like that=
=2E

> Speaking of C standard, if you need access to the current one - yell.

I use http://c0x.coding-guidelines.com/ , which has the C99 spec and some=

subsequent updates.

- Josh Triplett



--------------enigB70B423F60D2A8D1D0C3E576
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU5LjGJuZRtD+evsRAjgrAJ9TgfVhTnrbcDtWYvFYMkJF7HQsKACfaQRQ
FemkdvZKlq64kg3m269Kdbs=
=zxWT
-----END PGP SIGNATURE-----

--------------enigB70B423F60D2A8D1D0C3E576--
