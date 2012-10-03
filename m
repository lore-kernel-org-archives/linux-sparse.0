From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 6/10] bug.h: Replace __linktime_error with
 __compiletime_error
Date: Tue, 2 Oct 2012 23:44:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210022344180.12717@chino.kir.corp.google.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-7-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33451 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab2JCGom (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Oct 2012 02:44:42 -0400
Received: by pbbrr4 with SMTP id rr4so9541130pbb.19
        for <linux-sparse@vger.kernel.org>; Tue, 02 Oct 2012 23:44:42 -0700 (PDT)
In-Reply-To: <1348874411-28288-7-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 28 Sep 2012, Daniel Santos wrote:

> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>

After this is folded into the previous patch in the series, 
"compiler{,-gcc4}.h: Remove duplicate macros", then:

	Acked-by: David Rientjes <rientjes@google.com>
