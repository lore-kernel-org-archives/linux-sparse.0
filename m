From: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH 0/10] Cleanup & new features for compiler*.h and bug.h
Date: Fri, 28 Sep 2012 18:20:01 -0500
Message-ID: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm10.bullet.mail.sp2.yahoo.com ([98.139.91.80]:25583 "HELO
	nm10.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758514Ab2I1XU2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 19:20:28 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>


This patch set is a dependency of the generic red-black tree patch set, which
I have now split up into three smaller sets.

The major aim of this patch set is to cleanup compiler-gcc*.h and improve the
manageability of of compiler features at various versions (when they are
broken, etc.), and to add some needed features to bug.h (again, that are
compiler-version-dependent).

compiler-gcc*.h
o Introduce GCC_VERSION - (e.g., gcc 4.7.1 becomes 40701)
o Reorder all features based upon the version introduced (readability)
o Change all version checks to use GCC_VERSION
o Remove redundant __linktime_error
o Introduce __flatten function attribute

bug.h
o Improve BUILD_BUG_ON(expr) - now generates compile-time error post-gcc-4.4
o Introduce BUILD_BUG_ON_NON_CONST(expr) macro, which simply wraps
  __builtin_constant_p and BUILD_BUG_ON
o Documented (in BUILD_BUG_ON_NON_CONST doc-comments) the extensive
  discrepancies in the behavior of __builtin_constant_p throughout versions of
  gcc.
o Introduce BUILD_BUG_ON_NON_CONST42 macro for compile-time-constant checks
  that are doomed to fail in older versions of gcc.

