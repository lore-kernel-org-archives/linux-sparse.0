From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 8/10] bug.h: Make BUILD_BUG_ON generate compile-time error
Date: Fri, 28 Sep 2012 20:26:08 -0500
Message-ID: <50664E30.7050809@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-9-git-send-email-daniel.santos@pobox.com> <20120929003239.GA14293@jtriplet-mobl1>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm15-vm0.bullet.mail.ac4.yahoo.com ([98.139.52.236]:28650 "HELO
	nm15-vm0.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759095Ab2I2B0I (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 21:26:08 -0400
In-Reply-To: <20120929003239.GA14293@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On 09/28/2012 07:32 PM, Josh Triplett wrote:
> On Fri, Sep 28, 2012 at 06:20:09PM -0500, Daniel Santos wrote:
>> Negative sized arrays wont create a compile-time error in some cases
>> starting with gcc 4.4 (e.g., inlined functions), but gcc 4.3 introduced
>> the error function attribute that will.  This patch modifies
>> BUILD_BUG_ON to behave like BUILD_BUG already does, using the error
>> function attribute so that you don't have to build the entire kernel to
>> discover that you have a problem, and then enjoy trying to track it down
>> from a link-time error.
>
> Rather than doing both, and potentially producing two errors for the
> same issue, how about using __compiletime_error only, and only using the
> negative-sized array when __compiletime_error has no useful definition?
>
> For instance, in compiler.h, when defining __compiletime_error as an
> empty macro in the fallback case, you could define a
> __compiletime_error_fallback() macro that declares a negative-sized
> array; you could then define __compiletime_error_fallback() as an empty
> macro when it doesn't exist.
It may also make sense to define
#define BUILD_BUG() BUILD_BUG_ON(1)

I haven't examined this really closely yet and my eyes are getting a
little bleary :)


Really, I would have liked to be able to set the error message as
well, but we would have to have the macro generate a unique function
name for each time its expanded to make that work.  Example:

#define BUILD_BUG_ON(cond) BUILD_BUG_ON_MSG(cond, #cond)
#define BUILD_BUG_ON_MSG(cond, msg)                                \
    do {                                                           \
        extern void __build_bug_on_failed ## something_unique(void)\
            __compiletime_error("BUILD_BUG_ON failed: " msg);      \
        __compiletime_error_fallback(cond);                        \
        if (cond)                                                  \
            __build_bug_on_failed();                               \
    } while(0)

I just don't know any tricks to generate unique pre-processor
value automatically.

Daniel
