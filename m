From: David Brownell <david-b@pacbell.net>
Subject: Re: sparse context warning problem ...
Date: Wed, 14 May 2008 06:58:03 -0700
Message-ID: <200805140658.04018.david-b@pacbell.net>
References: <200805101724.04014.david-b@pacbell.net> <1210466447.3646.3.camel@johannes.berg> <1210715568.4279.35.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:35073 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756406AbYENN6G (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 May 2008 09:58:06 -0400
In-Reply-To: <1210715568.4279.35.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org

On Tuesday 13 May 2008, Johannes Berg wrote:

> Actually, it turns out my analysis was completely wrong.
>=20
> This is exactly the issue I pointed out in my other mail. You have:
>=20
> =EF=BB=BF__acquires(ohci->lock)
>            ^^^^^^^^^^
> but, on the other hand:
>=20
> spin_unlock (&ohci->lock);
>              ^
>=20
> I think you can fix this particular case by adding the & in the
> __acquires(), but that will only work for UP,

I used the OHCI example because it was a clear and readily
available/reproducible example of how this is a regression;
but I came across the problem with a different driver.  In
that driver, I just made sure that the strings were now
identical ... and the failures still came up with "sparse".

That's on a UP build.  (Albeit with PREEMPT and all the
debug options available ... since I'm debugging!)


> for actual spinlocks my=20
> other patches will be needed, because w/o my patches sparse will, on
> SMP, not be able to see that
>=20
> void __lockfunc _spin_lock(spinlock_t *lock)            __acquires(lo=
ck);
>=20
> means to lock "&ohci->lock" when doing "spin_lock(&ohci->lock);" but
> will treat it as locking the abstractly-named "lock" context, while o=
n
> UP/no-preempt the "spin_lock" macro is expanded by the preprocessor a=
nd
> you will get "&ohci->lock" as the expression.

Yeah, well the lock being acquired or released *IS* "ohci->lock",
but the spinlock calls don't take the lock, they take pointers
to it!

If you were to argue that understanding pointers like that is a
lot to demand of "sparse", I might agree.  But that won't change
the fact that locks themselves are not pointers to locks.  ;)


> Ultimately, this whole problem comes from the fact that sparse accept=
ed
> adding an expression, documented it, but never complained if they
> slightly mismatched as above.

This still doesn't quite add up, though...

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
