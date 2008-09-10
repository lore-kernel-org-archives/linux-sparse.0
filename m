From: David Given <dg@cowlark.com>
Subject: Re: Odd behaviour with OP_SCAST
Date: Wed, 10 Sep 2008 21:48:16 +0100
Message-ID: <48C83290.9010206@cowlark.com>
References: <48C2F2BC.9030606@cowlark.com> <70318cbf0809081402i7c7e80c4g9b45988b8cf2e0fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB252D7AD289AE7B2A6E898D5"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:38580 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYIJUs0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Sep 2008 16:48:26 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KdWbw-00008l-9D
	for linux-sparse@vger.kernel.org; Wed, 10 Sep 2008 21:48:24 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id E52172006F
	for <linux-sparse@vger.kernel.org>; Wed, 10 Sep 2008 21:48:21 +0100 (BST)
In-Reply-To: <70318cbf0809081402i7c7e80c4g9b45988b8cf2e0fc@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB252D7AD289AE7B2A6E898D5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Chris Li wrote:
[...]
> Sparse assume that float and double have different size than int.
> On the linearized instruction level, it does not have the full type
> information any more. All it got is the size of the type. So it is
> tricky to distinguish int vs float.

Here's another one; and this is with a stock unmodified sparse, too, so
I know it's not my fault.

extern double pow(double x, double y);
double d(double p)
{ return pow(2, p); }

-->

	call.64     %r2 <- pow, $2, %arg1
	ret.64      %r2

(Again with test-unssa, which seems to be convenient for displaying
intermediate code.)

[...]
> The change require the instruction to have more type
> information than size. I am tempting to just put a full
> ctype pointer there.

In fact, that's what I've got in the private patch I'm using for Clue,
although I'm only using it for determining the types of pseudos; I just
hacked alloc_typed_instruction() (which knows the type) to add it. No
other changes.

(This, BTW, is for a Clue backend that targets C. Yes, I can now compile
C into C, which I'm sure might be useful to *someone*... due to getting
ints and doubles confused some of the benchmarks are producing the wrong
results, but the Whetstone one appears to be reasonably intact and
*claims* that C compiled via sparse and Clue into C gets about 90% of
the performance of direct compilation. Even though the benchmark is
known to be poor and unreliable anyway, that's still indicative of
sparse doing a pretty decent job...)

--=20
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =EF=BD=84=EF=BD=87=EF=BC=A0=EF=BD=83=
=EF=BD=8F=EF=BD=97=EF=BD=8C=EF=BD=81=EF=BD=92=EF=BD=8B=EF=BC=8E=EF=BD=83=EF=
=BD=8F=EF=BD=8D =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 http://www.=
cowlark.com =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82
=E2=94=82 "All power corrupts, but we need electricity." --- Diana Wynne =
Jones,
=E2=94=82 _Archer's Goon_


--------------enigB252D7AD289AE7B2A6E898D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIyDKTf9E0noFvlzgRAtnEAJsGm7wq/BcMmXCQBmB4wrWwHy+/PgCdGVEC
S8L1GcKILefKNPqmrMiJ3VM=
=JaLH
-----END PGP SIGNATURE-----

--------------enigB252D7AD289AE7B2A6E898D5--
