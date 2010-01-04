From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Detection of locking one lock twice
Date: Sun, 3 Jan 2010 23:48:25 -0800
Message-ID: <20100104074825.GC2423@feather>
References: <1261440567.5039.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:49427 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab0ADISl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jan 2010 03:18:41 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 376BFB0D3F
	for <linux-sparse@vger.kernel.org>; Mon,  4 Jan 2010 08:48:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1261440567.5039.12.camel@localhost.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Petr Muller <afri@afri.cz>
Cc: linux-sparse@vger.kernel.org

On Tue, Dec 22, 2009 at 01:09:27AM +0100, Petr Muller wrote:
> I'm playing with sparse a bit, especially the context/locking problem
> detecting stuff. I'm trying to create simple context updating
> lock/unlock, everything works as I would expect except for this case
> (I've reduced it as much as possible) :
> 
> #ifdef __CHECKER__
>   #define __acquires(x) __attribute__((context (x, 0, 1)))
>   #define __releases(x) __attribute__((context (x, 1, 0)))
>   #define __acquire(x) __context__(x,1)
>   #define __release(x) __context__(x,-1)
> #else
> (...)
> #endif
> 
> (...)
> 
> void lock(void)
>   __acquires(i)
> {
>   __acquire(i);
> }
> 
> void unlock(void)
>   __releases(i)
> {
>   __release(i);
> }
> 
> void fction(int a)
> {
>   lock();
>   lock();
>   unlock();
>   unlock();
> }
> 
> int main(void){
>   fction(1);
>   return 0;
> }
> 
> Sparse gives no warning in this code - I would expect that second call
> to lock() would violate the 'in' limit of __acquires attribute, but it
> does not. I'm wondering if this is actually a problem in sparse, or am I
> doing something wrong? 

As far as I know, Sparse currently treats the "in" context as a minimum
requirement, not an exact requirement.  Thus, a context of 0 ends up
meaning "may or may not hold the lock", while 1 means "must hold the
lock at least once".

I think that needs fixing.

- Josh Triplett
