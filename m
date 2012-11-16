From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v5 9/9] bug.h, compiler.h: Introduce compiletime_assert
 & BUILD_BUG_ON_MSG
Date: Fri, 16 Nov 2012 17:25:09 -0600
Message-ID: <50A6CB55.7070706@att.net>
References: <1352844568-18826-1-git-send-email-daniel.santos@pobox.com> <1352844821-18952-9-git-send-email-daniel.santos@pobox.com>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm4.access.bullet.mail.sp2.yahoo.com ([98.139.44.131]:28750
	"EHLO nm4.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753769Ab2KPXZK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 16 Nov 2012 18:25:10 -0500
In-Reply-To: <1352844821-18952-9-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On 11/13/2012 04:13 PM, danielfsantos@att.net wrote:
> +#define __compiletime_assert(condition, msg, __func)			\
> +	do {								\
> +		bool __cond = !(condition);				\
> +		extern void __func(void) __compiletime_error(msg);	\
> +		if (__cond)						\
> +			__func();					\
> +		__compiletime_error_fallback(__cond);			\
> +	} while (0)
> +
> +#define _compiletime_assert(condition, msg, __func) \
> +	__compiletime_assert(condition, msg, __func)
> +
> +/**
> + * compiletime_assert - break build and emit msg if condition is false
> + * @condition: a compile-time constant condition to check
> + * @msg:       a message to emit if condition is false
> + *
> + * In tradition of POSIX assert, this macro will break the build if the
> + * supplied condition is *false*, emitting the supplied error message if the
> + * compiler has support to do so.
> + */
> +#define compiletime_assert(condition, msg) \
> +	_compiletime_assert(condition, msg, __compiletime_assert_ ## __LINE__)
> +

Whoops, this implementation pastes the tokens before allowing them to
expand, it should be something like this:

#define __compiletime_assert(condition, msg, __func) .... stuff
#define _compiletime_assert(condition, msg, prefix, suffix) \
        __compiletime_assert(condition, msg, prefix ## suffix)
#define compiletime_assert(condition, msg) \
        _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)

I'll fix that as well.

Daniel
