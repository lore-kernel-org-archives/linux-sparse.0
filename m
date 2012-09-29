From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 8/10] bug.h: Make BUILD_BUG_ON generate compile-time error
Date: Fri, 28 Sep 2012 17:32:39 -0700
Message-ID: <20120929003239.GA14293@jtriplet-mobl1>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
 <1348874411-28288-9-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44938 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759246Ab2I2Acr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 20:32:47 -0400
Content-Disposition: inline
In-Reply-To: <1348874411-28288-9-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On Fri, Sep 28, 2012 at 06:20:09PM -0500, Daniel Santos wrote:
> Negative sized arrays wont create a compile-time error in some cases
> starting with gcc 4.4 (e.g., inlined functions), but gcc 4.3 introduced
> the error function attribute that will.  This patch modifies
> BUILD_BUG_ON to behave like BUILD_BUG already does, using the error
> function attribute so that you don't have to build the entire kernel to
> discover that you have a problem, and then enjoy trying to track it down
> from a link-time error.

Rather than doing both, and potentially producing two errors for the
same issue, how about using __compiletime_error only, and only using the
negative-sized array when __compiletime_error has no useful definition?

For instance, in compiler.h, when defining __compiletime_error as an
empty macro in the fallback case, you could define a
__compiletime_error_fallback() macro that declares a negative-sized
array; you could then define __compiletime_error_fallback() as an empty
macro when it doesn't exist.

- Josh Triplett
