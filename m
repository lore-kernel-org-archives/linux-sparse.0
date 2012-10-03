From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 2/10] compiler-gcc4.h: Reorder macros based upon gcc
 ver
Date: Tue, 2 Oct 2012 23:28:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210022328220.12717@chino.kir.corp.google.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-3-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348874411-28288-3-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, 28 Sep 2012, Daniel Santos wrote:

> This helps to keep the file from getting confusing, removes one
> duplicate version check and should encourage future editors to put new
> macros where they belong.
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>

Acked-by: David Rientjes <rientjes@google.com>
