From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: sparse context warning problem ...
Date: Sun, 11 May 2008 11:46:26 +0200
Message-ID: <1210499186.3646.16.camel@johannes.berg>
References: <200805101724.04014.david-b@pacbell.net>
	 <1210466447.3646.3.camel@johannes.berg>
	 <200805102018.13358.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E9zVpKqWXIyWVSk2l2p+"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:41097 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYEKJqn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 11 May 2008 05:46:43 -0400
In-Reply-To: <200805102018.13358.david-b@pacbell.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-sparse@vger.kernel.org


--=-E9zVpKqWXIyWVSk2l2p+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-05-10 at 20:18 -0700, David Brownell wrote:
> On Saturday 10 May 2008, Johannes Berg wrote:
> > This is probably my mistake.
> >=20
> > However, I took __releases and __acquires to mean that this function
> > *changed* the context, doing both doesn't really make much sense. I
> > think the function should actually be declared
> >=20
> > static void
> > finish_urb(...)
> > __requires(ohci->lock)
> > {...}
> >=20
> > where __requires is (for sparse) defined as
> >=20
> > #define __requires(x) __attribute__((context(x,1,1)))
>=20
> ISTR suggesting special syntax for this to Linus (this was way
> back when "sparse" was just starting) and he wanted to just do
> it by having those two attributes.
>=20
> So at this point, I'd want to see the regression fixed (and the
> tests updated to avoid this in the future) before exploring any
> alternative syntax for kernel annotations.

Yeah, true, on the other hand, if/when Josh merges my other patches then
most kernel annotations will have to be changed anyway because up to
before the patch that is already in sparse wouldn't flag this:

spin_lock(&lock);
rcu_read_unlock();

because it didn't care *at all* about the expression inside __acquire()
and thus a lot of usage crept in that isn't really usable.

With my future patches, I'm even binding the symbols, so that

void spin_lock(spinlock_t l) __acquire(l);

will flag errors with

spin_lock(&a);
spin_unlock(&b);

while right now it would just treat them both as the context "l".

So I expect that it will not be possible to not "regress" in that sense
because the current annotations are simply messed up since sparse didn't
care about the name inside __acquire()/__release() at all!


However, it's probably fairly easy right now to treat both of them as
being merged together which seems the only sensible things to do anyway
if such a situation is encountered. I'll look into it.

johannes

--=-E9zVpKqWXIyWVSk2l2p+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASCbAcaVg1VMiehFYAQLlVhAAo2Ph7MNobSx+RBhe3NN2oTexwXK9jhpF
AxM9re6pNu6Y1WW69KW909r1HpXKZIze/O1naj6+yr8ms+AZWHF8EmHMwp0fK/Wt
8nAkESBk8uCP+uzdSWUIctY4hv3lVi6tHPMXDOe9xwb3balkQVC/6s7xs0WQHz7c
s8l5MKP394Hybwm792BgrdJeJrK4WbWyiSr2fZMw3scH3lxUM9DjyZNsM4JlmPjd
ZmM1VPGCBCkfoweiw9ipHwjuCu4esSCsMjGcwloWM1eVg27zTPDryQzOGmHgGPUO
Fz6ZdnNprGIq8w+wEIoAGaOBkmkBvEehty9r8lUkjLd59HGMz8QgKEdfNnz1R1Bg
Ug4xvYh+hGhezPRit3eh5fAjhl76GEjUnZTwdtmzctTPKw0+VblbRQ7DKl2YL0LO
r9YXTIdzqs7vfLZuTDBiXuOPtZ51tS43aI78855iR866iNcpMjmf7AaO7ia/cjFi
xjRwujxTHjD07wHrGn+kFmQhEScSXvUkhwTCIxwclVhQkmPl47Yuiv5zgq7c6tKx
xkmw7vbTY8238RKdHgVYI69cJM40rlMqT6xru0pdkTVbDWM2eBlARVXV1dYR1ac5
pmWr4FGGvCALkt0eVJzAIEM6SWoJNSDWqA+tRqCn6iI6NIKeYYtv/5/CyDFB+d5K
b2JMtkNJ9ks=
=L2O2
-----END PGP SIGNATURE-----

--=-E9zVpKqWXIyWVSk2l2p+--

