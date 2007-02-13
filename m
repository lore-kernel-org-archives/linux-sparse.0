From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Another sparse warning...
Date: Tue, 13 Feb 2007 00:38:44 -0800
Message-ID: <45D17914.8040608@freedesktop.org>
References: <4975FCBA-D3D4-4DF2-AC20-C11A5F97DE51@cam.ac.uk> <Pine.LNX.4.64.0702120742030.8424@woody.linux-foundation.org> <20070213020054.GB2922@chrisli.org> <Pine.LNX.4.64.0702121947240.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig74FE9788F21B90D903351BAA"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:46443 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbXBMIiq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Feb 2007 03:38:46 -0500
In-Reply-To: <Pine.LNX.4.64.0702121947240.8424@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Anton Altaparmakov <aia21@cam.ac.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig74FE9788F21B90D903351BAA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> On Mon, 12 Feb 2007, Christopher Li wrote:
>>>  - it shows the *programmer* that the function is doing somethign=20
>>>    "strange" (not really strange, but still: it's basically a fairly =

>>>    readable way that it's doing locking in a weird way).
>> Should the function declare in the header file has that as well?
>=20
> Yes.
>=20
>> When call one of those functions, it can know that function will chang=
e
>> context.  That might be a way to solve the problem that some of the
>> spinlock function is not a inline function at all.
>=20
> I thought we did that already. I'm fairly sure I had this working at so=
me=20
> point - exactly by having the calls just add up the (known) lock/unlock=
=20
> offsets.

On the other hand, the code currently does not check the context precondi=
tions
of the callee; Sparse *could* check that any function requiring you to ho=
ld a
lock (have a context of 1) must only get called from a context in which y=
ou
hold that lock (have that context).  Instead, Sparse only checks the cont=
ext
change, rather than the incoming context value at the call site.  It seem=
s
trivial to add a check for context preconditions, and Linux could then ha=
ve a
new annotation for __must_hold(lock) (usable on both functions and data),=
 but
that check would also add numerous false positives caused by lack of
annotation, and that problem seems better solved by interprocedural analy=
sis
than pervasive annotation.

Thoughts?

- Josh Triplett



--------------enig74FE9788F21B90D903351BAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0XkUGJuZRtD+evsRAvTnAJ9i0i/WDxFMBT7E7ROTCjoNyuEA8QCfTvbq
JlCbXyHApGvxKwyZf6iEW68=
=GPHA
-----END PGP SIGNATURE-----

--------------enig74FE9788F21B90D903351BAA--
