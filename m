From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: sparse context warning problem ...
Date: Thu, 29 May 2008 10:47:03 +0200
Message-ID: <1212050823.16917.37.camel@johannes.berg>
References: <200805101724.04014.david-b@pacbell.net>
	 <1210466447.3646.3.camel@johannes.berg>
	 <1210715568.4279.35.camel@johannes.berg>
	 <200805140658.04018.david-b@pacbell.net>
	 (sfid-20080514_155811_765565_25ADCD72)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HL3YJ6PGCkWxEn0cZKEz"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:47062 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbYE2IsK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 04:48:10 -0400
In-Reply-To: <200805140658.04018.david-b@pacbell.net> (sfid-20080514_155811_765565_25ADCD72)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>


--=-HL3YJ6PGCkWxEn0cZKEz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > means to lock "&ohci->lock" when doing "spin_lock(&ohci->lock);" but
> > will treat it as locking the abstractly-named "lock" context, while on
> > UP/no-preempt the "spin_lock" macro is expanded by the preprocessor and
> > you will get "&ohci->lock" as the expression.
>=20
> Yeah, well the lock being acquired or released *IS* "ohci->lock",
> but the spinlock calls don't take the lock, they take pointers
> to it!
>=20
> If you were to argue that understanding pointers like that is a
> lot to demand of "sparse", I might agree.  But that won't change
> the fact that locks themselves are not pointers to locks.  ;)

Yeah, I agree the locks aren't pointers, but really, it is a lot easier
for you to do that annotation than for sparse to figure it out.

I blame these problems on whoever implemented sparse context tracking in
the first place, documented the optional first expression parameter and
then didn't write any code for looking at the expression at all.

The patch series I have posted a while ago (I'll repost) would fix the
existing problems with the context tracking patch Josh put in
(especially the problem that

spin_lock_irqsave(&a);
spin_unlock_irqrestore(&a);

currently gives a warning on some kernel builds because one is a macro
and the other is not), but has its own problems again with the RESULT
"macro" (you can only use it on a declaration, not an implementation),
but that is completely new so not really a problem I think.


A problem my patch series introduces, though, is the static inline one:
Currently, static inlines are inlined right into the function when
testing for locks but that is a bit complicated with expression tracking
because the expressions inside of the static inline look completely
different due to variable passing. Hence, I change that to not go in
there but evaluate the static inlines themselves. However, this means
that this

static inline void netif_tx_lock_bh(struct net_device *dev)
{
        spin_lock_bh(&dev->_xmit_lock);
        dev->xmit_lock_owner =3D smp_processor_id();
}


will now trigger a warning and you have to annotate inlines as well
(also to get the user checked properly):

static inline void netif_tx_lock_bh(struct net_device *dev)
	__acquires(&dev->_xmit_lock)
{
        spin_lock_bh(&dev->_xmit_lock);
        dev->xmit_lock_owner =3D smp_processor_id();
}

Conceptually, I think this is cleaner because inlines are treated more
like real functions then, but you may disagree.


The status quo, however, has turned out to be unacceptable to users
because of the spinlock problem I mentioned above. Can we, based on an
evaluation of the problems I just outlined, either apply the patches I'm
about to send, or revert them to go back to the completely unchecked
contexts?

johannes

--=-HL3YJ6PGCkWxEn0cZKEz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASD5thqVg1VMiehFYAQKoQhAArWyAH9UUn0QA/2mgRgr6+rMKCiy/u1yc
wUdMwRWLGkN+IrGn4a3L0tLY4KRJ/X8+Mi1xMNWzeglaCqJaYgIZIhKMetngmEFl
eTC2TdrYEDVp01XpKuUKmUnJXsXAAsUaP42TyHX1vsDeB9Wn4pKh+Yu76p+zN1VU
tCiSDRIJI7oI1hmJV+sgCtddVyDPAzO6rEAf80GsXSv7Hk5eQVw6P65DIej+a+7N
Y/2Ilooauvl1ya+7+8504qRG1HcARiAgZedsObJJrNuzVgLWklKxrxOR6Q+Ey6Zz
VYgqCZpnxWJu+8TxFPHo779LDyricKP6Jx5mmo6x6vvj5ipx8B3Tcv9DwWf/d+Kn
vXOfQ1y2zByUSdfNxwSvp0raObiCCkWYRtHeAUPzZupNseYLIzhxQO0jCAkF08do
LzqL6XTFKcxwnMS+CGfiJvUhd7jZuC9BaUFcPgnLHDmEE7YR6SP2WVsQN3SDsDIO
bePmHk9dbTjxXUMAlnfUAbv4IBH7v/9M5mwFHlNqa9KQteeVl7VScMn3alTK2pQt
Hg4M+ChgPsp2tBcmhtl+Wrz3ub4lbUg9zfUfw02jke2NQ5aD78hIWcdijp0d5o9K
CARGZaEc8UBRs3ko1jgJp9Cbf2/OqiCs9jL6p2HLa/rE37UJl6lvC4vLorZu6kbp
Atu9IhSTuIQ=
=1TML
-----END PGP SIGNATURE-----

--=-HL3YJ6PGCkWxEn0cZKEz--

