From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Mon, 21 Apr 2008 11:26:04 -0700
Message-ID: <480CDC3C.4040808@freedesktop.org>
References: <20080410132519.049821000@sipsolutions.net>	 <20080410132617.720109000@sipsolutions.net>  <480CD736.601@freedesktop.org> <1208801485.26186.131.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5624E8559F878735E98B2D46"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:45481 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197AbYDUSZu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 14:25:50 -0400
In-Reply-To: <1208801485.26186.131.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5624E8559F878735E98B2D46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Johannes Berg wrote:
>>>     static void *dev_mc_seq_start(struct seq_file *seq, loff_t * pos)=

>>>             __acquires(dev_base_lock)
>>>     {
>>>             [...]
>>>             __acquire__(dev_base_lock);
>>>             read_lock(&dev_base_lock);
>>>             [...]
>>>     }
>> I don't understand why you count this as wrong.  read_lock should
>> handle acquiring the context itself, either via an __acquires
>> annotation if written as a function, or via an __acquire__ statement
>> if written as a macro.  Callers of read_lock shouldn't need to
>> explicitly call __acquire__.
>=20
> Well, the question is how you want to name things. What I did is that
> the context identifier is just a name and bears no other relation to th=
e
> code. Hence, read_lock() can't say that it acquires 'dev_base_lock'
> because it doesn't know what the name should be.
>=20
> With a slightly different sparse patch than mine you could declare
> read_lock() something like this:
>=20
> #define read_lock(x) do { \
> 	__acquire__(x); \
> 	__read_lock((x)); \
> } while (0)
>=20
> but then you'd have different names everywhere, say somebody passed
> '&dev_base_lock' and somebody else used
>=20
> readlock_t *dbl =3D &dev_base_lock;
> read_lock(dbl)
>=20
> and you'd end up with one context named "dbl" and another one named
> "&dev_base_lock".

That might still work, depending on how consistently kernel code uses
the same argument.  If you suggest explicitly changing calls to
read_lock to call __acquire__ with the appropriate context, it might
prove equally easy to make the argument of read_lock that context.

> If you have suggestions on how to solve this I'm all ears, so far I
> decided it wasn't worth it and opted for explicitly naming all the
> contexts.
>=20
> (with my patch the above would just create a context called "x")

That doesn't make sense to me; after preprocessing, x no longer
exists, so I don't see how you could pick up the identifier "x".  I
can understand that you might pick up two different expressions in
place of x which you can't easily compare, though.

And as for how to solve it: I think alias analysis might work.

- Josh Triplett


--------------enig5624E8559F878735E98B2D46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIDNw8GJuZRtD+evsRApsIAKCUJ2JS0I4qG0G0BNPdGVMNrzs16QCghyKH
7kX75tTGpoAcOBiwfo2WGHs=
=9Fy9
-----END PGP SIGNATURE-----

--------------enig5624E8559F878735E98B2D46--
