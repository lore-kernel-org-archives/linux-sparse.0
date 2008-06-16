From: David Given <dg@cowlark.com>
Subject: Writing compilers, and example.c vs compile-i386.c
Date: Tue, 17 Jun 2008 00:04:54 +0100
Message-ID: <4856F196.8020403@cowlark.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA1132B1390733F5A572B3A60"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:47522 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbYFPXeg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 16 Jun 2008 19:34:36 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1K8Nkw-0006s0-N0
	for linux-sparse@vger.kernel.org; Tue, 17 Jun 2008 00:04:58 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 91E762008D
	for <linux-sparse@vger.kernel.org>; Tue, 17 Jun 2008 00:04:57 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1132B1390733F5A572B3A60
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm wanting to write a compiler-like tool that's capable of generating
machine-code-like-stuff (don't ask, long story), and as such, have been
looking around for C compiler front ends that will make my life easier.
sparse looks extremely promising.

As such, I've been examining the two sample compilers, example.c and
compile-i386.c. These appear to generate i386-ish machine code, but do
so in entirely different ways. If I've understood them correctly,
example.c enumerates the instructions inside each function's basic
blocks, and uses sparse's pseudo_t support for doing register
allocation; while compile-i386.c enumerates the statements inside each
function, and does it's own register allocation.

Some basic testing with show_statement() and show_insn() reveals that
both approaches seem to yield similar but *different* pseudocode... with
different SSA phi functions. What's the difference between the two, and
do you have any suggestions as to which approach I should look at?

In addition, I'm afraid I'm going to have to use the D word... has
anyone written down anything about how all this stuff works? I'm afraid
it's rather a large mass of code to try and absorb in one go, and any
overview information would help me considerably. For example: if I put
together a noddy program that enumerates basic blocks (the example.c
approach) I see phi functions. Calling unssa() doesn't seem to help.
However, inserting instrumentation into example.c indicates that it
*doesn't* see phi functions (as far as I can tell). There's something
I'm simply not getting here --- does the removal of phis actually happen
inside the register allocator (which seems like the intuitive place for
it), and if so, what does unssa() actually do?

This is all with sparse 0.4.1. Is that current?

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


--------------enigA1132B1390733F5A572B3A60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIVvGWf9E0noFvlzgRAguyAJ4iGy1QtcPfoIyK0m4BeQZ/wSoeyQCfY+KY
XVyoQsSYh2mSBi7513YR8ss=
=h42t
-----END PGP SIGNATURE-----

--------------enigA1132B1390733F5A572B3A60--
