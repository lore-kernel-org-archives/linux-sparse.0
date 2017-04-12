From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] use -fmem-report to report allocation stats
Date: Wed, 12 Apr 2017 10:37:03 +0200
Message-ID: <20170412083703.11552-6-luc.vanoostenryck@gmail.com>
References: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35436 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753409AbdDLIhx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 04:37:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id l44so3071985wrc.2
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 01:37:52 -0700 (PDT)
In-Reply-To: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h            | 1 +
 sparse-llvm.c    | 1 +
 sparse.1         | 4 ++++
 sparse.c         | 2 ++
 stats.c          | 6 ++++++
 test-linearize.c | 2 ++
 test-unssa.c     | 1 +
 7 files changed, 17 insertions(+)

diff --git a/lib.h b/lib.h
index 14cb68af0..a0066dc57 100644
--- a/lib.h
+++ b/lib.h
@@ -147,6 +147,7 @@ extern struct symbol_list *sparse_initialize(int argc, char **argv, struct strin
 extern struct symbol_list *__sparse(char *filename);
 extern struct symbol_list *sparse_keep_tokens(char *filename);
 extern struct symbol_list *sparse(char *filename);
+extern void report_stats(void);
 
 static inline int symbol_list_size(struct symbol_list *list)
 {
diff --git a/sparse-llvm.c b/sparse-llvm.c
index ecc4f032f..6319c0ae9 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1166,5 +1166,6 @@ int main(int argc, char **argv)
 
 	LLVMDisposeModule(module);
 
+	report_stats();
 	return 0;
 }
diff --git a/sparse.1 b/sparse.1
index 525d3ded5..d8e53ce38 100644
--- a/sparse.1
+++ b/sparse.1
@@ -351,6 +351,10 @@ Dump the IR code of a function directly after its linearization,
 before any simplifications is made. If the argument \fB=only\fR is
 also given no further processing is done on the function.
 .
+.TP
+.B \-fmem-report
+Report some statistics about memory allocation used by the tool.
+.
 .SH OTHER OPTIONS
 .TP
 .B \-ftabstop=WIDTH
diff --git a/sparse.c b/sparse.c
index 6b3324cfc..02ab97743 100644
--- a/sparse.c
+++ b/sparse.c
@@ -302,5 +302,7 @@ int main(int argc, char **argv)
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		check_symbols(sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
+
+	report_stats();
 	return 0;
 }
diff --git a/stats.c b/stats.c
index 5f2685733..cda18fcae 100644
--- a/stats.c
+++ b/stats.c
@@ -54,3 +54,9 @@ void show_allocation_stats(void)
 
 	show_stats(NULL, &tot);
 }
+
+void report_stats(void)
+{
+	if (fmem_report)
+		show_allocation_stats();
+}
diff --git a/test-linearize.c b/test-linearize.c
index dd2eaecab..fe0673bef 100644
--- a/test-linearize.c
+++ b/test-linearize.c
@@ -61,5 +61,7 @@ int main(int argc, char **argv)
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		clean_up_symbols(sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
+
+	report_stats();
 	return 0;
 }
diff --git a/test-unssa.c b/test-unssa.c
index f7a5c3a18..240d99601 100644
--- a/test-unssa.c
+++ b/test-unssa.c
@@ -82,5 +82,6 @@ int main(int argc, char **argv)
 		compile(sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
 
+	report_stats();
 	return 0;
 }
-- 
2.12.0

