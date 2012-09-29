From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [Bulk] Re: [PATCH 5/10] compiler{,-gcc4}.h: Remove duplicate
 macros
Date: Fri, 28 Sep 2012 17:48:01 -0700
Message-ID: <20120929004800.GC14293@jtriplet-mobl1>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
 <1348874411-28288-6-git-send-email-daniel.santos@pobox.com>
 <20120929002329.GB13907@jtriplet-mobl1>
 <5066421C.20904@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44728 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758306Ab2I2AsJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 20:48:09 -0400
Content-Disposition: inline
In-Reply-To: <5066421C.20904@att.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On Fri, Sep 28, 2012 at 07:34:36PM -0500, Daniel Santos wrote:
> On 09/28/2012 07:23 PM, Josh Triplett wrote:
> > On Fri, Sep 28, 2012 at 06:20:06PM -0500, Daniel Santos wrote:
> >> __linktime_error() does the same thing as __compiletime_error() and is
> >> only used in bug.h.  Since the macro defines a function attribute that
> >> will cause a failure at compile-time (not link-time), it makes more
> >> sense to keep __compiletime_error(), which is also neatly mated with
> >> __compiletime_warning().
> >>
> >> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> > Why not change bug.h in the same commit?  Or alternatively, why not
> > change it first?
> I'm still new to this project's development process and wasn't sure if
> those two changes would be considered lumping multiple changes together
> or not.  So that type of lumping is acceptable then?  I certainly
> wouldn't mind squashing them.

In general, you shouldn't make *unrelated* changes in the same patch,
and you should definitely make fine-grained patches whenever
appropriate.  However, in this case the changes seem quite related.

The rule in the Linux kernel: the kernel should compile and function
after every individual patch.  You shouldn't introduce breakage in a
patch series and fix it later in that series.  Commonly called making
your patch series "bisectable", since it helps "git bisect" work more
smoothly to have every single git commit compile and run.  In this case,
you removed __linktime_error before removing its caller.

> > Getting rid of __linktime_error *before* changing its
> > use in bug.h to __compiletime_error seems wrong.
> Good point!

Thinking about it further, in this case I think it makes sense to just
reverse the two patches: remove the one and only use of
__linktime_error, then remove its definition.

- Josh Triplett
