From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [tip:locking/core 9/11]
 include/asm-generic/atomic-instrumented.h:288:24: sparse: cast truncates
 bits from constant value (100 becomes 0)
Date: Tue, 13 Mar 2018 21:01:21 +0100
Message-ID: <20180313200119.oydccd4qd5366hfe@ltop.local>
References: <201803122219.vHl3IwRo%fengguang.wu@intel.com>
 <CACT4Y+Yscqe6M1jXSkcuvw+5-27YzZn4AXwKzU1oJCNhUrj1Ng@mail.gmail.com>
 <CACT4Y+ayA+maaG3uddxpy3w24Jyppsxmyu5R_rEsvm3JjtZkRQ@mail.gmail.com>
 <20180313104652.GK4043@hirez.programming.kicks-ass.net>
 <CACT4Y+b+ECV+6hky_cq1tg2BbYbsv1c_xGYrgzjiLfSbx21rVA@mail.gmail.com>
 <20180313180016.5axdobx6a624snpp@ltop.local>
 <20180313180806.GO4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180313180806.GO4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>, tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Mar 13, 2018 at 07:08:06PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 13, 2018 at 07:00:17PM +0100, Luc Van Oostenryck wrote:
> > The issue here is that sparse has a whole class of warnings that are
> > given very early (here at expansion of constant expressions), before
> > eliminating code from branches that are never taken (which, surprise,
> > need itself to have constant expressions already expanded).
> > 
> > It's often annoying like the case here.
> > OTOH, I don't think it's always a bad thing. Sometimes we want to
> > have warnings even from code we know will not be executed (in this
> > config but maybe it will in another one).
> 
> Is that really a valid concern with all the automated randconfig
> building going on today?

I don't think so, for the kernel at least. For other uses it may.
But don't take me wrongly: I don't want to defend those warnings here,
I just want to say that the situation is not totally black & white.


One easy-short-term solution that wouldn't make things ugly would be
to use a mask instead of a cast:

	 static __always_inline unsigned long
	 cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
	 {
	        switch (size) {
	        case 1:
	-               return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
	+               return arch_cmpxchg((u8 *)ptr, old & 0xff, new & 0xff);
	        case 2:
	-               return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
	+               return arch_cmpxchg((u16 *)ptr, old & 0xffff, new & 0xffff);


-- Luc
