From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v2 07/10] compiler.h, bug.h: Prevent double error messages
 with BUILD_BUG{,_ON}
Date: Fri, 05 Oct 2012 23:28:49 -0500
Message-ID: <506FB381.4030605@att.net>
References: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com> <1349466169-20637-7-git-send-email-daniel.santos@pobox.com> <20121005205922.GA7362@jtriplet-mobl1>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm22.bullet.mail.bf1.yahoo.com ([98.139.212.181]:37941 "EHLO
	nm22.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115Ab2JFE2x (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Oct 2012 00:28:53 -0400
In-Reply-To: <20121005205922.GA7362@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Daniel Santos <daniel.santos@pobox.com>

On 10/05/2012 03:59 PM, Josh Triplett wrote:
> On Fri, Oct 05, 2012 at 02:42:46PM -0500, danielfsantos@att.net wrote:
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -296,6 +296,11 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
>>  #endif
>>  #ifndef __compiletime_error
>>  # define __compiletime_error(message)
>> +# define __compiletime_error_fallback(condition) \
>> +	 ((void)sizeof(char[1 - 2*!!(condition)]))
>> +#endif
>> +#ifndef __compiletime_error_fallback
>> +# define __compiletime_error_fallback(condition) (void)(0)
>
> Might want to use do { } while (0) here, to force the use of a
> semicolon and avoid the use of __compiletime_error_fallback in an
> expression.
Sure!  But while we're here, we may want to consider a few other macros
in bug.h.  These two are intended to be used as an expression:

#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))

They are using a different technique to generate the compile-time error,
perhaps because the negative sized array wasn't always working past gcc
4.4? Either way, perhaps these can become

#define BUILD_BUG_ON_ZERO(e) ({BUILD_BUG_ON(e); 0;})
#define BUILD_BUG_ON_NULL(e) ({BUILD_BUG_ON(e); (void*)0;})

This would again give us our cute error message.  However, I don't know
when this style of expression began to be supported (I know it's a gcc
extension), but I'm guessing it's pre gcc 3.2 because it's used in
kernel.h.  Also:

#define BUILD_BUG_ON_NOT_POWER_OF_2(n)            \
        BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))

can become:

#define BUILD_BUG_ON_NOT_POWER_OF_2(n)                         \
        BUILD_BUG_ON_MSG((n) == 0 || (((n) & ((n) - 1)) != 0), \
                         #n " not a power of two")

I think the only thing that would leave unfinished is the __OPTIMIZE__ check
in the BUILD_BUG_ON definition.  This is a throw-back to the days before
BUILD_BUG_ON_NON_CONST (oops, that's still in another patch set).  Well, if
you look at version 1 of this patch set, you'll see that it has that check,
since __builtin_constant_p never returns one in an unoptimized build.
However, that's a bit more work because we will need to examine every use of
BUILD_BUG_ON and __builtin_constant_p.  I only found 2-3 last time I looked,
one of which was commented outwith the remark that it "breaks in funny
ways",
which we certainly already know about __builtin_constant_p.  Another was a
pretty complicated expression, but I'll have to look them up again.

Please let me know what you think.

Daniel
