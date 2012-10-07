From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v2 0/10] Cleanup & new features for compiler*.h and bug.h
Date: Sun, 07 Oct 2012 13:36:02 -0500
Message-ID: <5071CB92.2040703@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm24-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.226]:45645 "HELO
	nm24-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751211Ab2JGSgE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Oct 2012 14:36:04 -0400
In-Reply-To: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

I just realized that in my patch set header I didn't specify that this
version of the patches is based against -mm.  However, I did not test
against -mm, I rebased them to mainline, merged some conflicts and made
some changes and tested there and I'm running that kernel now (that is,
with all of my patches, including fair scheduler using the generic
red-black tree).

This patch set builds fine against -mm & -next, but I just can't get
either of those to run correctly on my machine, even without my
patches.  (Sorry, that I don't have an actual test machine at the moment.)

On 10/05/2012 02:35 PM, danielfsantos@att.net wrote:
> This patch set is a dependency of the generic red-black tree patch set, which
> I have now split up into three smaller sets.
>
> The major aim of this patch set is to cleanup compiler-gcc*.h and improve the
> manageability of of compiler features at various versions (when they are
> broken, etc.), and to cleanup & add some needed features to bug.h.
>
> compiler-gcc*.h
> o Introduce GCC_VERSION - (e.g., gcc 4.7.1 becomes 40701)
> o Reorder all features based upon the version introduced (readability)
> o Change all version checks to use GCC_VERSION
> o Remove redundant __linktime_error
>
> bug.h
> o Improve BUILD_BUG_ON(expr) - Will now generate a compile-time error and in
>   gcc-4.4+, also emits an error message containing the expression that failed.
> o Add BUILD_BUG_ON_MSG(expr, msg) - Like BUILD_BUG_ON, except that you can
>   specify the error message that is emitted (again, gcc-4.4+).
> o Add BUILD_BUG_ON_INTERNAL(expr, fn, msg) - contains a generic implementation
>   of BUILG_BUG_ON{_MSG}.
> o Finally, the implementations of BUILD_BUG{,_ON,_ON_MSG} is consolidated,
>   eliminating duplicate code.

