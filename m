From: David Given <dg@cowlark.com>
Subject: Re: Pointer arithmetic error
Date: Sun, 29 Jun 2008 01:30:18 +0100
Message-ID: <4866D79A.4000402@cowlark.com>
References: <486428D7.8080603@cowlark.com>	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>	 <4864C710.8000208@cowlark.com>	 <1214565644.20755.80.camel@tara.firmix.at>	 <4864F31C.3090606@cowlark.com>	 <1214577926.20755.98.camel@tara.firmix.at>	 <48650B35.5040505@cowlark.com> <70318cbf0806271101n2f9a65buc72764ee97f9ced9@mail.gmail.com> <486578A9.7000900@cowlark.com> <48658B28.6010301@numba-tu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC919F0488A2E2F36A40F3475"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:56591 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbYF2AaZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jun 2008 20:30:25 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KCkol-00021S-T4
	for linux-sparse@vger.kernel.org; Sun, 29 Jun 2008 01:31:00 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 9ED742008D
	for <linux-sparse@vger.kernel.org>; Sun, 29 Jun 2008 01:30:20 +0100 (BST)
In-Reply-To: <48658B28.6010301@numba-tu.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC919F0488A2E2F36A40F3475
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tommy Thorn wrote:
[...]
> Yes, but it would have been better to have kept all the white space
> changes for a separate change so we could just see that relevant change=
s.

Corrected; turned out it had been so long since I've used a diff that
didn't use my alias I'd forgotten you have to explicitly tell it to
ignore white space.

> This introduces divides all over the place for all users, replacing a
> very cheap constant shift with an expensive divide. All sparse users
> would be paying the cost for a feature that is useful for 1 user, I
> think we should perhaps think carefully about this.

I really don't think this is an issue. Certainly, a division by a
variable is more expensive than a shift by a constant... but you'd have
to do billions of them before anyone actually started to notice. If it
really did turn out to be an issue, it would be simple enough to change
later to "value >> bits_in_char_power_of_2".

> One obvious solution would be to introduce a BITS_IN_CHAR macro in
> target.h defaulting to 8 and let "exotic" architectures redefine it to
> bits_in_char. This is very similar to the approach GCC is using.

The problem with this approach is that it involves recompiling all of
sparse for each target, which is a bit user unfriendly. Currently all
configuration can be done at run time, which allows such nice features
as having all potential back-ends share the same code via shared librarie=
s.

> On a completely unrelated node, I'm excited to see your work on using
> sparse for compilation. Hopefully your experience will lead to it being=

> easier for the next guy. I would like to see sparse target for a simple=

> abstract machine, but I so far haven't had time to work on it.

sparse is working rather well, and seems to be one of the better
compiler front ends that I've found. The linearising support is
particularly helpful. I have, however, been finding that the learning
curve is rather steep --- the API shows a lot of signs of having grown
organically over time --- and I've had to build big chunks of code that
I'm sure are unnecessary. For example, in order to generate the right
kind of code, I need to figure out whether a pseudo contains an integer,
float or pointer. The only way I've found out to do this is to
recursively follow the chain of pseudo->def pointers until I find an
instruction with enough type information attached to it to figure it
out. I'm sure there must be an easier way of doing this...

(BTW, given a function symbol, how do I find its return type? I can find
the list of arguments, but there's nothing in struct symbol that seems
to refer to the return value...)

I am intending to release my project once done, of course, and I hope
people will find it useful, but I'm not sure how much general use it
will be; I've basically ripped out and replaced the register allocator /
storage mechanism from my back end as I didn't understand it and didn't
need the complexity. That should probably all get rewritten properly at
some stage, but right now I'm focusing on getting things working...

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


--------------enigC919F0488A2E2F36A40F3475
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIZteaf9E0noFvlzgRAuIyAJ4gy7bY+x7Ltk1ppAlXTvNTaNYUOQCgtzlu
IxuSBRaCao39GdUKHwDvFb0=
=RKo7
-----END PGP SIGNATURE-----

--------------enigC919F0488A2E2F36A40F3475--
