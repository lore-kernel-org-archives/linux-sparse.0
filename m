From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Fri, 06 Jul 2007 01:33:30 -0700
Message-ID: <468DFE5A.8080602@freedesktop.org>
References: <20070705093528.GK21478@ftp.linux.org.uk> <468D1003.1050901@freedesktop.org> <20070705164334.GM21478@ftp.linux.org.uk> <1183661456.2604.43.camel@josh-work.beaverton.ibm.com> <20070706074803.GV21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA50EFB377E16BFEA303768DB"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:47369 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbXGFIdm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 04:33:42 -0400
In-Reply-To: <20070706074803.GV21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA50EFB377E16BFEA303768DB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> On Thu, Jul 05, 2007 at 11:50:56AM -0700, Josh Triplett wrote:
> =20
>> No, I mean __attribute__((context(...))), which means something
>> different.  __context__() works as a statement statement changing the
>> context.  __attribute__((context(...))) works as an attribute modifyin=
g
>> a type to say that it requires a given context, and that
>> accessing/calling it changes the context.  Somewhat of an odd
>> distinction, but sparse currently works that way.
> =20
> That's actually not a qualifier from the syntax point of view...
> It makes sense *only* on function types - we simply ignore it
> on anything else.

For now, yes.  I intend to make use of the context attribute on arbitrary=

pointers or data.  For example, I want to specify that you must hold a gi=
ven
lock in order to access a structure field, and enforce that context when =
you
access the field.

> And C syntax doesn't allow qualifiers on functions -
> not without creative use of typedef (which gets you in nasal demon
> country - undefined behaviour).

For functions, yes.  In the case of pointers or data, I do want the conte=
xt
attribute to work like a qualifier: you might want to apply it to a point=
er,
or to the pointer target, or to a structure field, or an entire structure=
=2E..

[snip several function-specific issues]

> 	Another fun question: how do we compare these suckers?  Suppose
> you have foo() and bar() having some kind of contexts.  What contexts
> do we put into n ? foo : bar and when do we allow that?

If foo requires context x, and bar requires context y, then (n ? foo : ba=
r)();
*might* require context x and *might* require context y.  Similar problem=
s
arise for issues like conditional locking.  So far, the solution involves=

saying "if it doesn't look obvious to the compiler, it doesn't look obvio=
us to
the coder, so rewrite it such that it does"; that works fairly well for L=
inux,
though long-term I'd like to handle increasingly complex cases.  In some
cases, specifying more attributes helps; for instance, you can remove
ambiguity by specifying context attributes on function pointers.

> Similar question for p =3D foo; where p is a pointer to function, etc.

See above.  Eventually we might have advanced dataflow analysis deriving
attributes for us; for now, function pointers will need explicit contexts=
=2E

> I realize that the first argument of __attribute__((context(...,...,...=
)))
> is currently ignored and pretty much hopeless as defined, but...

Currently ignored, yes.  I certainly hope that providing a context expres=
sion
proves sufficient to specify a context.  Yes, problems arise if you need =
to do
complex unification of context expressions, but I *think* that we can han=
dle
the simpler cases first and the complicated cases as needed.  If you have=
 any
suggestions that might improve context checking, I'd love to discuss them=
 with
you.

- Josh Triplett


--------------enigA50EFB377E16BFEA303768DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGjf5aGJuZRtD+evsRAsrNAJ9m/4XYglhBYNNV0htlKltUy9JIlQCgs76N
6RtOBYMYLiLZ+42OitSW5To=
=PADc
-----END PGP SIGNATURE-----

--------------enigA50EFB377E16BFEA303768DB--
