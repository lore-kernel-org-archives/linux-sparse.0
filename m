From: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH 8/10] bug.h: Make BUILD_BUG_ON generate compile-time error
Date: Mon, 1 Oct 2012 17:48:18 -0700
Message-ID: <CANN689G9vurJj3+MUygn3gk6LCYr9E-eMFp+22Wf6Vgo22HRKA@mail.gmail.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
	<1348874411-28288-9-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348874411-28288-9-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Sep 28, 2012 at 4:20 PM, Daniel Santos <daniel.santos@pobox.com> wrote:
> Negative sized arrays wont create a compile-time error in some cases
> starting with gcc 4.4 (e.g., inlined functions), but gcc 4.3 introduced
> the error function attribute that will.  This patch modifies
> BUILD_BUG_ON to behave like BUILD_BUG already does, using the error
> function attribute so that you don't have to build the entire kernel to
> discover that you have a problem, and then enjoy trying to track it down
> from a link-time error.

Few other alternatives I've seen used in other projects (from memory,
so I may have gotten the details wrong):

1) if (condition) { __asm__(".error \"Some error message\""); }
2) switch (0) {
    case 0: break;
    case !condition: break;
    }
    (fails to compile if !condition evaluates to 0)

If you can get the first suggestion to work it'd be nice, as you could
get some descriptive error message (you can add the line number there
too).

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
