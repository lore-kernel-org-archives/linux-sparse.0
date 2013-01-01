From: danielfsantos@att.net
Subject: [PATCH v8 0/9] Cleanup & new features for compiler*.h and bug.h
Date: Tue,  1 Jan 2013 16:54:02 -0600
Message-ID: <1357080851-30938-1-git-send-email-daniel.santos@pobox.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm5-vm0.access.bullet.mail.mud.yahoo.com ([66.94.237.155]:26291
	"EHLO nm5-vm0.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752272Ab3AAWyR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Jan 2013 17:54:17 -0500
In-Reply-To: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Santos <daniel.santos@pobox.com>


Well, it looks like my new version of git properly handles the
--in-reply-to switch now, so this patch set shouldn't be oddly threaded
like the last version.

 include/linux/bug.h           |   47 ++++++++++++++++++++++------------------
 include/linux/compiler-gcc.h  |    3 ++
 include/linux/compiler-gcc3.h |    8 +++---
 include/linux/compiler-gcc4.h |   36 +++++++++++++++---------------
 include/linux/compiler.h      |   32 +++++++++++++++++++++++++--
 5 files changed, 80 insertions(+), 46 deletions(-)

Changes in v8:
o Correct bisection issue

Changes in v7:
o Rebase onto next-20121224 & merge changes

Changes in v6:
o Remove extraneous double negation
o Fixed faulty macro expansion in last patch

Changes in v5:
o Move BUILD_BUG* guts to a new compiletime_assert() macro in compiler.h.
o Fix a double-evaluation problem.
o Fix another bad macro definition when __CHECKER__ defined.

Changes in v4:
o Squash a minor commit (per Borislav Petkov)
o Change some comment text (per Borislav Petkov)
o Add some acks

This patch set is a dependency of the generic red-black tree patch set, which
I have now split up into three smaller sets and is based off of linux-next.

The major aim of this patch set is to cleanup compiler-gcc*.h and improve
the manageability of of compiler features at various versions (when they
are broken, etc.), add some needed features to bug.h and clean that up as
well.

compiler-gcc*.h
o Introduce GCC_VERSION - (e.g., gcc 4.7.1 becomes 40701).
o Reorder all features based upon the version introduced (readability).
o Change all version checks to use GCC_VERSION.
o Remove redundant __linktime_error macro.
o Introduce compiletime_assert() macro.

bug.h
o Improve BUILD_BUG_ON(expr) - now generates compile-time error post-gcc-4.4
o Remove duplicate error messages in some cases.
o Fix double-evaluation problem in BUILD_BUG_ON.
o Fix bad macro definitions when using __CHECKER__.
o Introduce BUILD_BUG_ON_MSG and clean up the implementations of the
  BUILD_BUG* macros.

