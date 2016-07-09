From: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
Date: Sat, 9 Jul 2016 11:06:32 +0200
Message-ID: <20160709090632.GA2598@lst.de>
References: <20160627151500.2247A68D20@newverein.lst.de>
 <20160627151717.BD25468D26@newverein.lst.de>
 <20160708145800.GE3556@pathway.suse.cz>
 <20160708150709.GA8979@lst.de>
 <20160708152421.GG3556@pathway.suse.cz>
 <20160708154824.ikq45dgk2auigqn7@treble>
 <20160708115710.5c657b5f@gandalf.local.home>
 <20160708202455.GA4580@lst.de>
 <20160708170808.1ab70ce3@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39425 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932860AbcGIJGs (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jul 2016 05:06:48 -0400
Content-Disposition: inline
In-Reply-To: <20160708170808.1ab70ce3@gandalf.local.home>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Petr Mladek <pmladek@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org

On Fri, Jul 08, 2016 at 05:08:08PM -0400, Steven Rostedt wrote:
> On Fri, 8 Jul 2016 22:24:55 +0200
> Torsten Duwe <duwe@lst.de> wrote:
> 
> > On Fri, Jul 08, 2016 at 11:57:10AM -0400, Steven Rostedt wrote:
> > > On Fri, 8 Jul 2016 10:48:24 -0500
> > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:  
> > > > 
> > > > Here, with -fprolog-pad, it's already a nop, so no change is needed.
> > > >   
> > 
> > Yes, exactly.
> > 
> > > That's what I was thinking. But as I stated in another email (probably
> > > in the air when you wrote this), the call to ftrace_modify_code() may be
> > > completely circumvented by ftrace_make_nop() if the addr is MCOUNT_ADDR.  
> > 
> > Only on the _first_ invocation. Later on, tracing can be switched on and off,
> > and then the instructions need to be changed just like with fentry (or
> > profile-kernel ;-)
> > 
> 
> Understood, but ftrace_modify_code() will only receive addr ==
> MCOUNT_ADDR on boot up or when a module is loaded. In both cases, with
> -fprolog-pad it will already be a nop, hence no need to call
> ftrace_modify_code(), in those cases.
> 
> In all other cases, addr will point to a ftrace trampoline.

Maybe the code in question can be replaced with the change below, now that
there is a preprocessor define in V2?
(untested)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3f743b1..695a646 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2423,6 +2423,12 @@ ftrace_code_disable(struct module *mod, struct dyn_ftrace *rec)
 	if (unlikely(ftrace_disabled))
 		return 0;
 
+#ifdef CC_USING_PROLOG_PAD
+	/* If the compiler already generated NOPs instead of
+	 * calls to mcount, we're done here.
+	*/
+	return 1;
+#endif
 	ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
 	if (ret) {
 		ftrace_bug(ret, rec);
