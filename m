From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Date: Tue, 31 Dec 2019 00:38:14 +0100
Message-ID: <20191230233814.2fgmsgtnhruhklnu@ltop.local>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201912301131.2C7C51E8C6@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Dec 30, 2019 at 11:32:31AM -0800, Kees Cook wrote:
> On Mon, Dec 30, 2019 at 01:15:47PM -0600, Eric Biggers wrote:
> > 
> > The annotation needs to go in the .h file, not the .c file, because sparse only
> > analyzes individual translation units.
> > 
> > It needs to be a wrapper macro because it needs to tie the acquisition of the
> > lock to the return value being true.  I.e. there's no annotation you can apply
> > directly to the function prototype that means "if this function returns true, it
> > acquires the lock that was passed in parameter N".
> 
> Gotcha. Well, I guess I leave it to Will and Peter to hash out...
> 
> Is there a meaningful proposal anywhere for sparse to DTRT here? If
> not, it seems best to use what you've proposed until sparse reaches the
> point of being able to do this on its own.

What "Right Thing" are you thinking about?
One of the simplest situation with these conditional locks is:

	if (test)
		lock();

	do_stuff();

	if (test)
		unlock();

No program can check that the second test gives the same result than
the first one, it's undecidable. I mean, it's undecidable even on
if single threaded and without interrupts. The best you can do is
to simulate the whole thing (and be sure your simulation will halt).

As far as I understand, it was the intention behind Sparse's design
regarding locking ("context in sparse's parlance) to discourage
such code and instead encourage to write things like:

	if (test) {
		do_stuff_unlocked();
	} else {
		lock();
		do_stuff_unlocked();
		unlock();
	}

where it is easy to check localy that the lock/unlock are balanced.

So, of course Sparse could be improved to prove that some of the
conditional locks are equivalent to unconditional ones like here
just above (it already does but only for very simple cases where
everything is inlined) but I don't thing there is a RT.

-- Luc Van Oostenryck
