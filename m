From: David Given <dg@cowlark.com>
Subject: Re: Writing compilers, and example.c vs compile-i386.c
Date: Sat, 21 Jun 2008 00:46:24 +0100
Message-ID: <485C4150.2080508@cowlark.com>
References: <4856F196.8020403@cowlark.com>	 <70318cbf0806161749u543fa338sf43a2ab787297eaa@mail.gmail.com>	 <48584A33.7080602@cowlark.com> <70318cbf0806171741g4d099e92vf0c0e9d7588fd7d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig13F7119DF9D69868419A5705"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:36510 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289AbYFTXqd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Jun 2008 19:46:33 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1K9qJK-0002FI-7u
	for linux-sparse@vger.kernel.org; Sat, 21 Jun 2008 00:46:30 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 311062008D
	for <linux-sparse@vger.kernel.org>; Sat, 21 Jun 2008 00:46:29 +0100 (BST)
In-Reply-To: <70318cbf0806171741g4d099e92vf0c0e9d7588fd7d6@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13F7119DF9D69868419A5705
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
[...]
> BTW, you shouldn't take example.c too seriously per Linus' suggestion.

It does show the telltale signs of being hacked together on an
experimental basis, but it's proving invaluable as a source for getting
my own stuff working --- and it *is* working, I can actually generate
more or less correct code! (Assuming you like adding numbers together,
of course.) The register allocation algorithm example.c uses is
extremely noddy but seems to be reasonably effective; as my
'architecture' has a large but finite number of 'registers', all I
really need is something to cause dead registers to be reused, for which
this is perfectly adequate.

(I suspect that bolting on a real register allocator ought to be very
easy given that the code's already in SSA form. Maybe at some stage I'll
have a look, but register allocators really aren't my strong point.)

I do, however, still have a few other queries...

- how do you determine the scalar type of a pseudo?

For example, I haven't found any way yet of distinguishing between an
int and a float. I need to generate different code for these, but there
don't seem to be any relevant fields in pseudo_t. There isn't even
anything in the pseudo's storage structure. The instruction sometimes
has a size field, but these aren't unique. I may need this for other
things than float support; for example, I may need to generate special
pointer arithmetic code.

- if I wish to rewrite a basic block's instruction list --- for example,
to decompose instructions that use a non-register pseudo into two
instructions --- do I need to do anything other than iterate through the
bb's list and insert instruction nodes? Is there any additional
housekeeping to do? Naturally, I'd do this *before* calling
track_pseudo_death()...

- what does expand_symbol() do?

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


--------------enig13F7119DF9D69868419A5705
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIXEFTf9E0noFvlzgRAptpAKDJYAlUTW8R5iNBBMBomm7t69xoSQCgxYX0
Y2ItKK3FvSVWXpp4XJxPQIg=
=dzqe
-----END PGP SIGNATURE-----

--------------enig13F7119DF9D69868419A5705--
