From: David Given <dg@cowlark.com>
Subject: Odd sparse behaviour
Date: Sun, 06 Jul 2008 22:33:12 +0100
Message-ID: <48713A18.7050103@cowlark.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFBA6914E3A805B6058BFAFF6"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:47527 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627AbYGFVdX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 6 Jul 2008 17:33:23 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KFbrF-00056H-DC
	for linux-sparse@vger.kernel.org; Sun, 06 Jul 2008 22:33:21 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id C533920134
	for <linux-sparse@vger.kernel.org>; Sun,  6 Jul 2008 22:33:18 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFBA6914E3A805B6058BFAFF6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I've found a couple of places where sparse behaves rather oddly.

Firstly, if you declare something static, and then try to define it
later, sparse appears to get confused:

---snip---
static int i;
int i =3D 0;
---snip---

$ ./test-parsing test.c
test.c:2:5: warning: symbol 'i' was not declared. Should it be static?

=2Ealign 4
int static [signed] [toplevel] i,
=2Ealign 4
int [signed] [addressable] [toplevel] i =3D
	movi.32		v1,$0

Enumeration of the list of defined symbols shows two different symbols
with the name 'i'. This isn't entirely obvious when using the test tools
as, of course, two strings with the same value look the same! This is
causing me issues with forward declarations of static functions:

static void foo();
{ ... foo(); ... }  // calls static foo

foo() {}            // defines extern foo
{ ... foo(); ... }  // calls extern foo

This then leads to link errors as static foo hasn't been found.


The second issue is with the following piece of C99 code:

---snip---
extern void nop(void)
void bar(void)
{ for (int i=3D0; i<10; i++) nop(); }
---snip---

$ ./test-linearise test.c
test.c:3:6: warning: symbol 'bar' was not declared. Should it be static?
bar:
=2EL0xb7d7600c:
	<entry-point>
	br          .L0xb7d76038

=2EL0xb7d76038:
	call        nop
	br          .L0xb7d76038

The for loop seems to silently turn into an infinite loop. Which did
cause one of my benchmarks to, um, produce rather poor results...

(You may be interested to know that my compiler is now producing
working, running code for non-trivial apps. Big chunks of it do need
throwing away and rewriting, but it's actually *working*!)

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


--------------enigFBA6914E3A805B6058BFAFF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIcTobf9E0noFvlzgRAgk8AJkBifAhh9q2IY7HVKwggR3gVghAKwCeJoYz
bioBYWPS9hODRLq87S1/uf8=
=5lkl
-----END PGP SIGNATURE-----

--------------enigFBA6914E3A805B6058BFAFF6--
