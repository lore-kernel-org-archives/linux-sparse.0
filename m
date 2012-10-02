From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 8/10] bug.h: Make BUILD_BUG_ON generate compile-time error
Date: Tue, 02 Oct 2012 09:57:47 -0500
Message-ID: <506B00EB.400@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-9-git-send-email-daniel.santos@pobox.com> <CANN689G9vurJj3+MUygn3gk6LCYr9E-eMFp+22Wf6Vgo22HRKA@mail.gmail.com>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm14.bullet.mail.sp2.yahoo.com ([98.139.91.84]:21516 "HELO
	nm14.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751247Ab2JBO5n (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 2 Oct 2012 10:57:43 -0400
In-Reply-To: <CANN689G9vurJj3+MUygn3gk6LCYr9E-eMFp+22Wf6Vgo22HRKA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michel Lespinasse <walken@google.com>
Cc: Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On 10/01/2012 07:48 PM, Michel Lespinasse wrote:
> On Fri, Sep 28, 2012 at 4:20 PM, Daniel Santos <daniel.santos@pobox.com> wrote:
>> Negative sized arrays wont create a compile-time error in some cases
>> starting with gcc 4.4 (e.g., inlined functions), but gcc 4.3 introduced
>> the error function attribute that will.  This patch modifies
>> BUILD_BUG_ON to behave like BUILD_BUG already does, using the error
>> function attribute so that you don't have to build the entire kernel to
>> discover that you have a problem, and then enjoy trying to track it down
>> from a link-time error.
> Few other alternatives I've seen used in other projects (from memory,
> so I may have gotten the details wrong):
>
> 1) if (condition) { __asm__(".error \"Some error message\""); }
> 2) switch (0) {
>     case 0: break;
>     case !condition: break;
>     }
>     (fails to compile if !condition evaluates to 0)
>
> If you can get the first suggestion to work it'd be nice, as you could
> get some descriptive error message (you can add the line number there
> too).
Thanks for this info.  I'm still pretty noob-ish in modern assembly, but
is the .error directive available on all supported assemblers?  It
appears to have been added to GNU binutils in version 2.16 from what I
can tell (http://sourceware.org/binutils/docs-2.16/as/Error.html).  If
it is supported, I would definitely prefer that one as a fallback option.

I did a search on sources for the regex \.error\s+\\?" and didn't turn
up anything outside of arch/, so I'm guessing this may not be completely
portable.  Note also that these BUILD_BUG* macros do emit an error
message on gcc 4.3+ using __attribute__((error("msg"))).

Daniel
