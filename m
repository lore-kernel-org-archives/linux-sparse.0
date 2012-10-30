From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 1/9] compiler-gcc4.h: Reorder macros based upon gcc ver
Date: Tue, 30 Oct 2012 13:02:06 +0100
Message-ID: <20121030120206.GE16455@liondog.tnic>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com>
 <1351457835-7553-1-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351457835-7553-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 28, 2012 at 03:57:07PM -0500, danielfsantos@att.net wrote:
> This helps to keep the file from getting confusing, removes one
> duplicate version check and should encourage future editors to put new
> macros where they belong.
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> Acked-by: David Rientjes <rientjes@google.com>

Acked-by: Borislav Petkov <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.
