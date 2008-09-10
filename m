From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 6/9 v2] check context expressions as expressions
Date: Wed, 10 Sep 2008 23:34:00 +0200
Message-ID: <1221082440.3804.40.camel@johannes.berg>
References: <20080529085402.814224000@sipsolutions.net>
	 <20080529085516.930777000@sipsolutions.net>
	 <1221032003.12266.4.camel@johannes.berg>
	 <70318cbf0809101221n53dd06c2x19c68a1df336cb35@mail.gmail.com>
	 (sfid-20080910_212133_681576_089D6D0F)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mokhWGNv5oH3lKGyS9ZJ"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:49365 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbYIJVfR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Sep 2008 17:35:17 -0400
In-Reply-To: <70318cbf0809101221n53dd06c2x19c68a1df336cb35@mail.gmail.com> (sfid-20080910_212133_681576_089D6D0F)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org, Harvey Harrison <harvey.harrison@gmail.com>


--=-mokhWGNv5oH3lKGyS9ZJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-09-10 at 12:21 -0700, Christopher Li wrote:

> Nah, you pretty should never need to do that.
> Ident equal should just need to compare ident1 =3D=3D ident2.
>=20
> All ident has been hashed. Same ident, should show up
> as same pointer. Doing strncmp again is unnecessary.
>=20
> I feel that this patch  is adding too much hack to the
> sparse front end. At the very least, can you
> just change __context__ parsing to accept symbol expression
> and the let the checking back end to do the code motions
> stuff?

Can you explain?

> I haven't study the new context checking very carefully.
> I actually prefer the Linus's  old simple context checking.
> Yes, that does not distinguish which symbols taking the lock.
> But other than that it is working and counting the number
> correctly. And, it is very simple.

Well, yeah, it's very simple, and that doesn't help. And it's not about
cross-function checking either:

extern spinlock_t a;

spin_lock(&a);
rcu_read_unlock()

will not result in an error which is a pain.

> The new context checking seems able to do more features.
> But it has too many sore spots. I vote for back it out.

I don't care, I don't have any more cycles to burn on this. For all I'm
concerned it works pretty well and is a HUGE improvement over the
current sparse which
 * doesn't tell you what line the error really is in, it only warns
   about the last line of the function
 * isn't able to check different contexts despite documenting it
   (see above)

> Instead of keep adding more hacks to fix up the problem. I
> think we should step back and ask ourselves what do we really
> want to achieve.

See above.

> The fundamental problem I saw here is that, sparse does not
> support cross function checking. There is no good way to save
> some analyzed result for some function and used it later by other
> function. That is why we actually have to put __context__
> around so many functions. The __context__ describe what
> these functions in forms of source code annotation. There is
> only so much we can do with source code annotations.
> I am not saying that annotation is not useful. I agree source
> code annotation helps on the source code reading. But it
> shouldn't limit checker only use the annotations. The checker
> should be able to draw intelligent conclusions, by looking the
> the function source code itself.

Actually, I kinda disagree. Annotating *each and every function* with
the locks it requires is _very_ useful, not just for sparse but also for
human readers of the code. Hence, I don't just want sparse to check
across functions, I want to be able to tell people what to do for
calling a given function as well. The fact that sparse can check my
annotations is great, but having them would be useful without that as
well.

> e.g. Why do we have to annotate foo_lock(&bar->lock) will take a lock
> on &bar->lock? The checker should be able to find out foo_lock() just
> callers some lower level locking functions. For example,  let say if we
> can force foo to be inlined into the caller even foo is not declared as
> inline. Then there is no need to annotate foo itself. The caller see
> exactly what foo does.

It used to be like that. But I'm arguing (and others backed me up on
this) that inlines are really just functions and as such should be
annotated, not magically inlined into the code and then checked as
sparse behaves right now.

> So, I think we should implement cross functions checking capability
> systematically rather than putting more hacks on source code
> annotation. The writer patch I send out earlier is one step towards it.
> I will write up more detail proposal.

Please don't focus on cross-function checking so much. Having different
contexts is way more desirable, and cross-function checking probably is
_not_ desirable in that you _want_ the annotations.

johannes

--=-mokhWGNv5oH3lKGyS9ZJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJIyD1FAAoJEKVg1VMiehFYWHwP/jgsKCOrCncTS128dcRhi6Cn
dFjgqt+ReCLVOSMxr+Y7Rw002h8jIISoU2NEwGQbhw9PyHWhGtu7cUWNg9TO989p
nf+QaVmF6SyGtR8hVZKwrz9+o+RkH44QpI1BcxC4Cp8d0uU2NkBJH/4U5YYh7fun
XTc2M/l80WlXnZBrqQ+FhkasylcNtgNfkiDenSYsAWUTN39OB+svTyJL4prtpwBA
XLlXMprkD6RnrBBtIYSQPzrfRAItOYQeBfliJ9M/94Fo/JbqFzF278fmzUPUeFQD
nDtqosAhFieTnl3JVxBboPOlMjrQkzf0M/qn+9SEkGMO1aBkKbbffmn66F20ba9R
osfGMfbWIxIXbZrkZODbhO8IeqB9bA8MZpkJWHz3vqCrp8UjYCmsGdDiMrmhHJAR
u/bmxEK/2msNjZQrC6yjOrNqD4t5HIynI4HzBvPX1ODJ118m7cxzuUXFXG+MKywL
a86OFVxLkuS3bWHwaMn7Mp7PW9gvXrUPHvW8VrcrN7/VD/2gZnIWTWvoe/SoBLOv
lyG3Z6eDPi43eQEyrqzD2SY505YQrd9eZtT/53ZtemFSPeAu8Qzn+Ci5i/Ghumw0
NdVw8LA6SuCbvzEAUa0MidLxODF9SBD02IJtQczfXxOXW3GoF7DEfBXv+fNh5zJp
BpyOTAjK8UUhdEXNWpUy
=7MAh
-----END PGP SIGNATURE-----

--=-mokhWGNv5oH3lKGyS9ZJ--

