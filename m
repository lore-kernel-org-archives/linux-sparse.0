From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: sparse context warning problem ...
Date: Tue, 13 May 2008 23:52:48 +0200
Message-ID: <1210715568.4279.35.camel@johannes.berg>
References: <200805101724.04014.david-b@pacbell.net>
	 (sfid-20080511_023054_226815_6D0BCE82)  <1210466447.3646.3.camel@johannes.berg>
	 (sfid-20080511_024133_180993_8E974B71)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gOdyOnYGXNi+XdZ6PbPT"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:52094 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYEMVxo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 May 2008 17:53:44 -0400
In-Reply-To: <1210466447.3646.3.camel@johannes.berg> (sfid-20080511_024133_180993_8E974B71)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-sparse@vger.kernel.org


--=-gOdyOnYGXNi+XdZ6PbPT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> >   static void
> >   finish_urb(struct ohci_hcd *ohci, struct urb *urb, int status)
> >   __releases(ohci->lock)
> >   __acquires(ohci->lock)

> > But current versions of "sparse" complain (wrongly):
> >=20
> >   drivers/usb/host/ohci-q.c:66:2: warning: context imbalance in 'finish=
_urb': __context__ statement expected different context
> >   drivers/usb/host/ohci-q.c:66:2:    context '<noident>': wanted >=3D 0=
, got -1


> However, I took __releases and __acquires to mean that this function
> *changed* the context, doing both doesn't really make much sense. I
> think the function should actually be declared
>=20
> static void
> finish_urb(...)
> __requires(ohci->lock)
> {...}
>=20
> where __requires is (for sparse) defined as
>=20
> #define __requires(x) __attribute__((context(x,1,1)))

Actually, it turns out my analysis was completely wrong.

This is exactly the issue I pointed out in my other mail. You have:

=EF=BB=BF__acquires(ohci->lock)
           ^^^^^^^^^^
but, on the other hand:

spin_unlock (&ohci->lock);
             ^

I think you can fix this particular case by adding the & in the
__acquires(), but that will only work for UP, for actual spinlocks my
other patches will be needed, because w/o my patches sparse will, on
SMP, not be able to see that

void __lockfunc _spin_lock(spinlock_t *lock)            __acquires(lock);

means to lock "&ohci->lock" when doing "spin_lock(&ohci->lock);" but
will treat it as locking the abstractly-named "lock" context, while on
UP/no-preempt the "spin_lock" macro is expanded by the preprocessor and
you will get "&ohci->lock" as the expression.

Ultimately, this whole problem comes from the fact that sparse accepted
adding an expression, documented it, but never complained if they
slightly mismatched as above.

johannes

--=-gOdyOnYGXNi+XdZ6PbPT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASCoNr6Vg1VMiehFYAQL9JQ//Yn8q3EsN49uvFWo8ByvPUHgwTX8TJk55
IMCAfJhFpgZen0HAI5kC77SsuTlbSVHNWIuAjkViIS3yNBhnEXNGNQGa68k7be6X
7iGVRaiKbRAGF/gpooi62dJOragyCZATdTeMj52jUc35ZiEyI0tKVeaaq37x4ZKP
m7wwe7NKXZ7Ism7hnVMry5v1FTKoJ4do9DOKLUsz2h9x8e9fvtgwtytcwfIiOZG1
Whnu0W78QtRfaGh9FvZ7Zic0TxStAjxr7C1AWpaXA88mmIjU/Xk7UC7imdTVhWbB
wrN4GTc86WfYTOhJSch4Ok71yYEWtKiK8+EoUlZ+7Ld9iYHkSNsGEPc3C7fHWPHc
zvxLEpqEfHEvo1KBeW6OS8oZkb4NVAXCK/0VdO0oX5ozifFQTpx2kuBoY7C//yH0
qcf2Qo/U2Rdz2CkBYklDKo3KdWfYBqXEDwcwG9viSkXzzYoKnDZPqXuP58mzoAfY
My3qqHteWF1h9VoXTI04vvulG8DN7xHjGgw7DbX01sBD0wpk/nXO/r7chD9iS80Z
qos4Bf2MuPfW8Zblx2Il2+RL1Sauy5983bGWC9apa2dX0694B0lcP2Lko0/kMK3b
wcxPgaUxGASJHaJjgMzql4QWCNAfuoAXuhn9tAx3SfsfG7FROx+3+VtusJOzQu7V
2aAw9DL3VgU=
=NTpO
-----END PGP SIGNATURE-----

--=-gOdyOnYGXNi+XdZ6PbPT--

