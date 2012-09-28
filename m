From: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH v6 1/25] compiler-gcc4.h: Correct verion check for
 __compiletime_error
Date: Thu, 27 Sep 2012 20:54:17 -0500
Message-ID: <1348797281-25021-2-git-send-email-daniel.santos@pobox.com>
References: <1348797281-25021-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1348797281-25021-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, David Woodhouse <David.Woodhouse@intel.com>, Don Zickus <dzickus@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Santos <daniel.santos@pobox.com>
List-Id: linux-sparse@vger.kernel.org

__attribute__((error(msg))) was introduced in gcc 4.3 (not 4.4) and as I
was unable to find any gcc bugs pertaining to it, I'm presuming that it
has functioned as advertised since 4.3.0.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/compiler-gcc4.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index 997fd8a..8721704 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -59,7 +59,7 @@
 #if __GNUC_MINOR__ > 0
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 #endif
-#if __GNUC_MINOR__ >= 4 && !defined(__CHECKER__)
+#if __GNUC_MINOR__ >= 3 && !defined(__CHECKER__)
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
 #endif
-- 
1.7.3.4

