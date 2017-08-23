From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 32/48] mem2reg: add flags to enable/disable some parts
Date: Wed, 23 Aug 2017 22:15:38 +0200
Message-ID: <20170823201554.90551-33-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36074 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id f127so641890wmf.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:04 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 lib.c     |  8 ++++++++
 lib.h     |  6 +++++-
 mem2reg.c |  3 +++
 memops.c  | 17 ++++++++++++++++-
 sparse.1  | 28 ++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index d3aaf10d2..0705775e5 100644
--- a/lib.c
+++ b/lib.c
@@ -260,6 +260,10 @@ int dbg_dead = 0;
 int fmem_report = 0;
 int fdump_ir;
 unsigned long long fmemcpy_max_count = 100000;
+int fpromote_symbols_usage = 1;
+int fsimplify_loads = 1;
+int fsimplify_loads_full = 0;		// currently broken
+int fsimplify_stores = 1;
 
 int preprocess_only;
 
@@ -780,6 +784,10 @@ err:
 
 static struct flag fflags[] = {
 	{ "mem-report",			&fmem_report },
+	{ "promote-symbols-usage",	&fpromote_symbols_usage },
+	{ "simplify-loads",		&fsimplify_loads },
+	{ "simplify-loads-full",	&fsimplify_loads_full },
+	{ "simplify-stores",		&fsimplify_stores },
 	{ },
 };
 
diff --git a/lib.h b/lib.h
index d0b699535..a2fd04e67 100644
--- a/lib.h
+++ b/lib.h
@@ -154,9 +154,13 @@ extern int dump_macro_defs;
 extern int dbg_entry;
 extern int dbg_dead;
 
-extern int fmem_report;
 extern int fdump_ir;
+extern int fmem_report;
 extern unsigned long long fmemcpy_max_count;
+extern int fpromote_symbols_usage;
+extern int fsimplify_loads;
+extern int fsimplify_loads_full;
+extern int fsimplify_stores;
 
 extern int arch_m64;
 extern int arch_msize_long;
diff --git a/mem2reg.c b/mem2reg.c
index 26837935c..c2f77ffbe 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -359,6 +359,9 @@ void promote_symbols_usage(struct entrypoint *ep)
 {
 	pseudo_t pseudo;
 
+	if (!fpromote_symbols_usage)
+		return;
+
 	FOR_EACH_PTR(ep->accesses, pseudo) {
 		promote_symbol(ep, pseudo->sym);
 	} END_FOR_EACH_PTR(pseudo);
diff --git a/memops.c b/memops.c
index 99430e455..501973788 100644
--- a/memops.c
+++ b/memops.c
@@ -120,15 +120,30 @@ next_store:
 	} END_FOR_EACH_PTR_REVERSE(insn);
 }
 
-void simplify_memops(struct entrypoint *ep)
+static void simplify_all_loads(struct entrypoint *ep)
 {
 	struct basic_block *bb;
 
+	if (!fsimplify_loads)
+		return;
 	FOR_EACH_PTR_REVERSE(ep->bbs, bb) {
 		simplify_loads(bb);
 	} END_FOR_EACH_PTR_REVERSE(bb);
+}
+
+static void simplify_all_stores(struct entrypoint *ep)
+{
+	struct basic_block *bb;
 
+	if (!fsimplify_stores)
+		return;
 	FOR_EACH_PTR_REVERSE(ep->bbs, bb) {
 		kill_dominated_stores(bb);
 	} END_FOR_EACH_PTR_REVERSE(bb);
 }
+
+void simplify_memops(struct entrypoint *ep)
+{
+	simplify_all_loads(ep);
+	simplify_all_stores(ep);
+}
diff --git a/sparse.1 b/sparse.1
index c7ad4483b..87958ef35 100644
--- a/sparse.1
+++ b/sparse.1
@@ -378,6 +378,34 @@ Set the distance between tab stops.  This helps sparse report correct
 column numbers in warnings or errors.  If the value is less than 1 or
 greater than 100, the option is ignored.  The default is 8.
 .
+.SH DEVELOPER OPTIONS
+.TP
+.B \-fno-promote-symbol-usage
+Enable or disable the promotion of memory accesses via symbol to registers.
+
+This option is enabled by default.
+.
+.TP
+.B \-fno-simplify-loads
+Enable or disable the promotion of memory loads to registers during
+the optimization passes.
+
+This option is enabled by default.
+.
+.TP
+.B \-fsimplify-loads-full
+Enable or disable the promotion of complex memory loads to registers during
+the optimization passes.
+
+This option is disabled by default.
+.
+.TP
+.B \-fno-simplify-stores
+Enable or disable the elimination of some stores to memory during
+the optimization passes.
+
+This option is enabled by default.
+.
 .SH SEE ALSO
 .BR cgcc (1)
 .
-- 
2.14.0

