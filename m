From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v7 1/9] compiler-gcc4.h: Reorder macros based upon gcc
 ver
Date: Tue, 01 Jan 2013 15:27:30 -0600
Message-ID: <50E354C2.4060808@att.net>
References: <1357074491-21669-1-git-send-email-daniel.santos@pobox.com> <1357074597-21722-1-git-send-email-daniel.santos@pobox.com>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357074597-21722-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Santos <daniel.santos@pobox.com>
List-Id: linux-sparse@vger.kernel.org

On 01/01/2013 03:09 PM, danielfsantos@att.net wrote:

>   #ifdef CONFIG_ARCH_USE_BUILTIN_BSWAP
> -#if __GNUC_MINOR__>= 4
> +#if GCC_VERSION>= 40400
>   #define __HAVE_BUILTIN_BSWAP32__
>   #define __HAVE_BUILTIN_BSWAP64__
>   #endif
> -#if __GNUC_MINOR__>= 8 || (defined(__powerpc__)&&  __GNUC_MINOR__>= 6)
> +#if GCC_VERSION>= 40800 || (defined(__powerpc__)&&  GCC_VERSION>= 40600)
>   #define __HAVE_BUILTIN_BSWAP16__
>   #endif
> -#endif
> +#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP */
I'm terribly sorry, I appear to have broken bisectability here.
