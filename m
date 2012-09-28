From: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH v6 3/25] compiler-gcc.h: Add gcc-recommended GCC_VERSION
 macro
Date: Thu, 27 Sep 2012 20:54:19 -0500
Message-ID: <1348797281-25021-4-git-send-email-daniel.santos@pobox.com>
References: <1348797281-25021-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348797281-25021-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, David Woodhouse <David.Woodhouse@intel.com>, Don Zickus <dzickus@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Santos <daniel.santos@pobox.com>
List-Id: linux-sparse@vger.kernel.org

Throughout compiler*.h, many version checks are made.  These can be
simplified by using the macro that gcc's documentation recommends.
However, my primary reason for adding this is that I need bug-check
macros that are enabled at certain gcc versions and it's cleaner to use
this macro than the tradition method:

if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ => 2)

If you add patch level, it gets this ugly:

if __GNUC__ > 4 || (__GNUC__ == 4 && (__GNUC_MINOR__ > 2 || \
   __GNUC_MINOR__ == 2 __GNUC_PATCHLEVEL__ >= 1))

As opposed to:

if GCC_VERSION >= 40201

While having separate headers for gcc 3 & 4 eliminates some of this
verbosity, they can still be cleaned up by this.

See also:
http://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/compiler-gcc.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 6a6d7ae..24545cd 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -5,6 +5,9 @@
 /*
  * Common definitions for all gcc versions go here.
  */
+#define GCC_VERSION (__GNUC__ * 10000 \
+		   + __GNUC_MINOR__ * 100 \
+		   + __GNUC_PATCHLEVEL__)
 
 
 /* Optimization barrier */
-- 
1.7.3.4
