From: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
Date: Fri, 8 Jul 2016 17:07:09 +0200
Message-ID: <20160708150709.GA8979@lst.de>
References: <20160627151500.2247A68D20@newverein.lst.de> <20160627151717.BD25468D26@newverein.lst.de> <20160708145800.GE3556@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160708145800.GE3556@pathway.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Fri, Jul 08, 2016 at 04:58:00PM +0200, Petr Mladek wrote:
> On Mon 2016-06-27 17:17:17, Torsten Duwe wrote:
> > Once gcc is enhanced to optionally generate NOPs at the beginning
> > of each function, like the concept proven in
> > https://gcc.gnu.org/ml/gcc-patches/2016-04/msg01671.html
> > (sans the "fprintf (... pad_size);", which spoils the data structure
> > for kernel use), the generated pads can nicely be used to reroute
> > function calls for tracing/profiling, or live patching.
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index ebecf9a..917065c 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -39,6 +39,12 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
> >  		if (aarch64_insn_read((void *)pc, &replaced))
> >  			return -EFAULT;
> >  
> > +		/* If we already have what we'll finally want,
> > +		 * report success. This is needed on startup.
> > +		 */
> > +		if (replaced == new)
> > +			return 0;
> 
> This looks strange. I wonder if it actually hides a real bug that we
> modify the code twice or so.

Not at all. All "profilers" we abused so far generate code that needs to
be disabled on boot first. prolog-pad generates nops, initially.

	Torsten
