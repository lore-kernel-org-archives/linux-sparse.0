From: changbin.du@intel.com
Subject: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to disable compiler auto-inline optimizations
Date: Tue,  5 Jun 2018 16:13:38 +0800
Message-ID: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
References: <1528186420-6615-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528186420-6615-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, akpm@linux-foundation.org, yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc: rostedt@goodmis.org, tglx@linutronix.de, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org, changbin.du@gmail.com, Changbin Du <changbin.du@intel.com>
List-Id: linux-sparse@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
this option will prevent the compiler from optimizing the kernel by
auto-inlining functions not marked with the inline keyword.

With this option, only functions explicitly marked with "inline" will
be inlined. This will allow the function tracer to trace more functions
because it only traces functions that the compiler has not inlined.

Signed-off-by: Changbin Du <changbin.du@intel.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
v2: Some grammar updates from Steven.
---
 Makefile          |  6 ++++++
 lib/Kconfig.debug | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Makefile b/Makefile
index d0d2652..6720c40 100644
--- a/Makefile
+++ b/Makefile
@@ -775,6 +775,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
 endif
 
+ifdef CONFIG_NO_AUTO_INLINE
+KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
+		   $(call cc-option, -fno-inline-small-functions) \
+		   $(call cc-option, -fno-inline-functions-called-once)
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 ifndef CC_FLAGS_FTRACE
 CC_FLAGS_FTRACE := -pg
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c40c7b7..da52243 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -198,6 +198,23 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
+config NO_AUTO_INLINE
+	bool "Disable compiler auto-inline optimizations"
+	help
+	  This will prevent the compiler from optimizing the kernel by
+	  auto-inlining functions not marked with the inline keyword.
+	  With this option, only functions explicitly marked with
+	  "inline" will be inlined. This will allow the function tracer
+	  to trace more functions because it only traces functions that
+	  the compiler has not inlined.
+
+	  Enabling this function can help debugging a kernel if using
+	  the function tracer. But it can also change how the kernel
+	  works, because inlining functions may change the timing,
+	  which could make it difficult while debugging race conditions.
+
+	  If unsure, select N.
+
 config ENABLE_WARN_DEPRECATED
 	bool "Enable __deprecated logic"
 	default y
-- 
2.7.4
