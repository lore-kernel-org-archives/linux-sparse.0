From: David Rientjes <rientjes@google.com>
Subject: Re: [Bulk] Re: [PATCH 4/10] compiler-gcc{3,4}.h: Use GCC_VERSION
 macro
Date: Tue, 2 Oct 2012 23:40:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210022337400.12717@chino.kir.corp.google.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-5-git-send-email-daniel.santos@pobox.com> <20120929002029.GA13907@jtriplet-mobl1> <50664179.5090608@att.net> <20120929004231.GB14293@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120929004231.GB14293@jtriplet-mobl1>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, 28 Sep 2012, Josh Triplett wrote:

> GCC 4.1.0 and 4.1.1 miscompiling __weak has nothing to do with
> __compiletime_object_size; why should *this* version check exclude those
> versions?
> 

Agreed, we shouldn't be relying on any #error directives to fail the build 
and then try to factor those version numbers out of other directives; if 
the #error directive were ever to be removed (or commented out, like in 
this case), nobody would make the other directives inclusive of that 
now-allowed version where things like __compiletime_object_size() are 
valid.

After __compiletime_object_size() is compiled for GCC_VERSION >= 40100, 
then:

	Acked-by: David Rientjes <rientjes@google.com>
