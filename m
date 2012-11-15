From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 9/9] bug.h, compiler.h: Introduce compiletime_assert &
 BUILD_BUG_ON_MSG
Date: Thu, 15 Nov 2012 16:08:23 +0100
Message-ID: <20121115150823.GG4956@x1.osrc.amd.com>
References: <1352844568-18826-1-git-send-email-daniel.santos@pobox.com>
 <1352844821-18952-9-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56521 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768160Ab2KOPIF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 15 Nov 2012 10:08:05 -0500
Content-Disposition: inline
In-Reply-To: <1352844821-18952-9-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On Tue, Nov 13, 2012 at 04:13:41PM -0600, danielfsantos@att.net wrote:
> Introduce compiletime_assert to compiler.h, which moves the details of
> how to break a build and emit an error message for a specific compiler
> to the headers where these details should be. Following the tradition of
> the POSIX assert macro, compiletime_assert creates a build-time error
> when the supplied condition is *false*.
> 
> Next, we add BUILD_BUG_ON_MSG to bug.h which simply wraps
> compiletime_assert, inverting the logic, so that it fails when the
> condition is *true*, consistient with the language "build bug on." This
> macro allows you to specify the error message you want emitted when the
> supplied condition is true.
> 
> Finally, we remove all other code from bug.h that mucks with these
> details (BUILD_BUG & BUILD_BUG_ON), and have them all call
> BUILD_BUG_ON_MSG.  This not only reduces source code bloat, but also
> prevents the possibility of code being changed for one macro and not for
> the other (which was previously the case for BUILD_BUG and
> BUILD_BUG_ON).
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>

Looks nice and clean.

Acked-by: Borislav Petkov <bp@alien8.de>

-- 
Regards/Gruss,
Boris.
