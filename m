From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v4 9/9] bug.h: Convert BUILD_BUG{,_ON} to use
 BUILD_BUG_ON_MSG
Date: Tue, 30 Oct 2012 18:02:32 -0700
Message-ID: <20121031010232.GA18229@leaf>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com>
 <1351457835-7553-9-git-send-email-daniel.santos@pobox.com>
 <20121030191905.GG28499@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57712 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419Ab2JaBCm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 30 Oct 2012 21:02:42 -0400
Content-Disposition: inline
In-Reply-To: <20121030191905.GG28499@liondog.tnic>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>

On Tue, Oct 30, 2012 at 08:19:05PM +0100, Borislav Petkov wrote:
> On Sun, Oct 28, 2012 at 03:57:15PM -0500, danielfsantos@att.net wrote:
> > Remove duplicate code by converting BUILD_BUG and BUILD_BUG_ON to just
> > call BUILD_BUG_ON_MSG.  This not only reduces source code bloat, but
> > also prevents the possibility of code being changed for one macro and
> > not for the other (which was previously the case for BUILD_BUG and
> > BUILD_BUG_ON).
> > 
> > Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> > ---
> >  include/linux/bug.h |   17 +++--------------
> >  1 files changed, 3 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/bug.h b/include/linux/bug.h
> > index 3bc1ddf..b58ba51 100644
> > --- a/include/linux/bug.h
> > +++ b/include/linux/bug.h
> > @@ -81,14 +81,8 @@ struct pt_regs;
> >  #ifndef __OPTIMIZE__
> >  #define BUILD_BUG_ON(condition) __compiletime_error_fallback(condition)
> >  #else
> > -#define BUILD_BUG_ON(condition)						\
> > -	do {								\
> > -		extern void __build_bug_on_failed(void)			\
> > -			__compiletime_error("BUILD_BUG_ON failed");	\
> > -		__compiletime_error_fallback(condition);		\
> > -		if (condition)						\
> > -			__build_bug_on_failed();			\
> > -	} while(0)
> > +#define BUILD_BUG_ON(condition) \
> > +	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> 
> Concatenating "condition" might not be very informative in all cases.
> For example:
> 
> BUILD_BUG_ON(1);
> 
> Having __LINE__ is good enough IMHO.

While it doesn't always help, it may help sometimes.  Worst case,
BUILD_BUG_ON(1) gives you no less information than it did before; best
case, it gives you useful data.

- Josh Triplett
