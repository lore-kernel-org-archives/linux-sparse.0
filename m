From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/10] compiler-gcc4.h: correct verion check for
 __compiletime_error
Date: Tue, 2 Oct 2012 23:25:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210022324430.12717@chino.kir.corp.google.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-2-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42454 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2JCGZP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Oct 2012 02:25:15 -0400
Received: by pbbrr4 with SMTP id rr4so9527458pbb.19
        for <linux-sparse@vger.kernel.org>; Tue, 02 Oct 2012 23:25:14 -0700 (PDT)
In-Reply-To: <1348874411-28288-2-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Michal Marek <mmarek@suse.cz>

On Fri, 28 Sep 2012, Daniel Santos wrote:

> NOTE: this is has already been comitted to -mm
> 
> __attribute__((error(msg))) was introduced in gcc 4.3 (not 4.4) and as I
> was unable to find any gcc bugs pertaining to it, I'm presuming that it
> has functioned as advertised since 4.3.0.
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> Cc: Michal Marek <mmarek@suse.cz>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Tested-by: David Rientjes <rientjes@google.com>

Works with 4.3.6.
