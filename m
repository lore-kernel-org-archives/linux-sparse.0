From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 35/83] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Date: Tue, 12 Feb 2019 21:36:13 -0500
Message-ID: <20190213023701.20286-35-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eli Friedman <efriedma@codeaurora.org>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

[ Upstream commit 3e2ffd655cc6a694608d997738989ff5572a8266 ]

Since commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
mutually exclusive") clang no longer reuses the OPTIMIZER_HIDE_VAR macro
from compiler-gcc - instead it gets the version in
include/linux/compiler.h.  Unfortunately that version doesn't actually
prevent compiler from optimizing out the variable.

Fix up by moving the macro out from compiler-gcc.h to compiler.h.
Compilers without incline asm support will keep working
since it's protected by an ifdef.

Also fix up comments to match reality since we are no longer overriding
any macros.

Build-tested with gcc and clang.

Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Joe Perches <joe@perches.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler-clang.h | 5 ++---
 include/linux/compiler-gcc.h   | 4 ----
 include/linux/compiler-intel.h | 4 +---
 include/linux/compiler.h       | 4 +++-
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..d756f2318efe 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -3,9 +3,8 @@
 #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
 #endif
 
-/* Some compiler specific definitions are overwritten here
- * for Clang compiler
- */
+/* Compiler specific definitions for Clang compiler */
+
 #define uninitialized_var(x) x = *(&(x))
 
 /* same as gcc, this was present in clang-2.6 so we can assume it works
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 0242f6eec4ea..a8ff0ca0c321 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -58,10 +58,6 @@
 	(typeof(ptr)) (__ptr + (off));					\
 })
 
-/* Make the optimizer believe the variable can be manipulated arbitrarily. */
-#define OPTIMIZER_HIDE_VAR(var)						\
-	__asm__ ("" : "=r" (var) : "0" (var))
-
 /*
  * A trick to suppress uninitialized variable warning without generating any
  * code
diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index 4c7f9befa9f6..f1fc60f10317 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -5,9 +5,7 @@
 
 #ifdef __ECC
 
-/* Some compiler specific definitions are overwritten here
- * for Intel ECC compiler
- */
+/* Compiler specific definitions for Intel ECC compiler */
 
 #include <asm/intrinsics.h>
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..269d376f5a11 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -158,7 +158,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #endif
 
 #ifndef OPTIMIZER_HIDE_VAR
-#define OPTIMIZER_HIDE_VAR(var) barrier()
+/* Make the optimizer believe the variable can be manipulated arbitrarily. */
+#define OPTIMIZER_HIDE_VAR(var)						\
+	__asm__ ("" : "=r" (var) : "0" (var))
 #endif
 
 /* Not-quite-unique ID. */
-- 
2.19.1
