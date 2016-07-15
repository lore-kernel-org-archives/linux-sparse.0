From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
Date: Fri, 15 Jul 2016 14:36:16 -0400
Message-ID: <20160715143616.5b3d063e@gandalf.local.home>
References: <20160627151500.2247A68D20@newverein.lst.de>
	<20160627151717.BD25468D26@newverein.lst.de>
	<20160708145800.GE3556@pathway.suse.cz>
	<20160708150709.GA8979@lst.de>
	<20160708152421.GG3556@pathway.suse.cz>
	<20160708154824.ikq45dgk2auigqn7@treble>
	<20160708115710.5c657b5f@gandalf.local.home>
	<20160708202455.GA4580@lst.de>
	<20160708170808.1ab70ce3@gandalf.local.home>
	<20160709090632.GA2598@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:52155 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751423AbcGOSgV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 15 Jul 2016 14:36:21 -0400
In-Reply-To: <20160709090632.GA2598@lst.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Torsten Duwe <duwe@lst.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Petr Mladek <pmladek@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org

On Sat, 9 Jul 2016 11:06:32 +0200
Torsten Duwe <duwe@lst.de> wrote:


> Maybe the code in question can be replaced with the change below, now that
> there is a preprocessor define in V2?
> (untested)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 3f743b1..695a646 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2423,6 +2423,12 @@ ftrace_code_disable(struct module *mod, struct dyn_ftrace *rec)
>  	if (unlikely(ftrace_disabled))
>  		return 0;
>  
> +#ifdef CC_USING_PROLOG_PAD
> +	/* If the compiler already generated NOPs instead of
> +	 * calls to mcount, we're done here.
> +	*/
> +	return 1;
> +#endif

I really hate adding #ifdef's like this in generic code if the arch can
handle it with some other means.

-- Steve


>  	ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
>  	if (ret) {
>  		ftrace_bug(ret, rec);

