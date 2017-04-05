From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] add sparse_basename()
Date: Wed,  5 Apr 2017 03:14:54 +0200
Message-ID: <20170405011455.60222-3-luc.vanoostenryck@gmail.com>
References: <20170405011455.60222-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34748 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754717AbdDEBRF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 21:17:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id x75so189832wma.1
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 18:17:05 -0700 (PDT)
In-Reply-To: <20170405011455.60222-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add sparse_basename() as a simplified version of basename()
working on Unix and non-unix environments.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile          |  1 +
 compat.h          |  1 +
 compat/basename.c | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)
 create mode 100644 compat/basename.c

diff --git a/Makefile b/Makefile
index e8edd95f6..b4826728c 100644
--- a/Makefile
+++ b/Makefile
@@ -107,6 +107,7 @@ LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
 	  builtin.o \
+	  compat/basename.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
 
 LIB_FILE= libsparse.a
diff --git a/compat.h b/compat.h
index 9814ae3e8..5b69548af 100644
--- a/compat.h
+++ b/compat.h
@@ -24,5 +24,6 @@ struct stat;
 void *blob_alloc(unsigned long size);
 void blob_free(void *addr, unsigned long size);
 long double string_to_ld(const char *nptr, char **endptr);
+const char *sparse_basename(const char *path);
 
 #endif
diff --git a/compat/basename.c b/compat/basename.c
new file mode 100644
index 000000000..c9770229c
--- /dev/null
+++ b/compat/basename.c
@@ -0,0 +1,16 @@
+#include "compat.h"
+#include <string.h>
+
+const char *sparse_basename(const char *path)
+{
+	const char *last;
+
+	last = strrchr(path, '/');
+	path = last ? last + 1 : path;
+#if defined(_WIN32) || defined(_WIN64)
+	last = strrchr(path, '\\');
+	path = last ? last + 1 : path;
+#endif
+
+	return path;
+}
-- 
2.12.0

