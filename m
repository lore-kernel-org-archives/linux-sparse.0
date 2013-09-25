From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [tip:sched/core 16/27] fs/jbd/commit.c:105:12: sparse: context
 imbalance in 'inverted_lock' - wrong count at exit
Date: Wed, 25 Sep 2013 14:47:20 -0700
Message-ID: <20130925214719.GA7716@jtriplet-mobl1>
References: <52432bed.WfPoNUw4qxmYeQy4%fengguang.wu@intel.com>
 <20130925185925.GD3657@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40417 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3IYVrb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Sep 2013 17:47:31 -0400
Content-Disposition: inline
In-Reply-To: <20130925185925.GD3657@laptop.programming.kicks-ass.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, Ingo Molnar <mingo@kernel.org>, kbuild-all@01.org, linux-sparse@vger.kernel.org, sparse@chrisli.org

On Wed, Sep 25, 2013 at 08:59:25PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 26, 2013 at 02:31:09AM +0800, kbuild test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> > head:   1a338ac32ca630f67df25b4a16436cccc314e997
> > commit: 0c44c2d0f459cd7e275242b72f500137c4fa834d [16/27] x86: Use asm goto to implement better modify_and_test() functions
> > reproduce: make C=1 CF=-D__CHECK_ENDIAN__
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> fs/jbd/commit.c:105:12: sparse: context imbalance in 'inverted_lock' - wrong count at exit
> >    fs/jbd/commit.c:205:9: sparse: context imbalance in 'journal_submit_data_buffers' - different lock contexts for basic block
> >    fs/jbd/commit.c:456:9: sparse: context imbalance in 'journal_commit_transaction' - different lock contexts for basic block
> > --
> >    include/linux/bit_spinlock.h:62:25: sparse: context imbalance in '__try_to_free_cp_buf' - unexpected unlock
> >    fs/jbd/checkpoint.c:155:36: sparse: context imbalance in '__log_wait_for_space' - unexpected unlock
> >    include/linux/bit_spinlock.h:62:25: sparse: context imbalance in '__wait_cp_io' - unexpected unlock
> >    fs/jbd/checkpoint.c:294:23: sparse: context imbalance in '__process_buffer' - unexpected unlock
> >    fs/jbd/checkpoint.c:390:9: sparse: context imbalance in 'log_do_checkpoint' - different lock contexts for basic block
> > >> fs/jbd/checkpoint.c:557:12: sparse: context imbalance in 'journal_clean_one_cp_list' - wrong count at exit
> > --
> > >> drivers/infiniband/hw/qib/qib_verbs.h:1061:36: sparse: crazy programmer
> > 
> > vim +/inverted_lock +105 fs/jbd/commit.c
> > 
> >     89			WARN_ON_ONCE(buffer_dirty(bh));
> >     90			clear_buffer_freed(bh);
> >     91			clear_buffer_mapped(bh);
> >     92			clear_buffer_new(bh);
> >     93			clear_buffer_req(bh);
> >     94			bh->b_bdev = NULL;
> >     95			release_buffer_page(bh);
> >     96		} else
> >     97			put_bh(bh);
> >     98	}
> >     99	
> >    100	/*
> >    101	 * Try to acquire jbd_lock_bh_state() against the buffer, when j_list_lock is
> >    102	 * held.  For ranking reasons we must trylock.  If we lose, schedule away and
> >    103	 * return 0.  j_list_lock is dropped in this case.
> >    104	 */
> >  > 105	static int inverted_lock(journal_t *journal, struct buffer_head *bh)
> >    106	{
> >    107		if (!jbd_trylock_bh_state(bh)) {
> >    108			spin_unlock(&journal->j_list_lock);
> >    109			schedule();
> >    110			return 0;
> >    111		}
> >    112		return 1;
> >    113	}
> 
> I've really no idea how that patch can cause sparse warnings. Patch
> included below for the sparse people. Does sparse presume to understand
> inline asm?

[...snip...]

I don't see an obvious reason why that patch could introduce that sparse
warning.  Sparse doesn't try to understand inline assembly; context
warnings come from explicit context attributes/statements.

That said, that function's lock behavior is slightly crazy: it gets
called with the lock guaranteed to be held, and it may or may not drop
the lock depending on its return value?

That's expressible in Sparse; look at how spin_trylock and _cond_lock,
and write a _cond_unlock.

- Josh Triplett
