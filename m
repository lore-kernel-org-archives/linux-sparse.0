From: Christopher Li <sparse@chrisli.org>
Subject: Re: User question for __context__ or similiar
Date: Wed, 28 Oct 2009 14:25:43 -0700
Message-ID: <70318cbf0910281425p2db9d304kd2e6f0f2133fd41@mail.gmail.com>
References: <loom.20091028T113843-308@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:60356 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbZJ1VZm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Oct 2009 17:25:42 -0400
Received: by iwn10 with SMTP id 10so916764iwn.4
        for <linux-sparse@vger.kernel.org>; Wed, 28 Oct 2009 14:25:45 -0700 (PDT)
In-Reply-To: <loom.20091028T113843-308@post.gmane.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Holger Freyther <zecke@selfish.org>
Cc: linux-sparse@vger.kernel.org

On Wed, Oct 28, 2009 at 3:56 AM, Holger Freyther <zecke@selfish.org> wr=
ote:
>
> My first thought was that this almost works like locking in the kerne=
l
> but I was wrong. I have used the CHECKER macros from linux/compiler.h
>
> and changed code to
>
> struct gsm_subscriber *subscr_get(struct gsm_subscriber *subscr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0__acquires(subscr);
> struct gsm_subscriber *subscr_put(struct gsm_subscriber *subscr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __releases(subscr);
> struct gsm_subscriber *subscr_find_by_tmsi(int tmsi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __acquires(subscr);
>
> and the code like
>
> do_something()
> {
> =A0 =A0subscr =3D subscr_find_by_tmsi(tmsi);
> =A0 =A0if (!subscr)
> =A0 =A0 =A0 =A0 =A0 return;
>
> =A0 if (some_condition) {
> ...
> =A0 =A0 =A0 =A0 =A0subscr_put(subscr);
> =A0 }

The context checker will complain here. In the sparse context checking,
it assert that for each basic block, all entry path of the basic block
should have same context level.

In this case, there are two code path merge into one. The if true path
change the context value to release once(-1). The if not true path has
not changed.
There for, sparse will complain here.

> My assumption would be that sparse is looking at the flows and figure=
s
> out that one path exits without subscr_put being called. Is my assump=
tion

Sparse don't know about subscr_put. It only knows about the context val=
ue.
It assert all entry point has same context value, which is a pretty str=
ong
assertion.

e.g. sparse can not handle the following code:

if (flags & NEED_LOCK)
    lock()

do_some_thing()

if (flags & NEED_LOCK)
   unlock()

Even though the test condition is exactly the same for
lock() vs unlock() sparse will still complain at do_some_thing().
Because the one of the incoming code path has lock taken
and the other does not.

In real life execution, there will not be context imbalance,
because same condition controls lock vs unlock. But sparse
has no knowledge about two test condition are exactly the same.
Even the expression are exactly the same, it might yield different
results. Some sparse complain when it is *possible* to get context
imbalanced.


> wrong, would it be worth adding a check that goes through the flow an=
d
> counts ref's/unref's? Am I doing it completely wrong?

It really depends on what you expect sparse to catch.
Sparse will complain if you put lock in a conditional branch,
have one function lock it but use in another function etc.

Hope that helps.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
