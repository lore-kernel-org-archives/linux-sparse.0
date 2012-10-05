From: danielfsantos@att.net
Subject: [PATCH v2 0/10] Cleanup & new features for compiler*.h and bug.h
Date: Fri,  5 Oct 2012 14:35:49 -0500
Message-ID: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm3-vm0.bullet.mail.sp2.yahoo.com ([98.139.90.230]:37456 "HELO
	nm3-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750936Ab2JETgR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 5 Oct 2012 15:36:17 -0400
In-Reply-To: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>


This patch set is a dependency of the generic red-black tree patch set, which
I have now split up into three smaller sets.

The major aim of this patch set is to cleanup compiler-gcc*.h and improve the
manageability of of compiler features at various versions (when they are
broken, etc.), and to cleanup & add some needed features to bug.h.

compiler-gcc*.h
o Introduce GCC_VERSION - (e.g., gcc 4.7.1 becomes 40701)
o Reorder all features based upon the version introduced (readability)
o Change all version checks to use GCC_VERSION
o Remove redundant __linktime_error

bug.h
o Improve BUILD_BUG_ON(expr) - Will now generate a compile-time error and in
  gcc-4.4+, also emits an error message containing the expression that failed.
o Add BUILD_BUG_ON_MSG(expr, msg) - Like BUILD_BUG_ON, except that you can
  specify the error message that is emitted (again, gcc-4.4+).
o Add BUILD_BUG_ON_INTERNAL(expr, fn, msg) - contains a generic implementation
  of BUILG_BUG_ON{_MSG}.
o Finally, the implementations of BUILD_BUG{,_ON,_ON_MSG} is consolidated,
  eliminating duplicate code.

