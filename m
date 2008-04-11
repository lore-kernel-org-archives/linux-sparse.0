From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Fri, 11 Apr 2008 13:06:54 +0200
Message-ID: <1207912014.13354.52.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
	 <200804101746.14457.philipp.reisner@linbit.com>
	 <1207842687.13354.12.camel@johannes.berg>
	 <200804101805.31854.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IkkyQkeWa5U+vrXxGk2r"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:37328 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYDKMIH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Apr 2008 08:08:07 -0400
In-Reply-To: <200804101805.31854.philipp.reisner@linbit.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org


--=-IkkyQkeWa5U+vrXxGk2r
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Managed to take a closer look now.

> > What's this "rdwr" etc. for? And "call"? Also, how are you planning to
> > handle nested contexts, where 1,1 doesn't cut it any >0,>0 is really
> > more like what we need?
> >
>=20
> I also use it to check a recusive lock mechanism.=20
>=20
> The sematics of what I implemented is:
> You simply use the __attribute__((context(ctx,in,out))) to
> annotate the context changes of functions.
>=20
> to annotate a variable, struct/union member or a function that
> a certain locking primitive is required for accessing it, you
> do it by=20
>=20
> __attribute__((require_context(ctx,min,max,"type")))
>=20
> ctx ... the expression that describes the locking primitive
> min ... the minimum of locks required of that locking primitive
> max ... the maximum allowed of locks of that locking primitive.
> type .. read, write, rdwr or call for the access type.
>=20
> So you can express you need to hold this and that locking=20
> primitive to write to something. But an other locking
> primitive might be sufficient for reading that something.
>=20
> The annotation for a variable foo protected by a recursive lock
> bar would be:
>=20
> int foo __attribute__((require_context(bar,1,99999,"rdwr")))

To be honest, that confuses me. I haven't been able to come up with a
way to make this test case I have result in a warning:

static void bad_macro1(void)
{
    m();
    a();
    r();
}

where a() is acquire(), r() is release() and m() should require the
lock, and all should be implemented as macros. I even tried playing with
dummy inline functions that are called from the macros.

As for read/write, what's wrong with encoding that in the context?

Something like
void read_lock(something) __attribute__((context(read_something,0,1)));
void write_lock(something) __attribute__((context(write_something,0,1)));

or similar. And if it has to be a parameter, why a string?

Another thing I actually like a lot about the fact that my patch changes
the warnings is that it tells you
 - which function caused the error
 - where that function is

I recently had the pleasure of digging through a huge switch statement
that looked like this:

function {

[lots of code]

lock();

[lots more code]

switch(something) {
=EF=BB=BFcase A:
	[lots of code]
	unlock();
	[lots of code]
	break;
[repeat a dozen times]
case M:
=EF=BB=BF	[lots of code]
	unlock();
=EF=BB=BF	[lots of code]
	// *** NOTE MISSING break;
case N:
	[lots of code]
	unlock();		// <----- this is where my code tells you the error is
	[lots of code]
	break;
[repeat another dozen times]
}

[lots more code in the function]

}		// <--- this is where current sparse tells you the error is


Also, my code tells you the function name, and not just "oh, some lock
context was wrong" :) I have just created another patch on top of mine
that will make the error look like this:

context.c:360:10: warning: context problem in 'warn_huge_switch': 'r' expec=
ted different context
context.c:360:10:    default context: wanted >=3D 1, got 0



I like the cond_lock() trick, but I was actually planning on expanding
the checking to switch() statements as well and I don't think we can
make it work there with such a trick.

Maybe something like
__attribute__((conditional_context(ctx,req,default,val=3Dctxchange,...)))

where you could have e.g.
=EF=BB=BF
__attribute__((conditional_context(L,1,0,1=3D1,-1=3D-1)))

Not sure yet though whether that is useful or not.


Finally, I think you have a bit of an inconsistency: You introduced the
require_context attribute, yet your context() macro still partially
fulfils that role, i.e. if you say that a function decreases a context
then you require that it gets one when called. Hence, extending that to
arbitrary context changes defined via the context attribute seems more
natural to me than to require using the require_context attribute for
positive assertions and the context attribute for negative assertions.

> PS: I just realized that there my e-mail client introduced linebreakes
>     in the first patch I posted. I will repost on request of course.

No worries, was easy enough to fix up.

johannes


--=-IkkyQkeWa5U+vrXxGk2r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/9GTaVg1VMiehFYAQJ60w/+Lx9416nBFmGixTYImaIsg42Ur1ppKI1G
/RLdTRJxw4XpwH0AVCYOn35r9Ct+PJpXzGBFHa8raTi5vqPpQUTxN1LyX1wAdmR+
gwmZAcsSdEyK8iKnYz7ZRMKYSWZuzV2r51SVcemVi8EFWWBg7ijyatvRw5E95yVt
90CE047w7olg11tZ8ChIRhWe+Uab8MVeHwgXm2y89Ly3CXktAr2UYo6UBnxUHsL0
pvz6tAw2pCE9ptghMurZCoi+FgbZU8JodSrRK/j8NDwBpZPJbdeYQQse97TO7+78
EMhuA33T1Y5lB4Fr0oAuj6K/b7C5z7RaAMHU0aZsUoMEQI4qGBbTzs9F6SefxyT1
xn/GRSirHwtppL3EqH/YzwZNaTLRZvgXfblu6QwD5VeImyNX4MpouTrqD43X1YgG
TTMA00rgU3vBW/mnWT1lWgCjIWet+3+YpkddnwH/PT/pcvRTm82MGmSe/xcLbkc+
mPTH4FZQblyWDa5EnZR/3U1BzHejCm1AhXWCC58Pt4CFx3kIAIVFKfs+1EYtBH25
08eF/GbU7xtbPx/DEr9/V5PraUrSXCufuygLcyUzMrnecRN7ZD4SIlXER9m4CGZt
qPfa6MFNdzdPDArqCuWUK0WWqz5da0PD27m20upo6XqRjDlleg2Dub/mcTatUG+0
KFD6/UpU7aU=
=lDEp
-----END PGP SIGNATURE-----

--=-IkkyQkeWa5U+vrXxGk2r--

