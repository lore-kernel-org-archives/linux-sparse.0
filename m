From: David Given <dg@cowlark.com>
Subject: Odd behaviour with OP_SCAST
Date: Sat, 06 Sep 2008 22:14:36 +0100
Message-ID: <48C2F2BC.9030606@cowlark.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig900734DB3222BEEE77FC3117"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:56150 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYIFVOt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Sep 2008 17:14:49 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1Kc57G-00034C-OJ
	for linux-sparse@vger.kernel.org; Sat, 06 Sep 2008 22:14:46 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 7F4522006F
	for <linux-sparse@vger.kernel.org>; Sat,  6 Sep 2008 22:14:44 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig900734DB3222BEEE77FC3117
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

test-unssa.c compiles this:

extern void func(int i, ...);
void foo(int i) { func(0, (float) i, (double) i, i); }

=2E..into this:

	fpcast.64   %r3 <- (32) %arg1
	scast.64    %r5 <- (32) %arg1
	call        func, $0, %r3, %r5, %arg1
	ret

That's with the default settings. Unfortunately, with Clue,
sizeof(double) =3D=3D sizeof(int), so that second instruction comes out a=
s:

	scast.32    %r5 <- (32) %arg1

This then causes the simplification code in simplify_cast() to discard it=
:

	if (size =3D=3D orig_size) {
		int op =3D (orig_type->ctype.modifiers & MOD_SIGNED) ? OP_SCAST : OP_CA=
ST;
		if (insn->opcode =3D=3D op)
			goto simplify;
	}

The end result is that my call statement turns into:

	call        func, $0, %r3, %arg1, %arg1

=2E..which is wrong.

I assume that Clue's odd configuration is violating some assumption
somewhere, but I'm not well-enough versed with the sparse internals to
know where. It does seem odd to me that it's generating an OP_SCAST to
convert the int to a double, rather than an OP_FPCAST like in the float.
In the mean time, I've commented out the quoted stanza from
simplify_cast() on my setup, which makes things work, but that's not
really very pleasant.

Can anyone shed light on what might be happening here? Could this be a
symptom of some more serious underlying bug?

--=20
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =EF=BD=84=EF=BD=87=EF=BC=A0=EF=BD=83=
=EF=BD=8F=EF=BD=97=EF=BD=8C=EF=BD=81=EF=BD=92=EF=BD=8B=EF=BC=8E=EF=BD=83=EF=
=BD=8F=EF=BD=8D =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 http://www.=
cowlark.com =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82
=E2=94=82 "All power corrupts, but we need electricity." --- Diana Wynne =
Jones,
=E2=94=82 _Archer's Goon_


--------------enig900734DB3222BEEE77FC3117
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIwvLCf9E0noFvlzgRApaKAKCo8I7vPAkPOjdYcRyv0td0IgASewCeIXub
wStZAOr+6LN4ST5OWn1EjMM=
=4V0F
-----END PGP SIGNATURE-----

--------------enig900734DB3222BEEE77FC3117--
