From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: sparse context warning problem ...
Date: Thu, 29 May 2008 11:54:33 +0200
Message-ID: <1212054873.16917.51.camel@johannes.berg>
References: <200805101724.04014.david-b@pacbell.net>
	 <200805140658.04018.david-b@pacbell.net>
	 <1212050823.16917.37.camel@johannes.berg>
	 <200805290239.13436.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d9dxoJqoVSpNni5kIg6L"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:45549 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbYE2Jzt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 05:55:49 -0400
In-Reply-To: <200805290239.13436.david-b@pacbell.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>


--=-d9dxoJqoVSpNni5kIg6L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > Yeah, I agree the locks aren't pointers, but really, it is a lot easier
> > for you to do that annotation than for sparse to figure it out.
>=20
> I was fairly sure you'd argue that!

Heh.

> > I blame these problems on whoever implemented sparse context tracking i=
n
> > the first place, documented the optional first expression parameter and
> > then didn't write any code for looking at the expression at all.
>=20
> Yeah, that Torvalds clown is always leaving stuff unfinished.  ;)

:P

> > static inline void netif_tx_lock_bh(struct net_device *dev)
> > 	__acquires(&dev->_xmit_lock)
> > {
> >         spin_lock_bh(&dev->_xmit_lock);
> >         dev->xmit_lock_owner =3D smp_processor_id();
> > }
> >=20
> > Conceptually, I think this is cleaner because inlines are treated more
> > like real functions then, but you may disagree.
>=20
> I disagree.  They *are* real functions, so treating them
> as such is the only reasonable option!

Well they used to be inlined in the context tracker too, and thus
typically do not have any annotations at all. So with these patches,
many new missing annotations show up.

> (Note by the way a convenience there:  the lock is easily
> described using just the function parameters.  I suspect
> that will be common, but not always true ...)

Yeah you can do this too though:

static inline lock_device(struct net_device *dev)
	__acquires(&dev->somelock)
{
	spin_lock(&dev->somelock);
}

and then "lock_device(a);" will increase the context "&a->somelock".

> Will it be possible to put annotations on methods declared
> in ops vectors?  Just today I was cleaning up some locking
> issues and had to start using a lock.  But I couldn't find
> any clear statement about the call contexts for some of the
> new lock/unlock calls ... I had to go look at other drivers
> to see an answer (and hope they weren't buggy).  It would
> have been nicer to just have "sparse" tell me the answers.
>=20
> (If right now that seems more like a research problem, I'd
> not be too surprised.  But I'd like to think that someday
> it should be practical to have kernel lockdep tools tell
> us about such things, and have such constraints verified
> during builds.)

I'll have to try. Let's see... Nope, doesn't work, even with the
variable context tracking. I agree that tt should, in theory, be
possible to do this, but I haven't figured out the magic yet. However,
it seems it could be an extension of the third patch I just posted
("allow context() attribute on variables")
=20
> > The status quo, however, has turned out to be unacceptable to users
> > because of the spinlock problem I mentioned above. Can we, based on an
> > evaluation of the problems I just outlined, either apply the patches I'=
m
> > about to send, or revert them to go back to the completely unchecked
> > contexts?
>=20
> Haven't seen the patches, but in principle I have no objection
> to finishing the lock context code.  Fixing all the kernel code
> to get better lock annotations will take time, but that's OK.
>=20
> What's probably more important right now is to make sure the
> annotations are simple and correct, so they can be built on
> over time.

Well, the foremost important thing is probably to figure out how we want
to name contexts, I'm using expressions such as "&dev->lock" for that,
and this doesn't actually track things like this properly:

dev =3D a;
spin_lock(&dev->lock);
dev =3D b;
spin_unlock(&dev->lock);

and will not complain in this case because the expression is different.
I didn't really think of that as much of a problem, but maybe it is? In
any case, if we want to allow that we'd have to use the pseudos for
context tracking and I fear that would be a lot more complex especially
wrt. function pointer passing, almost to the point where we'd have to
pretty much run the code.

johannes

--=-d9dxoJqoVSpNni5kIg6L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASD59V6Vg1VMiehFYAQK1Bg//R+Nc5GCz7PDpe/9NtmO3pXYBrKSzunZP
FTQ0hu/cSpUhi4eO/BnrEhA3v3FISeuUTXldH0dVWsIRE00dwWTyfZdv29fVEglU
eIcwZafnoVmIfMlmKFheQMeUv54GqfanMu1xiscRfKD/+hFf0st/+jGNGsNcWcoO
d88RQE3YlLoeuivL4UNsFBlfT4akAf9iKCBLPR4yYRO+u8M09ab2QViXPCldy/HE
YpoRsJZnyTYuXvJhBCO5pDpPrKVlUwI9570YPaLEGoAGc/yrruMGuckxliqiC7gh
5S5oeYzjljNiTCuAkoVt8b1hHqgCVXBOOyANMLMPXEJ2e32AP1tlzmO1OFIPgeiu
R8Q1VZPHmgzGbR3GwYeb/aPRXbLpK9VOGIgC9QxTO5Q2U6j2zgJ5/e13tKRYW2d8
FrYU15fFci0UQXDkr5WEywRg2s0IwJt3Lh1Us4LiWq5juSAuJ6/yOmon4fIsrLAM
ZflK84TPq9kqtat9lboiQqup9/qWwCBBjip3SyrNaqpR21pRxKAOIEOT7EqEHDyL
PH40xTteaZTrx3S/rf8xd5n3BlPsEKQibiUPfaVqUktxbtYEr5TbDwP+/Efr5JVn
qIQzp9Nwp9KlvM6Ld4vqkKQDv4SC90wKZ7modAUhjZn356c5nFJnvQnTbBdEPqc+
yWi0lJvMaJM=
=ppax
-----END PGP SIGNATURE-----

--=-d9dxoJqoVSpNni5kIg6L--

