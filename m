From: David Given <dg@cowlark.com>
Subject: Re: `char * s = "abc";' causes compile to crash with a segfault
Date: Wed, 29 Apr 2009 23:43:15 +0100
Message-ID: <49F8D803.6080000@cowlark.com>
References: <op.us51m0w9ucb9g9@home-5db3af48a> <49F8C1EB.5010909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:41822 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbZD2Wsv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Apr 2009 18:48:51 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1LzIa9-00057L-4C
	for linux-sparse@vger.kernel.org; Wed, 29 Apr 2009 23:48:49 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 5372120081
	for <linux-sparse@vger.kernel.org>; Wed, 29 Apr 2009 23:48:43 +0100 (BST)
In-Reply-To: <49F8C1EB.5010909@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik wrote:
[...]
>> Just out of curiosity, is sparse stable enough in general to be used
>> as a full-fledged front-end for a C compiler?
>=20
> As long as you don't do super-weird, non-standard C:  sure.

Well --- I did find a whole bunch of bugs when working on Clue. OTOH
that was a while ago, so some of them might have been fixed by now. Loo=
k
back in the archives for 'Odd sparse behaviour' posted on 2008-07-06,
and 'Odd behaviour with OP_SCAST' posted on 2008-09-08.

In addition, I found a number of places where minor tweaks to what data
Sparse keeps around can make a compiler writer's life much easier; for
example, keeping more type data makes finding the type of a pseudo much
easier. There's a combined patch shipped with Clue that fixes and
enhances a bunch of this stuff:

http://cluecc.svn.sourceforge.net/viewvc/cluecc/clue/sparse.patch?revis=
ion=3D34&view=3Dmarkup

(In fact, if you're generating llvm assembly directly, you may find it
easier just to add a backend to Clue rather than write your own, er,
middle-end --- a lot of the simplifications Clue does for languages lik=
e
Javascript also apply to llvm bitcode.)

<plug> Did I mention that Clue is now converting C into Java source tha=
t
runs at 40% of compiled C? </plug>

- --
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =EF=BD=84=EF=BD=87=EF=BC=A0=EF=BD=83=
=EF=BD=8F=EF=BD=97=EF=BD=8C=EF=BD=81=EF=BD=92=EF=BD=8B=EF=BC=8E=EF=BD=83=
=EF=BD=8F=EF=BD=8D =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 http:/=
/www.cowlark.com =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82
=E2=94=82 "People who think they know everything really annoy those of =
us who
=E2=94=82 know we don't." --- Bjarne Stroustrup
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJ+Nf6f9E0noFvlzgRAvpIAKCcJG0/SZ0mbx5Iel0iR2GbfJpclACgiQuw
/pkelbkI9I0FkdXqX/bTbQ0=3D
=3D581X
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
