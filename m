From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH 2/5] kbuild: LLVMLinux: Adapt warnings for compilation
 with clang
Date: Tue, 25 Feb 2014 17:31:21 -0800
Message-ID: <530D43E9.6010207@converseincode.com>
References: <1393376923-21892-1-git-send-email-behanw@converseincode.com> <1393376923-21892-3-git-send-email-behanw@converseincode.com> <20140226011737.GA4564@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140226011737.GA4564@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>, mmarek@suse.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, sparse@chrisli.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org, dwmw2@infradead.org, pageexec@freemail.hu, =?ISO-8859-1?Q?Jan-Simon_M=F6?= =?ISO-8859-1?Q?ller?= <dl9pf@gmx.de>, Mark Charlebois <mcharleb@gmail.com>
List-Id: linux-sparse@vger.kernel.org

On 02/25/14 17:17, Dave Jones wrote:
> On Tue, Feb 25, 2014 at 05:08:40PM -0800, behanw@converseincode.com wrote:
>   > +warning-1 += $(call cc-disable-warning, self-assign)
>
> Do you have a pointer to an example log-file from before this change ?
> I'm curious for eg, which self-assign warnings are showing up,
> because I've been fixing up the ones that Coverity found, of which
> there are only a dozen or so left iirc.
>
> Some of the others may also be interesting.
I don't have one now, but I can generate a log and send it to you. We've 
had that option set from near the beginning of the porting effort.

This are primarily off due to the amount of noise these warnings produce 
at this time (clang produces a LOT of warnings straight out of the box). 
I'd love to eventually turn some of these back on again.

Thanks,

Behan

-- 
Behan Webster
behanw@converseincode.com
