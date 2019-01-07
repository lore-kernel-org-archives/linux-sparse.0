From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Date: Mon, 7 Jan 2019 11:22:23 -0500
Message-ID: <20190107112007-mutt-send-email-mst@kernel.org>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-4-mst@redhat.com>
 <86023cbe-d1ae-a0d6-7b75-26556f1a0c1f@redhat.com>
 <20190106231756-mutt-send-email-mst@kernel.org>
 <20190107094610.GA2861@worktop.programming.kicks-ass.net>
 <20190107082223-mutt-send-email-mst@kernel.org>
 <20190107155423.GM2218@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107155423.GM2218@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jonathan Corbet <corbet@lwn.net>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@arnd>
List-Id: linux-sparse@vger.kernel.org

On Mon, Jan 07, 2019 at 04:54:23PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 07, 2019 at 08:36:36AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Jan 07, 2019 at 10:46:10AM +0100, Peter Zijlstra wrote:
> 
> > > How about naming the thing: dependent_ptr() ? That is without any (r)mb
> > > implications at all. The address dependency is strictly weaker than an
> > > rmb in that it will only order the two loads in qestion and not, like
> > > rmb, any prior to any later load.
> > 
> > So I'm fine with this as it's enough for virtio, but I would like to point out two things:
> > 
> > 1. E.g. on x86 both SMP and DMA variants can be NOPs but
> > the madatory one can't, so assuming we do not want
> > it to be stronger than rmp then either we want
> > smp_dependent_ptr(), dma_dependent_ptr(), dependent_ptr()
> > or we just will specify that dependent_ptr() works for
> > both DMA and SMP.
> 
> The latter; the construct simply generates dependent loads. It is up to
> the CPU as to what all that works for.

But not on intel right? On intel loads are ordered so it can be a nop.

> > 2. Down the road, someone might want to order a store after a load.
> > Address dependency does that for us too. Assuming we make
> > dependent_ptr a NOP on x86, we will want an mb variant
> > which isn't a NOP on x86. Will we want to rename
> > dependent_ptr to dependent_ptr_rmb at that point?
> 
> Not sure; what is the actual overhead of the construct on x86 vs the
> NOP?

I'll have to check. There's a pipeline stall almost for sure - that's
why we put it there after all :).

-- 
MST
