From: Christopher Li <sparse@chrisli.org>
Subject: Re: [tip:locking/core 9/11] include/asm-generic/atomic-instrumented.h:288:24:
 sparse: cast truncates bits from constant value (100 becomes 0)
Date: Tue, 13 Mar 2018 10:29:40 -0700
Message-ID: <CANeU7QkrC0M4P6MrDKU8+ZOf9nU+DtKYxoAdvfx76K3MTMEajA@mail.gmail.com>
References: <201803122219.vHl3IwRo%fengguang.wu@intel.com> <CACT4Y+Yscqe6M1jXSkcuvw+5-27YzZn4AXwKzU1oJCNhUrj1Ng@mail.gmail.com>
 <CACT4Y+ayA+maaG3uddxpy3w24Jyppsxmyu5R_rEsvm3JjtZkRQ@mail.gmail.com>
 <20180313104652.GK4043@hirez.programming.kicks-ass.net> <CACT4Y+b+ECV+6hky_cq1tg2BbYbsv1c_xGYrgzjiLfSbx21rVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+b+ECV+6hky_cq1tg2BbYbsv1c_xGYrgzjiLfSbx21rVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>, tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Mar 13, 2018 at 4:08 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Mar 13, 2018 at 1:46 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  283  static __always_inline unsigned long
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  284  cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  285  {
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  286         switch (size) {
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  287         case 1:
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29 @288                 return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  289         case 2:
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  290                 return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  291         case 4:
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  292                 return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  293         case 8:
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  294                 BUILD_BUG_ON(sizeof(unsigned long) != 8);
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  295                 return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  296         }
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  297         BUILD_BUG();
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  298         return 0;
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  299  }
>>> >> b06ed71a6 Dmitry Vyukov 2018-01-29  300
>>
>>> It seems that this is due to this guy:
>>>
>>> static __always_inline int trylock_clear_pending(struct qspinlock *lock)
>>> {
>>>         struct __qspinlock *l = (void *)lock;
>>>
>>>         return !READ_ONCE(l->locked) &&
>>>                (cmpxchg_acquire(&l->locked_pending, _Q_PENDING_VAL,
>>>                                 _Q_LOCKED_VAL) == _Q_PENDING_VAL);
>>> }
>>>
>>> _Q_PENDING_VAL is 0x100. However, locked_pending is 2 bytes. So it
>>> seems that compiler checks all switch cases, this inevitably will lead
>>> to such warnings.

So you are saying cmpxchg_size() was call with a size==2,
however sparse did not do the constant propagation or evaluation
properly. So that it did not eliminate the other branch of size==1
case statement.

Can you do a "sparse -E" on the original file, then save the
result to a new file. That will take care of the pre-processing.
Then run the sparse on the pre-processed file to get a smaller
test case?

Having a smaller test case would make it easier to reproduce
what exactly IR was issued during that warning.

>>> Off the top of my head I can think of the following solution:
>>>
>>>         switch (size) {
>>>         case 1:
>>>                 return arch_cmpxchg((u8 *)ptr, (u8)(old * (size !=
>>> 1)), (u8)(new * (size != 1)));
>>>         case 2:
>>>                 return arch_cmpxchg((u16 *)ptr, (u16)(old * (size !=
>>> 2)), (u16)(new * (size != 2)));
>>>
>>> But it's too ugly.
>>
>> Yes agreed, that's horrendous.

Let's not do that. If it is a sparse problem, let's try to fix this sparse.

Chris
