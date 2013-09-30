From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:sched/core 16/27] fs/jbd/commit.c:105:12: sparse: context
 imbalance in 'inverted_lock' - wrong count at exit
Date: Mon, 30 Sep 2013 17:35:17 +0200
Message-ID: <20130930153517.GD3081@twins.programming.kicks-ass.net>
References: <52432bed.WfPoNUw4qxmYeQy4%fengguang.wu@intel.com>
 <20130925185925.GD3657@laptop.programming.kicks-ass.net>
 <20130925214719.GA7716@jtriplet-mobl1>
 <20130930134434.GC12926@twins.programming.kicks-ass.net>
 <20130930152550.GA1269@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44702 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512Ab3I3Pfg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Sep 2013 11:35:36 -0400
Content-Disposition: inline
In-Reply-To: <20130930152550.GA1269@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, Ingo Molnar <mingo@kernel.org>, kbuild-all@01.org, linux-sparse@vger.kernel.org, sparse@chrisli.org

On Mon, Sep 30, 2013 at 08:25:51AM -0700, Josh Triplett wrote:
> First, you could add an attribute for conditional context changes, which
> takes an expression; however, that would require an expression
> evaluator, which internally would construct code a lot like __cond_lock,
> and it would require some syntax to reference the return value.  That
> seems excessively painful, and not significantly better than
> __cond_lock.

This sounds somewhat familiar; its better in that it doesn't pollute the
actual kernel source ;-)
