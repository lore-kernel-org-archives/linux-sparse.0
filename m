From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 6/9] bug.h: Prevent double evaulation of in
 BUILD_BUG_ON
Date: Thu, 15 Nov 2012 16:07:27 +0100
Message-ID: <20121115150726.GD4956@x1.osrc.amd.com>
References: <1352844568-18826-1-git-send-email-daniel.santos@pobox.com>
 <1352844821-18952-6-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352844821-18952-6-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Nov 13, 2012 at 04:13:38PM -0600, danielfsantos@att.net wrote:
> When calling BUILD_BUG_ON in an optimized build using gcc 4.3 and later,
> the condition will be evaulated twice, possibily with side-effects.
> This patch eliminates that error.
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> ---
>  include/linux/bug.h |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index 1b2465d..ccd44ce 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -58,8 +58,9 @@ struct pt_regs;
>  extern int __build_bug_on_failed;
>  #define BUILD_BUG_ON(condition)					\
>  	do {							\
> -		((void)sizeof(char[1 - 2*!!(condition)]));	\
> -		if (condition) __build_bug_on_failed = 1;	\
> +		bool __cond = !!(condition);			\
> +		((void)sizeof(char[1 - 2*!!(__cond)]));		\

No need for the !!(__cond) here because you've done it in the line
above. IOW,

	bool __cond = !!(condition);
	((void)sizeof(char[1 - 2 * __cond]));

which is even a bit more readable, as a matter of fact.

> +		if (__cond) __build_bug_on_failed = 1;		\
>  	} while(0)
>  #endif

Thanks.

-- 
Regards/Gruss,
Boris.
