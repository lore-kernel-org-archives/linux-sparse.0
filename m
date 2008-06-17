From: David Given <dg@cowlark.com>
Subject: Re: Writing compilers, and example.c vs compile-i386.c
Date: Wed, 18 Jun 2008 00:35:15 +0100
Message-ID: <48584A33.7080602@cowlark.com>
References: <4856F196.8020403@cowlark.com> <70318cbf0806161749u543fa338sf43a2ab787297eaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5D0C2A86F796072433AC381B"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:54970 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052AbYFQXf0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Jun 2008 19:35:26 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1K8kiP-0001FM-KG
	for linux-sparse@vger.kernel.org; Wed, 18 Jun 2008 00:35:53 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id C73352008D
	for <linux-sparse@vger.kernel.org>; Wed, 18 Jun 2008 00:35:21 +0100 (BST)
In-Reply-To: <70318cbf0806161749u543fa338sf43a2ab787297eaa@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5D0C2A86F796072433AC381B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Mike Frysinger wrote:
> this may be worth investigating as well:
> http://pcc.ludd.ltu.se/

That was actually where I started; it works pretty well, though after a
couple of hours of examining the code I realised that there was a good
reason why it looked like code that had been written 25 years ago and
then randomly hacked ever since. It's a little opaque, which is why I
ended up here.

Christopher Li wrote:
[...]
> I would strongly recommend using the example.c rather than compile-i386=
=2Ec.
> If you want to do any thing interesting with the back end at all, using=

> the linearize byte code is the way to go.

Yes, that's what I suspected --- being the more complicated file! Oh,
well, I've been examining it, and it's slow beginning to make sense.

However: I notice that the code seems to make use of OP_DEATHNOTE
instructions to mark hardregs as being dead. However, these are only
generated if track_pseudo_death(ep) is called --- and example.c never
calls this. It *is*, however, called if -vdead is specified on the
command line. Is this a bug in example.c or am I just misunderstanding
things?

(Also, the OP_DEATHNOTE instructions appear to occur *before* the
instruction that uses them last --- is this so that the instruction can
reuse the register is the code generator sees fit to do so?)

(In addition, I notice that once liveness tracking has been done phisrc
nodes get annotated with the desired shared register that the phi should
occupy; suddenly, the phi stuff all makes sense.)



(PS. Please don't cc me if you're also mailing the list --- I only need
one copy!)

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


--------------enig5D0C2A86F796072433AC381B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIWEo1f9E0noFvlzgRAi5ZAKCr1QyY71KAZiEf7TaR82tKyVt+YwCgt7Cu
s2/QORrMkFdwOry3vX3AGEc=
=kufV
-----END PGP SIGNATURE-----

--------------enig5D0C2A86F796072433AC381B--
