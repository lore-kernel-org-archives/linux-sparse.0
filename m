From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Warning from ring buffer code (Was: Re: linux-next: tip tree
	build warning)
Date: Mon, 14 Sep 2009 20:41:24 +0200
Message-ID: <20090914184123.GC6045@nowhere>
References: <20090804161640.70817ee6.sfr@canb.auug.org.au> <1249403089.4634.139.camel@localhost.localdomain> <20090912165300.9d257283.sfr@canb.auug.org.au> <20090912073906.GA3972@elte.hu> <1252753957.12217.10.camel@ht.satnam> <1252941416.2964.143.camel@localhost.localdomain> <70318cbf0909141009v46581785m4c70edf31fcb79fa@mail.gmail.com> <1252952238.2964.154.camel@localhost.localdomain> <1252952621.31964.0.camel@twins> <1252953076.2964.156.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:56315 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933004AbZINSl0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Sep 2009 14:41:26 -0400
Content-Disposition: inline
In-Reply-To: <1252953076.2964.156.camel@localhost.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Steven Rostedt <srostedt@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Christopher Li <sparse@chrisli.org>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Mon, Sep 14, 2009 at 02:31:16PM -0400, Steven Rostedt wrote:
> On Mon, 2009-09-14 at 20:23 +0200, Peter Zijlstra wrote:
> > On Mon, 2009-09-14 at 14:17 -0400, Steven Rostedt wrote:
> > > Frederic, how big can one of those events get. The ring buffer (and
> > > TRACE_EVENT) allow up to almost a page size, which is very hefty for the
> > > stack. This code needs to either be rewritten or we need to set a limit
> > > to the size of a profile entry.
> > 
> > Yeah, that needs to get a re-write.. I've complained about this when it
> > went in.
> 
> One answer is to create a per cpu buffer that is big enough to hold the
> data needed. Then you can disable interrupts an use it without worry.
> 
> If you need to also handle NMIs, then create a per_cpu NMI buffer too,
> and use that if "in_nmi()" is true.
> 
> -- Steve


Looks like a nice idea.

Peter, does that sound acceptable to you to disable interrupts during a
profiled tracepoint event?

