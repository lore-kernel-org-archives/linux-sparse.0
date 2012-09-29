From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 6/10] bug.h: Replace __linktime_error with
 __compiletime_error
Date: Fri, 28 Sep 2012 21:04:35 -0400
Message-ID: <1348880675.22822.102.camel@gandalf.local.home>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
	 <1348874411-28288-7-git-send-email-daniel.santos@pobox.com>
	 <20120929002353.GC13907@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:21229 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030216Ab2I2BEi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 21:04:38 -0400
In-Reply-To: <20120929002353.GC13907@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Fri, 2012-09-28 at 17:23 -0700, Josh Triplett wrote:
> On Fri, Sep 28, 2012 at 06:20:07PM -0500, Daniel Santos wrote:
> > Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> > ---
> >  include/linux/bug.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/linux/bug.h b/include/linux/bug.h
> > index aaac4bb..298a916 100644
> > --- a/include/linux/bug.h
> > +++ b/include/linux/bug.h
> > @@ -73,7 +73,7 @@ extern int __build_bug_on_failed;
> >  #define BUILD_BUG()						\
> >  	do {							\
> >  		extern void __build_bug_failed(void)		\
> > -			__linktime_error("BUILD_BUG failed");	\
> > +			__compiletime_error("BUILD_BUG failed");\
> >  		__build_bug_failed();				\
> >  	} while (0)
> 
> This change should either occur as part of patch 5 or before patch 5,
> not after.

I noticed the same thing and was about to comment on it.

Please do not break bisectablity. All your patches should compile and
run at every step.

-- Steve


