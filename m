From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Another sparse warning...
Date: Tue, 13 Feb 2007 00:49:04 -0800
Message-ID: <45D17B80.8040905@freedesktop.org>
References: <4975FCBA-D3D4-4DF2-AC20-C11A5F97DE51@cam.ac.uk> <Pine.LNX.4.64.0702120742030.8424@woody.linux-foundation.org> <20070213020054.GB2922@chrisli.org> <Pine.LNX.4.64.0702121947240.8424@woody.linux-foundation.org> <20070213042152.GC2922@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig357FA0243CC6AD10357C30B0"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:50559 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbXBMItH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Feb 2007 03:49:07 -0500
In-Reply-To: <20070213042152.GC2922@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Anton Altaparmakov <aia21@cam.ac.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig357FA0243CC6AD10357C30B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Mon, Feb 12, 2007 at 07:48:18PM -0800, Linus Torvalds wrote:
>>> When call one of those functions, it can know that function will chan=
ge
>>> context.  That might be a way to solve the problem that some of the
>>> spinlock function is not a inline function at all.
>> I thought we did that already. I'm fairly sure I had this working at s=
ome=20
>> point - exactly by having the calls just add up the (known) lock/unloc=
k=20
>> offsets.
>=20
> You are right. It is already there. I never see it before because my ct=
ags
> get confused about the context annotation:
>=20
> void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);=20
>=20
> It generate tags for "lock" instead of "_spin_lock".

Interesting behavior. :)  That makes sense, given ctags' regex-based pars=
ing.

About that syntax: I chose to use the parameter name there because I want=
ed to
use arbitrary expressions (like param_struct->lock) for a context, rather=
 than
a parameter number (as used in printf annotations).  I'd love to see any
thoughts you might have on how best to parse that expression into somethi=
ng
with "placeholders" for formal parameters, and then easily substitute the=

actual parameters at each call site to determine the expression for the
acquired or released context.  Then we need a solution for the more diffi=
cult
problem: unifying and tracking context expressions in the face of changin=
g
data in those expressions.

- Josh Triplett


--------------enig357FA0243CC6AD10357C30B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0XuAGJuZRtD+evsRAj5uAKCGKKubJoFsJ5KkNvq3CeCYRjm32gCguSWP
pYUXwCE+JRMUq9LxrF/MDIQ=
=fJFP
-----END PGP SIGNATURE-----

--------------enig357FA0243CC6AD10357C30B0--
