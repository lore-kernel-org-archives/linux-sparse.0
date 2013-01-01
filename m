From: danielfsantos@att.net
Subject: [PATCH v7 0/9] Cleanup & new features for compiler*.h and bug.h
Date: Tue,  1 Jan 2013 15:08:02 -0600
Message-ID: <1357074491-21669-1-git-send-email-daniel.santos@pobox.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Santos <daniel.santos@pobox.com>
List-Id: linux-sparse@vger.kernel.org


 include/linux/bug.h           |   47 ++++++++++++++++++++++------------------
 include/linux/compiler-gcc.h  |    3 ++
 include/linux/compiler-gcc3.h |    8 +++---
 include/linux/compiler-gcc4.h |   36 +++++++++++++++---------------
 include/linux/compiler.h      |   32 +++++++++++++++++++++++++--
 5 files changed, 80 insertions(+), 46 deletions(-)

This version just rebases against today's -next and with a slight modification
to CONFIG_ARCH_USE_BUILTIN_BSWAP code in in compiler-gcc4.h.
