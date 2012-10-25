From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 05/10] compiler{,-gcc4}.h, bug.h: Remove duplicate
 macros
Date: Thu, 25 Oct 2012 11:26:16 +0200
Message-ID: <20121025092616.GB16601@liondog.tnic>
References: <1351096132-12244-1-git-send-email-daniel.santos@pobox.com>
 <1351096441-12388-5-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351096441-12388-5-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: danielfsantos@att.net
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>
List-Id: linux-sparse@vger.kernel.org

On Wed, Oct 24, 2012 at 11:33:56AM -0500, danielfsantos@att.net wrote:
> __linktime_error() does the same thing as __compiletime_error() and is
> only used in bug.h.  Since the macro defines a function attribute that
> will cause a failure at compile-time (not link-time), it makes more
> sense to keep __compiletime_error(), which is also neatly mated with
> __compiletime_warning().
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> Acked-by: David Rientjes <rientjes@google.com>

Acked-by: Borislav Petkov <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.
