From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 8/10] bug.h: Make BUILD_BUG_ON generate compile-time error
Date: Fri, 28 Sep 2012 19:51:51 -0500
Message-ID: <50664627.6050302@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-9-git-send-email-daniel.santos@pobox.com> <20120929003239.GA14293@jtriplet-mobl1>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120929003239.GA14293@jtriplet-mobl1>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-sparse@vger.kernel.org

On 09/28/2012 07:32 PM, Josh Triplett wrote:
> On Fri, Sep 28, 2012 at 06:20:09PM -0500, Daniel Santos wrote:
>> Negative sized arrays wont create a compile-time error in some cases
>> starting with gcc 4.4 (e.g., inlined functions), but gcc 4.3 introduced
>> the error function attribute that will.  This patch modifies
>> BUILD_BUG_ON to behave like BUILD_BUG already does, using the error
>> function attribute so that you don't have to build the entire kernel to
>> discover that you have a problem, and then enjoy trying to track it down
>> from a link-time error.
> Rather than doing both, and potentially producing two errors for the
> same issue, how about using __compiletime_error only, and only using the
> negative-sized array when __compiletime_error has no useful definition?
>
> For instance, in compiler.h, when defining __compiletime_error as an
> empty macro in the fallback case, you could define a
> __compiletime_error_fallback() macro that declares a negative-sized
> array; you could then define __compiletime_error_fallback() as an empty
> macro when it doesn't exist.
Oh, that's a great idea.  That will keep more of the compiler's details
in compiler*.h.

Daniel
