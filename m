From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 0/9] Cleanup & new features for compiler*.h and bug.h
Date: Thu, 22 Nov 2012 14:44:10 +0100
Message-ID: <20121122134410.GE17147@x1.alien8.de>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
 <1353444132-6809-1-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353444132-6809-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Nov 20, 2012 at 02:42:03PM -0600, danielfsantos@att.net wrote:
> 
>  include/linux/bug.h           |   47 ++++++++++++++++++++++------------------
>  include/linux/compiler-gcc.h  |    3 ++
>  include/linux/compiler-gcc3.h |    8 +++---
>  include/linux/compiler-gcc4.h |   28 ++++++++++++------------
>  include/linux/compiler.h      |   32 +++++++++++++++++++++++++--
>  5 files changed, 76 insertions(+), 42 deletions(-)

Ok,

this patchset is slowly but surely getting into a mergeable state and
could probably use wider testing in linux-next right about now.

Maybe akpm can pick it up into -mm so that it sees -next and then if all
is fine maybe find its way upstream in the next merge window, AFAICT.

Thanks.

-- 
Regards/Gruss,
Boris.
