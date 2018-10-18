From: Du Changbin <changbin.du@gmail.com>
Subject: [PATCH 2/4] kernel hacking: new config NO_AUTO_INLINE to disable compiler auto-inline optimizations
Date: Thu, 18 Oct 2018 16:25:46 +0000
Message-ID: <20181018162548.6399-3-changbin.du@gmail.com>
References: <20181018162548.6399-1-changbin.du@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181018162548.6399-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org, Changbin Du <changbin.du@intel.com>
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
 Makefile          |  6 ++++++
 lib/Kconfig.debug | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Makefile b/Makefile
index e8b599b4dcde..757d6507cb5c 100644
--- a/Makefile
+++ b/Makefile
@@ -749,6 +749,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
 endif
 
+ifdef CONFIG_NO_AUTO_INLINE
+KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
+		   $(call cc-option, -fno-inline-small-functions) \
+		   $(call cc-option, -fno-inline-functions-called-once)
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
   # gcc 5 supports generating the mcount tables directly
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4966c4fbe7f7..0f9b4fa78b1c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -211,6 +211,31 @@ config GDB_SCRIPTS
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
+config ENABLE_WARN_DEPRECATED
+	bool "Enable __deprecated logic"
+	default y
+	help
+	  Enable the __deprecated logic in the kernel build.
+	  Disable this to suppress the "warning: 'foo' is deprecated
+	  (declared at kernel/power/somefile.c:1234)" messages.
+
 config ENABLE_MUST_CHECK
 	bool "Enable __must_check logic"
 	default y
-- 
2.17.1
