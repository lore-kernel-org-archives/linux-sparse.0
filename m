From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Fix context checking detection of a reversed lock-pair
 within a basic block
Date: Tue, 5 Jan 2016 14:23:46 +0100
Message-ID: <20160105132345.GA1044@macpro.local>
References: <1447780678-7431-1-git-send-email-odinguru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38668 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbcAENXw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Jan 2016 08:23:52 -0500
Received: by mail-wm0-f50.google.com with SMTP id b14so28820743wmb.1
        for <linux-sparse@vger.kernel.org>; Tue, 05 Jan 2016 05:23:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447780678-7431-1-git-send-email-odinguru@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Holmer <odinguru@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Nov 17, 2015 at 12:17:58PM -0500, David Holmer wrote:
> This commit adds a new validation test case with a simple lock context
> issue that was not previously caught by sparse. This test case is a simple
> "reversed" lock pair (unlock/lock instead of lock/unlock):
> +static void warn_reverse(void)
> +{
> +    r();
> +    a();
> +}
> 
> Previously, sparse would not flag this context imbalance because it happens
> WITHIN a single basic block and imbalance checking was only done at the
> boundaries of basic blocks. In this case, the lock following the unlock
> results in a net context change of zero for this basic block, so checking
> only at the boundaries of basic blocks is insufficient.
 
Indeed, nice catch.

I have a few remarks and suggestions here under.

> Primarily, this commit moves the checking for "unexpected unlock" inside
> the context_increase function where it can correctly detect the new test
> case as well as all other existing test cases.
> 
> In order to accommodate the primary change, some additional ancillary
> changes are made:
> * The entry point is added as an argument to context_increase() so that it
>   can be passed to imbalance() if needed.

This is not needed because a basic block's entry point is available as bb->ep.

> * The two arguments entry and exit are removed from imbalance() as they are
>   currently unused in the function and it simplifies calling it in the new
>   location (all call sites of imbalance() are changed).

Better put this is a separate patch.

> * A prototype for imbalance() is added at top of the file as a call is now
>   made before the function is defined.
> 
> Signed-off-by: David Holmer <odinguru@gmail.com>
> ---
>  sparse.c             | 19 ++++++++++++-------
>  validation/context.c |  8 ++++++++
>  2 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/sparse.c b/sparse.c
> index 6b3324c..85b92e9 100644
> --- a/sparse.c
> +++ b/sparse.c
> @@ -40,7 +40,9 @@
>  #include "expression.h"
>  #include "linearize.h"
>  
> -static int context_increase(struct basic_block *bb, int entry)
> +static int imbalance(struct entrypoint *ep, struct basic_block *bb, const char *why);
> +
> +static int context_increase(struct entrypoint *ep, struct basic_block *bb, int entry)
>  {
>  	int sum = 0;
>  	struct instruction *insn;
> @@ -61,11 +63,15 @@ static int context_increase(struct basic_block *bb, int entry)
>  			continue;
>  		}
>  		sum += val;
> +		if (entry + sum < 0) {
> +			imbalance(ep, bb, "unexpected unlock");
> +			return sum;

This early return is wrong to me.
We want to check the other instructions too and have the correct value for
the basic block's net context change.

> @@ -103,12 +109,11 @@ static int check_bb_context(struct entrypoint *ep, struct basic_block *bb, int e
>  
>  	/* Now that's not good.. */
>  	if (bb->context >= 0)
> -		return imbalance(ep, bb, entry, bb->context, "different lock contexts for basic block");
> +		return imbalance(ep, bb, "different lock contexts for basic block");
>  
>  	bb->context = entry;
> -	entry += context_increase(bb, entry);
> -	if (entry < 0)
> -		return imbalance(ep, bb, entry, exit, "unexpected unlock");
> +	entry += context_increase(ep, bb, entry);
> +	if (entry < 0) return -1;

1) Better leave the 'if' and the 'return' on separate lines, like they were.
2) Without the early return here above, the return -1 is nor needed, nor desirable.
   What I would suggest is:
   - to leave the call to imbalance() here; it give a warning message about a
     *basic block* imbalance (non-zero net context change).
   - add another small helper to give a warning message about other kind
     of context errors, using the position on the offending *instruction*,
     Use this one in your new check in context_increase(), maybe using a message
     stating more explicitly that we're trying to unlock a lock that is not held.


> diff --git a/validation/context.c b/validation/context.c
> index 33b70b8..c0a5357 100644
> --- a/validation/context.c
> +++ b/validation/context.c
> @@ -314,6 +314,13 @@ static void warn_cond_lock1(void)
>          condition2 = 1; /* do stuff */
>      r();
>  }
> +
> +static void warn_reverse(void)
> +{
> +    r();
> +    a();
> +}
> +

It would be nice to also add a case for when the function is annotated
with context entry and exit values; something like
	+static void warn_reverse2(void)__attribute__((context(0,0)))
	+{
	+    r();
	+    a();
	+}
	+
	+static void good_reverse2(void)__attribute__((context(1,1)))
	+{
	+    r();
	+    a();
	+}
	+


Yours,
Luc
