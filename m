From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/10] compiler-gcc.h: Add gcc-recommended GCC_VERSION
 macro
Date: Sun, 30 Sep 2012 15:20:55 +0200
Message-ID: <20120930132055.GA15400@liondog.tnic>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
 <1348874411-28288-4-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56878 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab2I3NVB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Sep 2012 09:21:01 -0400
Content-Disposition: inline
In-Reply-To: <1348874411-28288-4-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On Fri, Sep 28, 2012 at 06:20:04PM -0500, Daniel Santos wrote:
> Throughout compiler*.h, many version checks are made.  These can be
> simplified by using the macro that gcc's documentation recommends.
> However, my primary reason for adding this is that I need bug-check
> macros that are enabled at certain gcc versions and it's cleaner to use
> this macro than the tradition method:
> 
> if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ => 2)
> 
> If you add patch level, it gets this ugly:
> 
> if __GNUC__ > 4 || (__GNUC__ == 4 && (__GNUC_MINOR__ > 2 || \
>    __GNUC_MINOR__ == 2 __GNUC_PATCHLEVEL__ >= 1))
> 
> As opposed to:
> 
> if GCC_VERSION >= 40201
> 
> While having separate headers for gcc 3 & 4 eliminates some of this
> verbosity, they can still be cleaned up by this.

Yes,

very fine readability improvement.

Acked-by: Borislav Petkov <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.
