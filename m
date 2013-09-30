From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:sched/core 16/27] fs/jbd/commit.c:105:12: sparse: context
 imbalance in 'inverted_lock' - wrong count at exit
Date: Mon, 30 Sep 2013 15:44:34 +0200
Message-ID: <20130930134434.GC12926@twins.programming.kicks-ass.net>
References: <52432bed.WfPoNUw4qxmYeQy4%fengguang.wu@intel.com>
 <20130925185925.GD3657@laptop.programming.kicks-ass.net>
 <20130925214719.GA7716@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41367 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab3I3Nq5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Sep 2013 09:46:57 -0400
Content-Disposition: inline
In-Reply-To: <20130925214719.GA7716@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, Ingo Molnar <mingo@kernel.org>, kbuild-all@01.org, linux-sparse@vger.kernel.org, sparse@chrisli.org

On Wed, Sep 25, 2013 at 02:47:20PM -0700, Josh Triplett wrote:
> That's expressible in Sparse; look at how spin_trylock and _cond_lock,
> and write a _cond_unlock.

Yeah, I know about __cond_lock() its an abomination that should die. I
did take a stab at teach sparse something saner but got stuck.. was
years ago, can't remember more.
