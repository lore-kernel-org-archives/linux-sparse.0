From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Date: Mon, 7 Jan 2019 16:54:23 +0100
Message-ID: <20190107155423.GM2218@hirez.programming.kicks-ass.net>
References: <20190102205715.14054-1-mst@redhat.com>
	<20190102205715.14054-4-mst@redhat.com>
	<86023cbe-d1ae-a0d6-7b75-26556f1a0c1f@redhat.com>
	<20190106231756-mutt-send-email-mst@kernel.org>
	<20190107094610.GA2861@worktop.programming.kicks-ass.net>
	<20190107082223-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190107082223-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-sparse@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Lustig <dlustig@nvidia.com>, Nicholas Piggin <npiggin@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Luc Maranget <luc.maranget@inria.fr>, Richard Henderson <rth@twiddle.net>, Jade Alglave <j.alglave@ucl.ac.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Jan 07, 2019 at 08:36:36AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 10:46:10AM +0100, Peter Zijlstra wrote:

> > How about naming the thing: dependent_ptr() ? That is without any (r)mb
> > implications at all. The address dependency is strictly weaker than an
> > rmb in that it will only order the two loads in qestion and not, like
> > rmb, any prior to any later load.
> 
> So I'm fine with this as it's enough for virtio, but I would like to point out two things:
> 
> 1. E.g. on x86 both SMP and DMA variants can be NOPs but
> the madatory one can't, so assuming we do not want
> it to be stronger than rmp then either we want
> smp_dependent_ptr(), dma_dependent_ptr(), dependent_ptr()
> or we just will specify that dependent_ptr() works for
> both DMA and SMP.

The latter; the construct simply generates dependent loads. It is up to
the CPU as to what all that works for.

> 2. Down the road, someone might want to order a store after a load.
> Address dependency does that for us too. Assuming we make
> dependent_ptr a NOP on x86, we will want an mb variant
> which isn't a NOP on x86. Will we want to rename
> dependent_ptr to dependent_ptr_rmb at that point?

Not sure; what is the actual overhead of the construct on x86 vs the
NOP?
