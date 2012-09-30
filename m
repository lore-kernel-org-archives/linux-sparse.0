From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 3/10] compiler-gcc.h: Add gcc-recommended GCC_VERSION
 macro
Date: Sun, 30 Sep 2012 18:11:01 -0500
Message-ID: <5068D185.9000802@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-4-git-send-email-daniel.santos@pobox.com>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm14-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.246]:22051 "HELO
	nm14-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751197Ab2I3XLB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Sep 2012 19:11:01 -0400
In-Reply-To: <1348874411-28288-4-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>, Josh Triplett <josh@joshtriplett.org>

So in light of feedback I've been getting on this patch set, it leaves
me with
this question.
> +#define GCC_VERSION (__GNUC__ * 10000 \
> +		   + __GNUC_MINOR__ * 100 \
> +		   + __GNUC_PATCHLEVEL__)
This macro presumes you are using gcc 3.0 or later, which introduced the
__GNUC_PATCHLEVEL__ predefined macro.  Should you be using a version of gcc
prior to 3.0 (where the macro is undefined), you would get an error that
__GNUC_PATCHLEVEL__ is undefined prior to getting the error trying to
include
"linux/compiler-gcc2.h".  So it presumes the compiler is 3.0+, when another
part of the code may allow it from a future change.  Should it be
modified to
do account for this or would that be overkill?


#ifdef __GNUC_PATCHLEVEL__
# define GCC_VERSION (__GNUC__ * 10000 \
                    + __GNUC_MINOR__ * 100 \
                    + __GNUC_PATCHLEVEL__)
#else
# define GCC_VERSION (__GNUC__ * 10000 \
                    + __GNUC_MINOR__ * 100)
#endif

Daniel
