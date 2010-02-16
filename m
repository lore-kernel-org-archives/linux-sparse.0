From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: Defect in linearization of short circuit &&
Date: Tue, 16 Feb 2010 10:28:02 +0100
Message-ID: <1266312482.3433.33.camel@thorin>
References: <4B77FD0F.50401@googlemail.com>
	 <4B78655D.2080007@googlemail.com>
	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
	 <4B799CA6.70807@googlemail.com>
	 <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
	 <4B79AC03.4010608@googlemail.com>
	 <70318cbf1002151311g103dbc27q3b89ae9804747684@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:54137 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762Ab0BPJj3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Feb 2010 04:39:29 -0500
In-Reply-To: <70318cbf1002151311g103dbc27q3b89ae9804747684@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jacek =?UTF-8?Q?=C5=9Aliwerski?= <sliwers@googlemail.com>, linux-sparse@vger.kernel.org

On Mon, 2010-02-15 at 13:11 -0800, Christopher Li wrote:
> 2010/2/15 Jacek =C5=9Aliwerski <sliwers@googlemail.com>:
> >
> > Please, check my case.  The condition is:
>=20
> I did, I did not see any thing wrong with it.
>=20
> >
> > if (st && st->other && st->value > i && i > 0)...
> >
> > Obviously, if st is NULL, then the execution should be transferred
> > immediately to the else branch.  But it does not.  It skips the sec=
ond test
> > and goes directly to the third one: st->value > i.  If a compiler w=
as built
> > with sparse as a frontend, execution of the generated code would en=
d up with
> > a segmentation fault.  And this code is perfectly valid.
>=20
> I totally agree the source code is valid.
> I just haven't see the seg fault part.
>=20
> $ ./test-linearize parser_check.c
> parser_check:
> .L0x7f4e12de3130:
> 	<entry-point>
> 	br          %arg1, .L0x7f4e12de32e0, .L0x7f4e12de3250
I assume this means "if %arg1 =3D=3D NULL goto .L0x7f4e12de32e0 else go=
to .L0x7f4e12de3250"

> .L0x7f4e12de32e0:
> 	load.32     %r3 <- 4[%arg1]
> 	br          %r3, .L0x7f4e12de3208, .L0x7f4e12de3250
>=20
> .L0x7f4e12de3208:
> 	load.32     %r5 <- 0[%arg1]
> 	setgt.32    %r7 <- %r5, %arg2
> 	phisrc.1    %phi1 <- %r7
> 	br          .L0x7f4e12de3298
>=20
> .L0x7f4e12de3250:
I assume this is the "i > 0" check.
> 	phisrc.1    %phi2 <- $0
> 	br          .L0x7f4e12de3298
>=20
> .L0x7f4e12de3298:
> 	phi.1       %r8 <- %phi1, %phi2
> 	setgt.32    %r10 <- %arg2, $0
> 	and-bool.1  %r11 <- %r8, %r10
> 	br          %r11, .L0x7f4e12de3178, .L0x7f4e12de31c0
>=20
> .L0x7f4e12de3178:
> 	call        execute_a, %arg1, %arg2
> 	br          .L0x7f4e12de3328
>=20
> .L0x7f4e12de31c0:
> 	call        execute_b, %arg1
> 	br          .L0x7f4e12de3328
>=20
> .L0x7f4e12de3328:
> 	ret
>=20
> In the fast test, the false branch is L0x7f4e12de3250.
> Which is doing the (i > 0) part and it is safe to do so.
Are saying that he "i >0 " test done while "st =3D=3D NULL"?
This is actually wrong as it shouldn't be done (independent of the used
variables and especially if the expression has side effects).

> It skip the two load.32 operation. It will not generate the seg fault=
=2E
> I still don't see where the is seg fault part. Please let me know if =
I am
> missing some thing obvious.

Or am I missing something (presumbly) obvious?

	Bernd
--=20
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
