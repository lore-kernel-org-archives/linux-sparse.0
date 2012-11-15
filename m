From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 5/9] bug.h: Fix BUILD_BUG_ON macro in __CHECKER__
Date: Thu, 15 Nov 2012 16:07:35 +0100
Message-ID: <20121115150735.GE4956@x1.osrc.amd.com>
References: <1352844568-18826-1-git-send-email-daniel.santos@pobox.com>
 <1352844821-18952-5-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56487 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768160Ab2KOPHS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 15 Nov 2012 10:07:18 -0500
Content-Disposition: inline
In-Reply-To: <1352844821-18952-5-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On Tue, Nov 13, 2012 at 04:13:37PM -0600, danielfsantos@att.net wrote:
> When __CHECKER__ is defined, we disable all of the BUILD_BUG.* macros.
> However, both BUILD_BUG_ON_NOT_POWER_OF_2 and BUILD_BUG_ON was
> evaluating to nothing in this case, and we want (0) since this is a
> function-like macro that will be followed by a semicolon.
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>

Acked-by: Borislav Petkov <bp@alien8.de>

-- 
Regards/Gruss,
Boris.
