From: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH v6 0/9] Cleanup & new features for compiler*.h and bug.h
Date: Tue, 20 Nov 2012 18:35:26 -0800
Message-ID: <CANN689EqSVGexh7PbrmBNofEPBQn9BZQ3s3ApvX7cBHso1jOXQ@mail.gmail.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
	<1353444132-6809-1-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353444132-6809-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: danielfsantos@att.net
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Daniel Santos <daniel.santos@pobox.com>
List-Id: linux-sparse@vger.kernel.org

On Tue, Nov 20, 2012 at 12:42 PM,  <danielfsantos@att.net> wrote:
>
>  include/linux/bug.h           |   47 ++++++++++++++++++++++------------------
>  include/linux/compiler-gcc.h  |    3 ++
>  include/linux/compiler-gcc3.h |    8 +++---
>  include/linux/compiler-gcc4.h |   28 ++++++++++++------------
>  include/linux/compiler.h      |   32 +++++++++++++++++++++++++--
>  5 files changed, 76 insertions(+), 42 deletions(-)
>
> Changes in v6:
> o Remove extraneous double negation
> o Fixed faulty macro expansion in last patch

Acked-by: Michel Lespinasse <walken@google.com> on the entire v6 series.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
