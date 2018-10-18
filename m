From: Du Changbin <changbin.du@gmail.com>
Subject: Re: [PATCH 2/4] kernel hacking: new config NO_AUTO_INLINE to disable
 compiler auto-inline optimizations
Date: Thu, 18 Oct 2018 17:01:49 +0000
Message-ID: <20181018170148.47zbtfno5cjh4wb6@mail.google.com>
References: <20181018162548.6399-1-changbin.du@gmail.com>
 <20181018162548.6399-3-changbin.du@gmail.com>
 <62bcdf3d-87be-407f-b971-5a53dbb1e4b8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <62bcdf3d-87be-407f-b971-5a53dbb1e4b8@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Du Changbin <changbin.du@gmail.com>, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk, akpm@linux-foundation.org, linux-kbuild@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, Changbin Du <changbin.du@intel.com>, linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On Thu, Oct 18, 2018 at 05:57:56PM +0100, Robin Murphy wrote:
> On 18/10/18 17:25, Du Changbin wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> > this option will prevent the compiler from optimizing the kernel by
> > auto-inlining functions not marked with the inline keyword.
> > 
> > With this option, only functions explicitly marked with "inline" will
> > be inlined. This will allow the function tracer to trace more functions
> > because it only traces functions that the compiler has not inlined.
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >   Makefile          |  6 ++++++
> >   lib/Kconfig.debug | 25 +++++++++++++++++++++++++
> >   2 files changed, 31 insertions(+)
> > 
> > diff --git a/Makefile b/Makefile
> > index e8b599b4dcde..757d6507cb5c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -749,6 +749,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
> >   		   $(call cc-option,-fno-var-tracking)
> >   endif
> > +ifdef CONFIG_NO_AUTO_INLINE
> > +KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
> > +		   $(call cc-option, -fno-inline-small-functions) \
> > +		   $(call cc-option, -fno-inline-functions-called-once)
> > +endif
> > +
> >   ifdef CONFIG_FUNCTION_TRACER
> >   ifdef CONFIG_FTRACE_MCOUNT_RECORD
> >     # gcc 5 supports generating the mcount tables directly
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 4966c4fbe7f7..0f9b4fa78b1c 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -211,6 +211,31 @@ config GDB_SCRIPTS
> >   	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
> >   	  for further details.
> > +config NO_AUTO_INLINE
> > +	bool "Disable compiler auto-inline optimizations"
> > +	help
> > +	  This will prevent the compiler from optimizing the kernel by
> > +	  auto-inlining functions not marked with the inline keyword.
> > +	  With this option, only functions explicitly marked with
> > +	  "inline" will be inlined. This will allow the function tracer
> > +	  to trace more functions because it only traces functions that
> > +	  the compiler has not inlined.
> > +
> > +	  Enabling this function can help debugging a kernel if using
> > +	  the function tracer. But it can also change how the kernel
> > +	  works, because inlining functions may change the timing,
> > +	  which could make it difficult while debugging race conditions.
> > +
> > +	  If unsure, select N.
> > +
> > +config ENABLE_WARN_DEPRECATED
> 
> This part doesn't look like it belongs in this patch, and judging by the
> commit message in 771c035372a0 wouldn't be welcome back anyway.
> 
opps, this is a rebasing mistake. Let me update it. Thanks.

> Robin.
> 
> > +	bool "Enable __deprecated logic"
> > +	default y
> > +	help
> > +	  Enable the __deprecated logic in the kernel build.
> > +	  Disable this to suppress the "warning: 'foo' is deprecated
> > +	  (declared at kernel/power/somefile.c:1234)" messages.
> > +
> >   config ENABLE_MUST_CHECK
> >   	bool "Enable __must_check logic"
> >   	default y
> > 

-- 
Thanks,
Du Changbin
