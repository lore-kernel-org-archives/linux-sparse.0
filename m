From: David Given <dg@cowlark.com>
Subject: [ANN] Clue experimental release
Date: Mon, 07 Jul 2008 22:47:46 +0100
Message-ID: <48728F02.9080306@cowlark.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6FAFEE38A8194B683C73AE98"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:38101 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912AbYGGVr4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Jul 2008 17:47:56 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KFyYr-0006Mf-QX
	for linux-sparse@vger.kernel.org; Mon, 07 Jul 2008 22:47:54 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 8F56A20134
	for <linux-sparse@vger.kernel.org>; Mon,  7 Jul 2008 22:47:51 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6FAFEE38A8194B683C73AE98
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

For the past few weeks I've been working on a C compiler for Lua. It's
now in a sufficient state to run non-trivial programs and benchmarks,
although it's by no means finished.

http://gate.cowlark.com/~dg/clue-0.1pre1.tar.bz2

(This will move to a real URL soon.)

Clue uses Sparse to emit Lua 5.1.3 bytecode by emitting Lua source and
running it through a modified version of luac to patch in goto
instructions. Currently most ANSI C C89 programs and some C99 programs
will compile, although there are big holes in the coverage (varargs,
switch, for example).

There's a libc, but I've only implemented enough to make the sample
benchmark programs work.

The code it generates isn't particularly great because I had to learn
how sparse worked as I went along and needed to make stuff up more or
less on the fly; the register allocator and code generator needs
throwing away and rewriting, for example. This makes the benchmarks
rather poor. But at least at this point they can only improve.

It turns out that there's quite a lot of scope for improvement...

Whetstone benchmark (gcc):              820
                    (clue with LuaJIT):   7.2
                    (clue with Lua):      3.6

It's all currently deeply experimental, buggy, half-finished and
potentially useless, but I hope it's at least interesting. In addition,
it should provide a reasonable example of how to write a compiler using
sparse.

--=20
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =EF=BD=84=EF=BD=87=EF=BC=A0=EF=BD=83=
=EF=BD=8F=EF=BD=97=EF=BD=8C=EF=BD=81=EF=BD=92=EF=BD=8B=EF=BC=8E=EF=BD=83=EF=
=BD=8F=EF=BD=8D =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 http://www.=
cowlark.com =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82 "I have always wished for my computer to be as easy to use as m=
y
=E2=94=82 telephone; my wish has come true because I can no longer figure=
 out
=E2=94=82 how to use my telephone." --- Bjarne Stroustrup


--------------enig6FAFEE38A8194B683C73AE98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIco8Ff9E0noFvlzgRAjZKAJ9fZYwlBg9AxB5FTaL02jb9BHjTYACgsLyI
IA4aO1qQ5gyzyNe2sfT1H4k=
=fxqe
-----END PGP SIGNATURE-----

--------------enig6FAFEE38A8194B683C73AE98--
