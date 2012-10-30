From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 8/9] bug.h: Add BUILD_BUG_ON_MSG & _BUILD_BUG_INTERNAL
Date: Tue, 30 Oct 2012 22:57:30 +0100
Message-ID: <20121030215729.GB9558@liondog.tnic>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com>
 <1351457835-7553-8-git-send-email-daniel.santos@pobox.com>
 <20121030171747.GF28499@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121030171747.GF28499@liondog.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>
List-Id: linux-sparse@vger.kernel.org

On Tue, Oct 30, 2012 at 06:17:47PM +0100, Borislav Petkov wrote:
> can BUILD_BUG_ON and BUILD_BUG_ON_MSG both use __BUILD_BUG_INTERNAL?
>
> In the BUILD_BUG_ON msg will be "BUILD_BUG_ON failed" and line empty.
> Can that even work?

Yes it can, I should simply look at patch 9/9 first :-).

-- 
Regards/Gruss,
    Boris.
