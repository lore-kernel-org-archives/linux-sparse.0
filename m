From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse context tags
Date: Mon, 12 Mar 2007 17:32:34 -0700
Message-ID: <20070313003234.GA4640@chrisli.org>
References: <ee9e417a0703121537p49657eai662b3dce82c7af5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc11.comcast.net ([204.127.225.91]:62292 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbXCMBIh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Mar 2007 21:08:37 -0400
Content-Disposition: inline
In-Reply-To: <ee9e417a0703121537p49657eai662b3dce82c7af5d@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Russ Cox <rsc@swtch.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Mar 12, 2007 at 06:37:34PM -0400, Russ Cox wrote:
> Is the optional leading context argument
> (the x in __attribute__((context(x, 0, 1)))
> documented anywhere?  Apologies if this is
> a FAQ, but I've looked.

I don't know about the document. The x is mostly
for human reading currently. Sparse does not use
it yet.

> 
> Failing that, can someone enlighten me about
> why sparse doesn't find any problems with
> the function bad() below?  I am using sparse-0.2.

That is because sparse can't distinguish which lock is
acquired. It is actually hard to get that information.
Even though the expression is the same, the actual lock
might be different.

e.g.

redlock(foo->redlock);
foo = bar;
redunlock (foo->redlock);


Depend on the value of foo, even the same expression can
mean different locks.

So sparse currently just stack all the lock level into one place,
it will complain about any lock level that is has mismatch.


> void
> bad(redlock_t *r, bluelock_t *b)
> {
> 	redlock(r);
> 	blueunlock(b);
> }

Sparse sees:

Some lock acquired and some lock release exactly once in the function.
Nothing to complain.

How ever, if you do:

#define __acquires_red(x) __attribute__((context(x, 0, 1)))
#define __releases_red(x) __attribute__((context(x, 1, 0)))

#define __acquires_blue(x) __attribute__((context(x, 0, 1024)))
#define __releases_blue(x) __attribute__((context(x, 1024, 0)))

Assume your redlock level did not go up to 1024, then:

void redlock(redlock_t *r) __acquires_red(r);

void bluelock(redlock_t *r) __acquires_blue(r);
void blueunlock(redlock_t *r) __releases_blue(r);


You will get the complain about lock level not match at exit.

Chris
