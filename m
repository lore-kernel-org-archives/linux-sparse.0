From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 6/10] bug.h: Replace __linktime_error with
 __compiletime_error
Date: Fri, 28 Sep 2012 17:23:53 -0700
Message-ID: <20120929002353.GC13907@jtriplet-mobl1>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
 <1348874411-28288-7-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43487 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759228Ab2I2AYB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 20:24:01 -0400
Content-Disposition: inline
In-Reply-To: <1348874411-28288-7-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On Fri, Sep 28, 2012 at 06:20:07PM -0500, Daniel Santos wrote:
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> ---
>  include/linux/bug.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index aaac4bb..298a916 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -73,7 +73,7 @@ extern int __build_bug_on_failed;
>  #define BUILD_BUG()						\
>  	do {							\
>  		extern void __build_bug_failed(void)		\
> -			__linktime_error("BUILD_BUG failed");	\
> +			__compiletime_error("BUILD_BUG failed");\
>  		__build_bug_failed();				\
>  	} while (0)

This change should either occur as part of patch 5 or before patch 5,
not after.

- Josh Triplett
