From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/core 9/11]
 include/asm-generic/atomic-instrumented.h:288:24: sparse: cast truncates
 bits from constant value (100 becomes 0)
Date: Tue, 13 Mar 2018 19:08:06 +0100
Message-ID: <20180313180806.GO4043@hirez.programming.kicks-ass.net>
References: <201803122219.vHl3IwRo%fengguang.wu@intel.com>
 <CACT4Y+Yscqe6M1jXSkcuvw+5-27YzZn4AXwKzU1oJCNhUrj1Ng@mail.gmail.com>
 <CACT4Y+ayA+maaG3uddxpy3w24Jyppsxmyu5R_rEsvm3JjtZkRQ@mail.gmail.com>
 <20180313104652.GK4043@hirez.programming.kicks-ass.net>
 <CACT4Y+b+ECV+6hky_cq1tg2BbYbsv1c_xGYrgzjiLfSbx21rVA@mail.gmail.com>
 <20180313180016.5axdobx6a624snpp@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180313180016.5axdobx6a624snpp@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>, tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Mar 13, 2018 at 07:00:17PM +0100, Luc Van Oostenryck wrote:
> The issue here is that sparse has a whole class of warnings that are
> given very early (here at expansion of constant expressions), before
> eliminating code from branches that are never taken (which, surprise,
> need itself to have constant expressions already expanded).
> 
> It's often annoying like the case here.
> OTOH, I don't think it's always a bad thing. Sometimes we want to
> have warnings even from code we know will not be executed (in this
> config but maybe it will in another one).

Is that really a valid concern with all the automated randconfig
building going on today?
