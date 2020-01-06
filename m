From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Date: Mon, 6 Jan 2020 16:41:19 +0100
Message-ID: <20200106154119.GV2810@hirez.programming.kicks-ass.net>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
 <20191230233814.2fgmsgtnhruhklnu@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191230233814.2fgmsgtnhruhklnu@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Tue, Dec 31, 2019 at 12:38:14AM +0100, Luc Van Oostenryck wrote:
> On Mon, Dec 30, 2019 at 11:32:31AM -0800, Kees Cook wrote:
> > On Mon, Dec 30, 2019 at 01:15:47PM -0600, Eric Biggers wrote:
> > > 
> > > The annotation needs to go in the .h file, not the .c file, because sparse only
> > > analyzes individual translation units.
> > > 
> > > It needs to be a wrapper macro because it needs to tie the acquisition of the
> > > lock to the return value being true.  I.e. there's no annotation you can apply
> > > directly to the function prototype that means "if this function returns true, it
> > > acquires the lock that was passed in parameter N".
> > 
> > Gotcha. Well, I guess I leave it to Will and Peter to hash out...
> > 
> > Is there a meaningful proposal anywhere for sparse to DTRT here? If
> > not, it seems best to use what you've proposed until sparse reaches the
> > point of being able to do this on its own.
> 
> What "Right Thing" are you thinking about?
> One of the simplest situation with these conditional locks is:
> 
> 	if (test)
> 		lock();
> 
> 	do_stuff();
> 
> 	if (test)
> 		unlock();
> 
> No program can check that the second test gives the same result than
> the first one, it's undecidable. I mean, it's undecidable even on
> if single threaded and without interrupts. The best you can do is
> to simulate the whole thing (and be sure your simulation will halt).

Not quite what we're talking about. Instead consider this:

The normal flow would be something like:

extern void spin_lock(spinlock_t *lock) __acquires(lock);
extern void spin_unlock(spinlock_t *lock) __releases(lock);

extern bool _spin_trylock(spinlock_t *lock) __acquires(lock);

#define __cond_lock(x, c) ((c) ? ({ __acquire(x); 1; }) : 0)
#define spin_trylock(lock) __cond_lock(lock, _spin_lock)


	if (spin_trylock(lock)) {

		/* do crap */

		spin_unlock();
	}


So the proposal here:

  https://markmail.org/message/4obybcgqscznnx63

would have us write:

extern bool spin_trylock(spinlock_t *lock) __attribute__((context(lock, 0, spin_trylock(lock));

Basically have sparse do a transform on its own expression tree and
inject the very same crud we now do manually. This avoids cluttering the
kernel tree with this nonsense.
