From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Warning from ring buffer code (Was: Re: linux-next: tip tree
 build warning)
Date: Tue, 15 Sep 2009 09:16:34 +0200
Message-ID: <1252998994.5506.0.camel@laptop>
References: <20090804161640.70817ee6.sfr@canb.auug.org.au>
	 <1249403089.4634.139.camel@localhost.localdomain>
	 <20090912165300.9d257283.sfr@canb.auug.org.au>
	 <20090912073906.GA3972@elte.hu> <1252753957.12217.10.camel@ht.satnam>
	 <1252941416.2964.143.camel@localhost.localdomain>
	 <70318cbf0909141009v46581785m4c70edf31fcb79fa@mail.gmail.com>
	 <1252952238.2964.154.camel@localhost.localdomain>
	 <1252952621.31964.0.camel@twins>
	 <1252953076.2964.156.camel@localhost.localdomain>
	 <20090914184123.GC6045@nowhere>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090914184123.GC6045@nowhere>
Sender: linux-next-owner@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Steven Rostedt <srostedt@redhat.com>, Christopher Li <sparse@chrisli.org>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, 2009-09-14 at 20:41 +0200, Frederic Weisbecker wrote:
> On Mon, Sep 14, 2009 at 02:31:16PM -0400, Steven Rostedt wrote:
> > On Mon, 2009-09-14 at 20:23 +0200, Peter Zijlstra wrote:
> > > On Mon, 2009-09-14 at 14:17 -0400, Steven Rostedt wrote:
> > > > Frederic, how big can one of those events get. The ring buffer (and
> > > > TRACE_EVENT) allow up to almost a page size, which is very hefty for the
> > > > stack. This code needs to either be rewritten or we need to set a limit
> > > > to the size of a profile entry.
> > > 
> > > Yeah, that needs to get a re-write.. I've complained about this when it
> > > went in.
> > 
> > One answer is to create a per cpu buffer that is big enough to hold the
> > data needed. Then you can disable interrupts an use it without worry.
> > 
> > If you need to also handle NMIs, then create a per_cpu NMI buffer too,
> > and use that if "in_nmi()" is true.
> > 
> > -- Steve
> 
> 
> Looks like a nice idea.
> 
> Peter, does that sound acceptable to you to disable interrupts during a
> profiled tracepoint event?

It does anyway, a little further down the line, so sure.
