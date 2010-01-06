From: Christopher Li <sparse@chrisli.org>
Subject: Re: Detection of locking one lock twice
Date: Tue, 5 Jan 2010 22:58:37 -0800
Message-ID: <70318cbf1001052258j407e52d2j6adabef88558d7f1@mail.gmail.com>
References: <1261440567.5039.12.camel@localhost.localdomain>
	 <20100104074825.GC2423@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:22178 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab0AFG6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Jan 2010 01:58:38 -0500
Received: by qw-out-2122.google.com with SMTP id 8so2125076qwh.37
        for <linux-sparse@vger.kernel.org>; Tue, 05 Jan 2010 22:58:38 -0800 (PST)
In-Reply-To: <20100104074825.GC2423@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Petr Muller <afri@afri.cz>, linux-sparse@vger.kernel.org

On Sun, Jan 3, 2010 at 11:48 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
>> void fction(int a)
>> {
>> =A0 lock();
>> =A0 lock();
>> =A0 unlock();
>> =A0 unlock();
>> }
>> Sparse gives no warning in this code - I would expect that second ca=
ll
>> to lock() would violate the 'in' limit of __acquires attribute, but =
it
>> does not. I'm wondering if this is actually a problem in sparse, or =
am I
>> doing something wrong?

Sorry I am late to the party. I think sparse does not complain on this
code because sparse has no way to track *which* lock it is taking.
Some thing like:

lock(A);
lock(B);
unlock(B);
unlock(A);

It is perfectly fine. So sparse is not suppose to complain there.

> As far as I know, Sparse currently treats the "in" context as a minim=
um
> requirement, not an exact requirement. =A0Thus, a context of 0 ends u=
p
> meaning "may or may not hold the lock", while 1 means "must hold the
> lock at least once".

You can interpret it that way, but that is not how I see it.

The context is not suppose to go to negative, that is why we have 'in' =
and 'out'
context. When a function perform unlock, you are suppose to give a
positive value in
'in' context to avoid geting negative. As long as the context does not
go negative,
sparse only care about the delta of 'in' and 'out' value. It counts
the context to
the exact number. See the following code:

 	if (insn->opcode =3D=3D OP_RET)
		return entry !=3D exit ? imbalance(ep, bb, entry, exit, "wrong count
at exit") : 0;

So I don't think it is a bug. If you disagree, please give me more deta=
il.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
