From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Date: Mon, 6 Jan 2020 18:54:59 +0100
Message-ID: <20200106175459.tjuhmdrsusax3s4z@ltop.local>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
 <20191230233814.2fgmsgtnhruhklnu@ltop.local>
 <20200106154119.GV2810@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200106154119.GV2810@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Jan 06, 2020 at 04:41:19PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 31, 2019 at 12:38:14AM +0100, Luc Van Oostenryck wrote:

...
 
> Not quite what we're talking about. Instead consider this:
> 
> The normal flow would be something like:
> 
> extern void spin_lock(spinlock_t *lock) __acquires(lock);
> extern void spin_unlock(spinlock_t *lock) __releases(lock);
> 
> extern bool _spin_trylock(spinlock_t *lock) __acquires(lock);
> 
> #define __cond_lock(x, c) ((c) ? ({ __acquire(x); 1; }) : 0)
> #define spin_trylock(lock) __cond_lock(lock, _spin_lock)
> 
> 
> 	if (spin_trylock(lock)) {
> 
> 		/* do crap */
> 
> 		spin_unlock();
> 	}
> 
> 
> So the proposal here:
> 
>   https://markmail.org/message/4obybcgqscznnx63
> 
> would have us write:
> 
> extern bool spin_trylock(spinlock_t *lock) __attribute__((context(lock, 0, spin_trylock(lock));

Well, allowing arbitrary conditions would be hard/impossible but you're
only asking to have the *return value* as condition, right? That looks
as reasonably feasible.

> Basically have sparse do a transform on its own expression tree and
> inject the very same crud we now do manually. This avoids cluttering the
> kernel tree with this nonsense.

So, a call of a function declared with __acquires() or releases() is
interpreted by Sparse as if the call is immediately followed by an
increase or a decrease of the context. It wouldn't be very hard to
add a new attribute (something like __cond_context) and let Sparse do
as if a call to a function with such attribute is directly followed
by a test of its return value and a corresponding change in the context.
It would boil down to:

	extern bool spin_trylock(lock) __cond_context(lock);

	if (spin_trylock(lock)) {
		/* do crap */
		spin_unlock();
	}

behaving like the following code currently would:

	extern bool spin_trylock(lock);

	if (spin_trylock(lock)) {
		__acquire(lock);
		/* do crap */
		spin_unlock();
	}


Would something like this be satisfactory?

-- Luc
