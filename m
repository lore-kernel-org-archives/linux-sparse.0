From: David Given <dg@cowlark.com>
Subject: Re: [PATCH 2/15 v2] Unhardcode byte size being 8 bits.
Date: Wed, 17 Dec 2008 23:33:59 +0000
Message-ID: <49498C67.4000700@cowlark.com>
References: <20081217190534.24084.94887.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDC725792077C6244CC92539D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:33871 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbYLRAH3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Dec 2008 19:07:29 -0500
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1LD5u4-0006UL-2c
	for linux-sparse@vger.kernel.org; Wed, 17 Dec 2008 23:34:08 +0000
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 7F360484B8
	for <linux-sparse@vger.kernel.org>; Wed, 17 Dec 2008 23:34:05 +0000 (GMT)
In-Reply-To: <20081217190534.24084.94887.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC725792077C6244CC92539D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alexey Zaytsev wrote:
[...]
> This problem may be addressed by changing bits_to_bytes to
> static inline int bits_to_bytes(int bits)
> {
>        return bits >=3D 0 ? bits / bits_in_char : -1;
> }

That's fine by me (although I've been using my version for ages now with
no apparent problems --- just out of interest, Clue is now using Sparse
to compile C into Lua, Javascript, Perl 5, Common Lisp, C and Java
moderately successfully).

> But it seems there is also a bug in sparse, as in
> ctype_declaration[] the bit_size of void_ctype is
> set to NULL, while gcc assumes sizeof(void) being 1.
> Currently sparse would generate wrong code for:
[...]
> unsigned long test1(void *p)
> {
>         return sizeof(*p);
> }

TBH, I don't think that's legal --- I know of several compilers that
will refuse to compile it, and gcc -pedantic produces a warning, which
means it probably falls into the 'undefined behaviour' bucket of the
standard. I can't find anything that specifically talks about sizeof
void, but 6.3.2.2.1 prohibits doing *anything* with the result of an
expression of type void, which sort of applies here.

Of course, I'm thinking about this from the sparse-as-a-compiler point
of view, where you're probably more interested in replicating gcc's
behaviour.

--=20
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =EF=BD=84=EF=BD=87=EF=BC=A0=EF=BD=83=
=EF=BD=8F=EF=BD=97=EF=BD=8C=EF=BD=81=EF=BD=92=EF=BD=8B=EF=BC=8E=EF=BD=83=EF=
=BD=8F=EF=BD=8D =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 http://www.=
cowlark.com =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82 "A line dancer near a graduated cylinder, the blithe spirit ins=
ide
=E2=94=82 some wheelbarrow, and a tomato are what made America great!" --=
--------------enigDC725792077C6244CC92539D--
