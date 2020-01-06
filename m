From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Date: Mon, 6 Jan 2020 16:26:29 +0100
Message-ID: <20200106152629.GU2810@hirez.programming.kicks-ass.net>
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Dec 30, 2019 at 11:32:31AM -0800, Kees Cook wrote:

> Is there a meaningful proposal anywhere for sparse to DTRT here?

These are what I found going through my Sent folder and Google'ing the
resulting subjects:

  https://markmail.org/message/4obybcgqscznnx63
  https://markmail.org/message/pp4ofksgactvgjbd?q=inverted_lock

> If
> not, it seems best to use what you've proposed until sparse reaches the
> point of being able to do this on its own.

Or just leave the silly sparse warning, they're easy to ignore.
