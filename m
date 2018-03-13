From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [tip:locking/core 9/11]
 include/asm-generic/atomic-instrumented.h:288:24: sparse: cast truncates
 bits from constant value (100 becomes 0)
Date: Tue, 13 Mar 2018 19:00:17 +0100
Message-ID: <20180313180016.5axdobx6a624snpp@ltop.local>
References: <201803122219.vHl3IwRo%fengguang.wu@intel.com>
 <CACT4Y+Yscqe6M1jXSkcuvw+5-27YzZn4AXwKzU1oJCNhUrj1Ng@mail.gmail.com>
 <CACT4Y+ayA+maaG3uddxpy3w24Jyppsxmyu5R_rEsvm3JjtZkRQ@mail.gmail.com>
 <20180313104652.GK4043@hirez.programming.kicks-ass.net>
 <CACT4Y+b+ECV+6hky_cq1tg2BbYbsv1c_xGYrgzjiLfSbx21rVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+b+ECV+6hky_cq1tg2BbYbsv1c_xGYrgzjiLfSbx21rVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>, tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Mar 13, 2018 at 02:08:13PM +0300, Dmitry Vyukov wrote:
> On Tue, Mar 13, 2018 at 1:46 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Mar 13, 2018 at 11:49:17AM +0300, Dmitry Vyukov wrote:
> >> On Mon, Mar 12, 2018 at 6:17 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> >> > On Mon, Mar 12, 2018 at 5:52 PM, kbuild test robot
> >> >>    kernel/locking/qspinlock.c:418:22: sparse: incorrect type in assignment (different modifiers) @@    expected struct mcs_spinlock *prev @@    got struct struct mcs_spinlock *prev @@
> >> >>    kernel/locking/qspinlock.c:418:22:    expected struct mcs_spinlock *prev
> >> >>    kernel/locking/qspinlock.c:418:22:    got struct mcs_spinlock [pure] *
> >
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  283  static __always_inline unsigned long
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  284  cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  285  {
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  286         switch (size) {
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  287         case 1:
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29 @288                 return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  289         case 2:
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  290                 return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  291         case 4:
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  292                 return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  293         case 8:
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  294                 BUILD_BUG_ON(sizeof(unsigned long) != 8);
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  295                 return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  296         }
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  297         BUILD_BUG();
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  298         return 0;
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  299  }
> >> >> b06ed71a6 Dmitry Vyukov 2018-01-29  300
> >
> >> It seems that this is due to this guy:
> >>
> >> static __always_inline int trylock_clear_pending(struct qspinlock *lock)
> >> {
> >>         struct __qspinlock *l = (void *)lock;
> >>
> >>         return !READ_ONCE(l->locked) &&
> >>                (cmpxchg_acquire(&l->locked_pending, _Q_PENDING_VAL,
> >>                                 _Q_LOCKED_VAL) == _Q_PENDING_VAL);
> >> }
> >>
> >> _Q_PENDING_VAL is 0x100. However, locked_pending is 2 bytes. So it
> >> seems that compiler checks all switch cases, this inevitably will lead
> >> to such warnings.
> >>
> >> Any suggestion on how to resolve this? Leave as is?
> >
> > I'm not sure I understand what it thinks is wrong. Can't we fix sparse
> > to not be stupid? The actual compilers don't seem to a have a problem
> > with this.

The issue here is that sparse has a whole class of warnings that are
given very early (here at expansion of constant expressions), before
eliminating code from branches that are never taken (which, surprise,
need itself to have constant expressions already expanded).

It's often annoying like the case here.
OTOH, I don't think it's always a bad thing. Sometimes we want to
have warnings even from code we know will not be executed (in this
config but maybe it will in another one).

Several solution would be possible:
1) removing all those early warnings (but then we'll loose more legitimate ones)
2) add an option to not issues those early warnings (ame as above).
3) move those warnings (and thus the expansion of the concerned constants)
   after trivial dead code elimination
4) add a very early pass to eliminate never taken branches
5) something else ?

1) & 2) are easy but not really acceptable.
3) can be good for some cases but not here, I think.
4) seems to way to go

-- Luc Van Oostenryck
