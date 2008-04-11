From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Using sparse to catch invalid RCU dereferences?
Date: Fri, 11 Apr 2008 20:18:42 +0200
Message-ID: <1207937922.7524.17.camel@twins>
References: <1207605856.12481.35.camel@johannes.berg>
	 <20080408155259.GA8381@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:40986 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759030AbYDKSTA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Apr 2008 14:19:00 -0400
In-Reply-To: <20080408155259.GA8381@linux.vnet.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-sparse <linux-sparse@vger.kernel.org>

On Tue, 2008-04-08 at 08:52 -0700, Paul E. McKenney wrote:
> On Tue, Apr 08, 2008 at 12:04:16AM +0200, Johannes Berg wrote:
> > Hi,
> > 
> > Just a thought, I haven't tried this yet because I'm not entirely sure
> > it's actually correct. I was just thinking it should be possible to
> > introduce something like
> > 
> > 	#define __rcu	__attribute__((address_space(3)))
> > 
> > (for sparse only, of course) and then be able to say
> > 
> > 	struct myfoo *foo __rcu;
> > 
> > and sparse would warn on
> > 
> > 	struct myfoo *bar = foo;
> > 
> > but not on
> > 
> > 	struct myfoo *bar = rcu_dereference(foo);
> 
> Ah, "address_space" is a sparse-ism, no wonder I couldn't find it in
> the gcc docs...
> 
> So the address_space attribute says what the pointer points to rather
> than where the pointer resides, correct?
> 
> > by way of using __force inside rcu_dereference(), rcu_assign_pointer()
> > etc.
> > 
> > Would this be feasible? Or should one actually use __bitwise/__force to
> > also get the warning when assigning between two variables both marked
> > __rcu?
> 
> It might be.  There are a number of places where it is legal to access
> RCU-protected pointers directly, and all of these would need to be
> changed.  For example, in the example above, one could do:
> 
> 	foo = NULL;
> 
> I recently tried to modify rcu_assign_pointer() to issue the memory
> memory barrier only when the pointer was non-NULL, but this ended badly.
> Probably because I am not the greatest gcc expert around...  We ended
> up having to define an rcu_assign_index() to handle the possibility of
> assigning a zero-value array index, but my attempts to do type-checking
> backfired, and I eventually gave it up.  Again, someone a bit more clued
> in to gcc than I am could probably pull it off.
> 
> In addition, it is legal to omit rcu_dereference() and rcu_assign_pointer()
> when holding the update-side lock.

We could start by annotating those as well, for example:

 __rcu spinlock_t tree_lock;

Then we would know that when tree lock is held the data structure is
stable and we can ommit the rcu_*() functions.

