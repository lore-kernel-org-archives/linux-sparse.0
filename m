From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [tip:sched/core 16/27] fs/jbd/commit.c:105:12: sparse: context
 imbalance in 'inverted_lock' - wrong count at exit
Date: Mon, 30 Sep 2013 08:25:51 -0700
Message-ID: <20130930152550.GA1269@leaf>
References: <52432bed.WfPoNUw4qxmYeQy4%fengguang.wu@intel.com>
 <20130925185925.GD3657@laptop.programming.kicks-ass.net>
 <20130925214719.GA7716@jtriplet-mobl1>
 <20130930134434.GC12926@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:37555 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab3I3P02 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Sep 2013 11:26:28 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 62A1B47A247
	for <linux-sparse@vger.kernel.org>; Mon, 30 Sep 2013 17:26:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130930134434.GC12926@twins.programming.kicks-ass.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, Ingo Molnar <mingo@kernel.org>, kbuild-all@01.org, linux-sparse@vger.kernel.org, sparse@chrisli.org

On Mon, Sep 30, 2013 at 03:44:34PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 25, 2013 at 02:47:20PM -0700, Josh Triplett wrote:
> > That's expressible in Sparse; look at how spin_trylock and _cond_lock,
> > and write a _cond_unlock.
> 
> Yeah, I know about __cond_lock() its an abomination that should die.

Can't argue with that.

> I
> did take a stab at teach sparse something saner but got stuck.. was
> years ago, can't remember more.

I only see two obvious ways to extend Sparse to remove the need for
__cond_lock, and only one makes sense.

First, you could add an attribute for conditional context changes, which
takes an expression; however, that would require an expression
evaluator, which internally would construct code a lot like __cond_lock,
and it would require some syntax to reference the return value.  That
seems excessively painful, and not significantly better than
__cond_lock.

Second, the real solution: teach Sparse to do whole-program
analysis, similar to GCC LTO.

Alternatively, someone could write a GCC plugin that understands the
context attribute and __context__ statement, and then does whole-program
context analysis using GCC; that seems easiest, relatively speaking.

- Josh Triplett
