From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: sparse context warning problem ...
Date: Wed, 14 May 2008 16:06:16 +0200
Message-ID: <1210773976.29705.4.camel@johannes.berg>
References: <200805101724.04014.david-b@pacbell.net>
	 <1210466447.3646.3.camel@johannes.berg>
	 <1210715568.4279.35.camel@johannes.berg>
	 <200805140658.04018.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3zVv46mVq0qPjyqVP5w5"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:36560 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYENOHQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 May 2008 10:07:16 -0400
In-Reply-To: <200805140658.04018.david-b@pacbell.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-sparse@vger.kernel.org


--=-3zVv46mVq0qPjyqVP5w5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I used the OHCI example because it was a clear and readily
> available/reproducible example of how this is a regression;
> but I came across the problem with a different driver.  In
> that driver, I just made sure that the strings were now
> identical ... and the failures still came up with "sparse".
>=20
> That's on a UP build.  (Albeit with PREEMPT and all the
> debug options available ... since I'm debugging!)

I guess you get the spinlock_api_up.h version when building w/o SMP and
w/o CONFIG_DEBUG_SPINLOCK, but it doesn't really matter. The mismatch is
there one way or another.

> Yeah, well the lock being acquired or released *IS* "ohci->lock",
> but the spinlock calls don't take the lock, they take pointers
> to it!
>=20
> If you were to argue that understanding pointers like that is a
> lot to demand of "sparse", I might agree.  But that won't change
> the fact that locks themselves are not pointers to locks.  ;)

Well, yes, but for purposes of comparing the expression it would be a
lot simpler to change the code since otherwise sparse would have to be
aware of whether a function takes a pointer to a lock or not. I don't
see why one couldn't use the context tracking stuff for something not
passed via pointers when the callee doesn't need to take/modify the
context.

> > Ultimately, this whole problem comes from the fact that sparse accepted
> > adding an expression, documented it, but never complained if they
> > slightly mismatched as above.
>=20
> This still doesn't quite add up, though...

?

Take this to an old sparse:

__acquire(FOO);
__release(BAR);

and it will not complain about a context violation. My patches attempt
to change that, with fallouts.

johannes

--=-3zVv46mVq0qPjyqVP5w5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASCrx1qVg1VMiehFYAQJTKw//a2dw2+PIcR3T22eqoDXWOZfopHT2sHam
eh8hTr0e0fAJOhRDA4MnET3w8EYsAOG5uzyVeX/nb/Dy0w4SsCH7vbgoBl4VsRgF
7J6JlHY75/2Guq0KDe2NEdCbF8ima7jLbo3+JODQOcxSh+TQ04huwkvTYL74Nmnp
PE1hqzXDQvklvxB997lE0juZV2/RWIoo+fto6tp9BmRdQz6lYFDRPZQmVnW6cP42
s/A2n/11rImuLw3QljGIe7Ln9BXVLMkemAoesnTBWB5ueWPtgVwoWFgneck5uCRb
7mw0dAemTaf2TwQs2Wm9o/sYaZkh66StuCDb4UAqjVbWyduIddAeSlQeVyL6qQTy
KfLYrFr796zqv5/+UEl9955CVmX6lWLN9P+eKktU7xvYQ/BmmkTgMVabn5GG+xfQ
FjYLZvpnmb7+u0bG/UzqA2An0OOfCUuXROXfPeyaX8DMEBc0M/aETHk/q5g24nDo
VjPC4pz8GJITxKWRjHFgWdNxQFCiNNRRqAr2V64WYrgiH9+iu//jO8l/Ud5SxWRm
vA3xU+4HdX07Cd+NPVHeAk4eGmc2g1rsV7ukGx3u+UPU9yTszDcs7BmnxKCLEuEv
rIuc+7zd20ULNJ/fNtCYO8793dMo1fV9U4oPvWU7hrwafN9oHj81nLpxJfRHUD15
updysthdiig=
=umZm
-----END PGP SIGNATURE-----

--=-3zVv46mVq0qPjyqVP5w5--

