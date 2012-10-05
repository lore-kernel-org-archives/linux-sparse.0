From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/10] Cleanup & new features for compiler*.h and bug.h
Date: Fri, 05 Oct 2012 16:27:05 -0400
Message-ID: <1349468825.6755.67.camel@gandalf.local.home>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
	 <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7859 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab2JEU1J (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 5 Oct 2012 16:27:09 -0400
In-Reply-To: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: danielfsantos@att.net
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Fri, 2012-10-05 at 14:35 -0500, danielfsantos@att.net wrote:
> This patch set is a dependency of the generic red-black tree patch set, which
> I have now split up into three smaller sets.
> 
> The major aim of this patch set is to cleanup compiler-gcc*.h and improve the
> manageability of of compiler features at various versions (when they are
> broken, etc.), and to cleanup & add some needed features to bug.h.
> 

A quick review of the patches look fine to me.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


