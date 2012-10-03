From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 6/10] bug.h: Replace __linktime_error with __compiletime_error
Date: Wed, 03 Oct 2012 06:49:10 -0500
Message-ID: <506C2636.6020304@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-7-git-send-email-daniel.santos@pobox.com> <alpine.DEB.2.00.1210022344180.12717@chino.kir.corp.google.com>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm23.bullet.mail.ac4.yahoo.com ([98.139.52.220]:33204 "HELO
	nm23.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751942Ab2JCLkq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Oct 2012 07:40:46 -0400
In-Reply-To: <alpine.DEB.2.00.1210022344180.12717@chino.kir.corp.google.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On 10/03/2012 01:44 AM, David Rientjes wrote:
> On Fri, 28 Sep 2012, Daniel Santos wrote:
>
>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> After this is folded into the previous patch in the series, 
> "compiler{,-gcc4}.h: Remove duplicate macros", then:
>
> 	Acked-by: David Rientjes <rientjes@google.com>
Thanks.  I've actually just reversed the patch order per Josh's
suggestion and added patch comments to it.  I can squash them if you
guys prefer.

Unfortunately, I'm a bit confused as to how I should re-submit these,
still being new to this project.  Patch 1 is already in -mm. Patches 2-3
have not changed. I've made a correction to patch #4 and reversed the
order of 5 & 6. And what was 8-10 is now 8-15, as I've completely
re-done BUILD_BUG_ON.  I was planning on just submitting the whole set
again, is this the correct protocol?  If so, should I reply to the
original [PATCH 0/10] thread or create a new one?

Thanks!
Daniel
