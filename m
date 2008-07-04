From: David Given <dg@cowlark.com>
Subject: Adding type information to instructions
Date: Sat, 05 Jul 2008 00:43:24 +0100
Message-ID: <486EB59C.100@cowlark.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFD63256230295195B38DE98A"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:55691 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbYGDXne (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 Jul 2008 19:43:34 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KEuw8-00029V-CG
	for linux-sparse@vger.kernel.org; Sat, 05 Jul 2008 00:43:32 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id AEC7220134
	for <linux-sparse@vger.kernel.org>; Sat,  5 Jul 2008 00:43:29 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD63256230295195B38DE98A
Content-Type: multipart/mixed;
 boundary="------------070509020402010206020203"

This is a multi-part message in MIME format.
--------------070509020402010206020203
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I've been having trouble finding the types of pseudos; the approach I've
been using, which is to follow the chain of pseudo's definers until I
find an instruction with enough type information to use, turns out to
fail utterly on OP_LOAD instructions; I can't find any way of getting
enough information from the opcode's arguments to determine the type of
the target.

As a result, I've had to make a minor patch to the lineariser code.
Given that the lineariser knows the information I need at the point
where it generates the instruction, it would seem to make sense to tag
the instruction with the type. This is made quite easy by the way that
the lineariser has a allocate-typed-instruction function.

Patch enclosed; it's very simple.

Does this seem like a reasonable approach? Is it something that would be
useful to have in the base builds? Are there any ramifications I should
be aware of?

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

--------------070509020402010206020203
Content-Type: text/x-diff;
 name="type.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="type.patch"

diff -rwu sparse.orig/linearize.c sparse/linearize.c
--- sparse.orig/linearize.c	2008-06-28 22:44:21.714555764 +0100
+++ sparse/linearize.c	2008-06-30 23:20:30.777932755 +0100
@@ -55,7 +55,9 @@
=20
 static struct instruction *alloc_typed_instruction(int opcode, struct sy=
mbol *type)
 {
-	return alloc_instruction(opcode, type_size(type));
+	struct instruction *insn =3D alloc_instruction(opcode, type_size(type))=
;
+	insn->type =3D type;
+	return insn;
 }
=20
 static struct entrypoint *alloc_entrypoint(void)
diff -rwu sparse.orig/linearize.h sparse/linearize.h
--- sparse.orig/linearize.h	2008-06-28 22:44:21.714555764 +0100
+++ sparse/linearize.h	2008-06-30 23:20:04.425933822 +0100
@@ -71,6 +71,7 @@
 		 size:24;
 	struct basic_block *bb;
 	struct position pos;
+	struct symbol *type;
 	union {
 		pseudo_t target;
 		pseudo_t cond;		/* for branch and switch */

--------------070509020402010206020203--

--------------enigFD63256230295195B38DE98A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIbrWff9E0noFvlzgRAoIzAKDLDKc+fed+4dxRnmQvUFy5enyqRgCgrEKr
QYkD00fHl09iSKiiLouv/io=
=3Bx9
-----END PGP SIGNATURE-----

--------------enigFD63256230295195B38DE98A--
