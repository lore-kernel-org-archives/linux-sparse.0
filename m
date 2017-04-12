From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] add show_allocation_stats()
Date: Wed, 12 Apr 2017 10:37:00 +0200
Message-ID: <20170412083703.11552-3-luc.vanoostenryck@gmail.com>
References: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34510 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbdDLIhu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 04:37:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id x75so4882977wma.1
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 01:37:49 -0700 (PDT)
In-Reply-To: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There exist some function to display the stats from each allocator
(show_<allocator>_alloc()) but these functions need to be
called one by one and deosn't allow to make some totals.

Chnage this by adding show_allocation_stats() which display
(in a more consise way) the stats from every allocator, together
with the totals.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile   |  1 +
 allocate.h |  1 +
 stats.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 stats.c

diff --git a/Makefile b/Makefile
index 3ac100744..7ba2dbd82 100644
--- a/Makefile
+++ b/Makefile
@@ -107,6 +107,7 @@ LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
 	  builtin.o \
 	  opcode.o \
+	  stats.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
 
 LIB_FILE= libsparse.a
diff --git a/allocate.h b/allocate.h
index 6e6c3a614..64bb6dd64 100644
--- a/allocate.h
+++ b/allocate.h
@@ -29,6 +29,7 @@ extern void *allocate(struct allocator_struct *desc, unsigned int size);
 extern void free_one_entry(struct allocator_struct *desc, void *entry);
 extern void show_allocations(struct allocator_struct *);
 extern void get_allocator_stats(struct allocator_struct *, struct allocator_stats *);
+extern void show_allocation_stats(void);
 
 #define __DECLARE_ALLOCATOR(type, x)		\
 	extern type *__alloc_##x(int);		\
diff --git a/stats.c b/stats.c
new file mode 100644
index 000000000..5f2685733
--- /dev/null
+++ b/stats.c
@@ -0,0 +1,56 @@
+#include <stdio.h>
+#include "allocate.h"
+#include "linearize.h"
+#include "storage.h"
+
+__DECLARE_ALLOCATOR(struct ptr_list, ptrlist);
+
+
+typedef void (*get_t)(struct allocator_stats*);
+
+static void show_stats(get_t get, struct allocator_stats * tot)
+{
+	struct allocator_stats x;
+
+	if (get)
+		get(&x);
+	else
+		x = *tot;
+	fprintf(stderr, "%16s: %8d, %10ld, %10ld, %6.2f%%, %8.2f\n",
+		x.name, x.allocations, x.useful_bytes, x.total_bytes,
+		100 * (double) x.useful_bytes / (x.total_bytes ? : 1),
+		(double) x.useful_bytes / (x.allocations ? : 1));
+
+	tot->allocations += x.allocations;
+	tot->useful_bytes += x.useful_bytes;
+	tot->total_bytes += x.total_bytes;
+}
+
+void show_allocation_stats(void)
+{
+	struct allocator_stats tot = { .name = "total", };
+
+	fprintf(stderr, "%16s: %8s, %10s, %10s, %7s, %8s\n", "allocator", "allocs",
+		"bytes", "total", "%usage", "average");
+	show_stats(get_token_stats, &tot);
+	show_stats(get_ident_stats, &tot);
+	show_stats(get_symbol_stats, &tot);
+	show_stats(get_expression_stats, &tot);
+	show_stats(get_statement_stats, &tot);
+	show_stats(get_scope_stats, &tot);
+	show_stats(get_basic_block_stats, &tot);
+	show_stats(get_instruction_stats, &tot);
+	show_stats(get_pseudo_stats, &tot);
+	show_stats(get_pseudo_user_stats, &tot);
+	show_stats(get_ptrlist_stats, &tot);
+	show_stats(get_multijmp_stats, &tot);
+	show_stats(get_asm_rules_stats, &tot);
+	show_stats(get_asm_constraint_stats, &tot);
+	show_stats(get_context_stats, &tot);
+	show_stats(get_string_stats, &tot);
+	show_stats(get_bytes_stats, &tot);
+	//show_stats(get_storage_stats, &tot);
+	//show_stats(get_storage_hash_stats, &tot);
+
+	show_stats(NULL, &tot);
+}
-- 
2.12.0

