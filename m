From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 7/9] bug.h: Fix BUILD_BUG_ON macro in __CHECKER__
Date: Tue, 30 Oct 2012 17:44:21 +0100
Message-ID: <20121030164421.GE28499@liondog.tnic>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com>
 <1351457835-7553-7-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:48832 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757514Ab2J3QoY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 30 Oct 2012 12:44:24 -0400
Content-Disposition: inline
In-Reply-To: <1351457835-7553-7-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>

On Sun, Oct 28, 2012 at 03:57:13PM -0500, danielfsantos@att.net wrote:
> When __CHECKER__ is defined, we disable all of the BUILD_BUG.* macros.
> However, BUILD_BUG_ON was evaluating to nothing in this case, and we
> want (0) since this is a function-like macro that will be followed by a
> semicolon.
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>

Acked-by: Borislav Petkov <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.
