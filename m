From: Josh Triplett <josh@freedesktop.org>
Subject: Re: fun with ?:
Date: Tue, 22 May 2007 14:40:11 -0700
Message-ID: <4653633B.3000000@freedesktop.org>
References: <20070519025249.GZ4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9883604EB15A73613B69775B"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:49771 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429AbXEVVkx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 17:40:53 -0400
In-Reply-To: <20070519025249.GZ4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9883604EB15A73613B69775B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> 	There's an unpleasant case in conditional operator we are getting
> wrong.
> 	int *p;
> 	const void *v;
> 	int n;
>=20
> 	n ? p : (const void *)0
>=20
> According to C standard, the type of that expression is const void *.  =
Note
> that
> 	n ? p : (void *)0
> is an entirely different story - it's int *.

That much actually makes sense to me.  You can convert from (int *) to (c=
onst
void *), but not from (const void *) to (int *), so I'd expect the behavi=
or of
the first case.  You *can* convert bidirectionally between (void *) and (=
int
*), so I expect the behavior of the second case as well.

> What's going on here is pretty simple: there are two degenerate cases o=
f
> conditional operator: pointer vs. null pointer constant and pointer vs.=

> possibly qualified pointer to void.  Look at these cases:
> 	n ? p : NULL =3D> should be the same type as p
> 	n ? p : v =3D> clearly const void * - pointer to void with union of
> qualifiers; in this case we obviously lose any information about the ty=
pe
> of object being pointed to.

I didn't actually know about the special case for a null pointer constant=
=2E

> The tricky part comes from definition of what null pointer constant _is=
_.
> C allows two variants - integer constant expression with value 0 (we ac=
cept
> it, but warn about bad taste) and the same cast to void * (we also acce=
pt
> that, of course).

Right.

> Note that this is specific type - pointer to void.  Without any qualifi=
ers.
> We are guaranteed that we can convert it to any pointer type and get
> a pointer distinct from address of any object.  So (const void *)0 is t=
he same
> thing as (const void *)(void *)0 and it is the null pointer to const vo=
id.
> *HOWEVER*, it is not a null pointer constant.  The standard is clear he=
re and
> frankly, it's reasonable.  If you cast to anything other than void *, t=
hen
> you presumably mean it and want the conversion rules as for any pointer=

> of that type.  Think of something like
> #ifdef FOO
> const void *f(int n);
> #else
> #define f(n) ((const void *)NULL)
> #endif
> You don't want to have types suddenly change under you depending on FOO=
=2E

Definitely not.  I don't want qualifiers to disappear just because I appl=
ied
them to NULL.

> sparse is more liberal than standard C in what it accepts as null point=
er
> constant.  It almost never matters; however, in case of conditional ope=
rator
> we end up with a different type for an expression both sparse and any
> C compiler will accept as valid.
>
> I'm fixing other fun stuff in that area (e.g. we ought to take a union =
of
> qualifiers, ought _not_ to mix different structs or unions, etc.), so
> unless there are serious objections I'd rather go with standard behavio=
ur
> in that case.  What will change:
>=20
> int n;
> int *p;
>=20
> n ? p : (const void *)NULL	int *	=3D>	const void *
> n ? p : (const void *)0		ditto
> n ? p : (char *)0		int *	=3D>	a warning on mixing int * with							char=
 *
> n ? p : (char *)NULL		ditto
> n ? p : (void *)NULL		int *	=3D>	void *
> n ? p : (void *)0		unchanged
> n ? p : NULL			unchanged
>=20
> Objections?

Thanks for the clear explanation.  I think following the standard seems l=
ike a
good idea here, though I find some of the cases somewhat unintuitive and
potentially error-prone.

In particular:
> n ? p : (void *)NULL		int *	=3D>	void *
Shouldn't this have type int * just like n ? p : NULL ?

- Josh Triplett


--------------enig9883604EB15A73613B69775B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU2M7GJuZRtD+evsRArjNAKCFcJRa5/9gcD5ne0Zy7jBJQCS7dwCfclFC
Uvt/nVoWINGggJy2BvaVzbM=
=Hgkv
-----END PGP SIGNATURE-----

--------------enig9883604EB15A73613B69775B--
