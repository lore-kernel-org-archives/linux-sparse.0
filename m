From: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH v5 5/25] compiler{,-gcc4}.h: Remove duplicate macros
Date: Tue, 25 Sep 2012 18:30:30 -0500
Message-ID: <1348615830-10127-1-git-send-email-daniel.santos@pobox.com>
References: <1348615467-9850-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm13-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.244]:43031 "HELO
	nm13-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752612Ab2IYXai (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Sep 2012 19:30:38 -0400
In-Reply-To: <1348615467-9850-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, linux-sparse@vger.kernel.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Richard Weinberger <richard@nod.at>, LKML <linux-kernel@vger.kernel.org>, Michel Lespinasse <walken@google.com>, Andrea Arcangeli <aarcange@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>

__linktime_error() does the same thing as __compiletime_error() and is
only used in bug.h.  Since the macro defines a function attribute that
will cause a failure at compile-time (not link-time), it makes more
sense to keep __compiletime_error(), which is also neatly mated with
__compiletime_warning().

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/compiler-gcc4.h |    2 --
 include/linux/compiler.h      |    3 ---
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index 7ad60cd..5755e23 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -33,8 +33,6 @@
    the kernel context */
 #define __cold			__attribute__((__cold__))
 
-#define __linktime_error(message) __attribute__((__error__(message)))
