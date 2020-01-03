From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Date: Fri, 3 Jan 2020 03:18:19 +0100
Message-ID: <20200103021819.jq6h53h3ktlatyj7@ltop.local>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
 <20191230233814.2fgmsgtnhruhklnu@ltop.local>
 <CAHk-=wgkoUeLGEdUF2nsibsK8YFrOOXMd9j5Y1ND4R+1a-6n8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkoUeLGEdUF2nsibsK8YFrOOXMd9j5Y1ND4R+1a-6n8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Eric Biggers <ebiggers@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sparse Mailing-list <linux-sparse@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Thu, Jan 02, 2020 at 05:35:34PM -0800, Linus Torvalds wrote:
> On Mon, Dec 30, 2019 at 3:38 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > One of the simplest situation with these conditional locks is:
> >
> >         if (test)
> >                 lock();
> >
> >         do_stuff();
> >
> >         if (test)
> >                 unlock();
> >
> > No program can check that the second test gives the same result than
> > the first one, it's undecidable. I mean, it's undecidable even on
> > if single threaded and without interrupts. The best you can do is
> > to simulate the whole thing (and be sure your simulation will halt).
> 
> No, no.
> 
> It's undecidable in the general case, but it's usually actually
> trivially decidable in most real-world kernel cases.
> 
> Because "test" tends to be an argument to the function (or one bit of
> an argument), and after it has been turned into SSA form, it's
> literally using the same exact register for the conditional thanks to
> CSE and simplification.
> 
> Perhaps not every time, but I bet it would be most times.

Yes, sure. I was, in fact, speaking for for all the cases where
'test' is more complex than an argument or local var. When I looked
at these false warnings about context imbalance, maybe 18 months ago,
my vague impression was that in most cases the test contained a pointer
dereference or worse. But I didn't look much.

> So I guess sparse could in theory notice that certain basic blocks are
> conditional on the same thing, so if one is done, then the other is
> always done (assuming there is conditional branch out in between, of
> course).
> 
> IOW, the context tracking *could* do check son a bigger state than
> just one basic block. It doesn't, and it would probably be painful to
> do, but it's certainly not impossible.
> 
> So to make a trivial example for sparse:
> 
>     extern int testfn(int);
>     extern int do_something(void);
> 
>     int testfn(int flag)
>     {
>         if (flag & 1)
>                 __context__(1);
>         do_something();
>         if (flag & 1)
>                 __context__(-1);
>     }
> 
> this causes a warning:
> 
>     c.c:4:5: warning: context imbalance in 'testfn' - different lock
> contexts for basic block
> 
> because "do_something()" is called with different lock contexts. And
> that's definitely a real issue. But if we were to want to extend the
> "make sure we enter/exit with the same lock context", we _could_ do
> it, because look at the linearization:
> 
>     testfn:
>     .L0:
>         <entry-point>
>         and.32      %r2 <- %arg1, $1
>         cbr         %r2, .L1, .L2
>     .L1:
>         context     1
>         br          .L2
>     .L2:
>         call.32     %r4 <- do_something
>         cbr         %r2, .L3, .L5
>     .L3:
>         context     -1
>         br          .L5
>     .L5:
>         ret.32      UNDEF
> 
> becasue the conditional branch always uses "%r2" as the conditional.
> Notice? Not at all undecideable, and it would not be *impossible* to
> say that "we can see that all context changes are conditional on %r2
> not being true".
> 
> So sparse has already done all the real work to know that the two "if
> (test)" conditionals test the exact same thing. We _know_ that the
> second test has the same result as the first test, we're using the
> same SSA register for both of them!

Absolutely. I'm more than willing to look at this but I just fear
that in most cases the conditional is more complex. I'll make
some investigations.

-- Luc
