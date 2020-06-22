From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] teach sparse about __STDC_HOSTED__
Date: Tue, 23 Jun 2020 01:12:26 +0200
Message-ID: <20200622231226.89625-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgFVXOd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jun 2020 19:14:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD87C061573
        for <linux-sparse@vger.kernel.org>; Mon, 22 Jun 2020 16:14:32 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rk21so3317915ejb.2
        for <linux-sparse@vger.kernel.org>; Mon, 22 Jun 2020 16:14:32 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It seems that some system libraries expect __STDC_HOSTED__ to
be always defined.

So, teach sparse the options flags -f[no-]{hosted,freestanding}
and define __STDC_HOSTED__ accordingly.
---
 lib.c                                  |  4 ++++
 lib.h                                  |  1 +
 validation/preprocessor/freestanding.c | 11 +++++++++++
 validation/preprocessor/hosted.c       | 11 +++++++++++
 4 files changed, 27 insertions(+)
 create mode 100644 validation/preprocessor/freestanding.c
 create mode 100644 validation/preprocessor/hosted.c

diff --git a/lib.c b/lib.c
index 88bb31093deb..e56788260cb7 100644
--- a/lib.c
+++ b/lib.c
@@ -311,6 +311,7 @@ int dbg_ir = 0;
 int dbg_postorder = 0;
 
 unsigned long fdump_ir;
+int fhosted = 1;
 int fmem_report = 0;
 unsigned long long fmemcpy_max_count = 100000;
 unsigned long fpasses = ~0UL;
@@ -994,6 +995,8 @@ static int handle_fmax_warnings(const char *arg, const char *opt, const struct f
 static struct flag fflags[] = {
 	{ "diagnostic-prefix",	NULL,	handle_fdiagnostic_prefix },
 	{ "dump-ir",		NULL,	handle_fdump_ir },
+	{ "freestanding",	&fhosted, NULL, OPT_INVERSE },
+	{ "hosted",		&fhosted },
 	{ "linearize",		NULL,	handle_fpasses,	PASS_LINEARIZE },
 	{ "max-warnings=",	NULL,	handle_fmax_warnings },
 	{ "mem-report",		&fmem_report },
@@ -1300,6 +1303,7 @@ static void predefined_macros(void)
 	predefine("__GNUC_PATCHLEVEL__", 1, "%d", gcc_patchlevel);
 
 	predefine("__STDC__", 1, "1");
+	predefine("__STDC_HOSTED__", 0, fhosted ? "1" : "0");
 	switch (standard) {
 	default:
 		break;
diff --git a/lib.h b/lib.h
index e767840c1038..4f67958efdb9 100644
--- a/lib.h
+++ b/lib.h
@@ -202,6 +202,7 @@ extern int dbg_postorder;
 extern unsigned int fmax_warnings;
 extern int fmem_report;
 extern unsigned long fdump_ir;
+extern int fhosted;
 extern unsigned long long fmemcpy_max_count;
 extern unsigned long fpasses;
 extern int fpic;
diff --git a/validation/preprocessor/freestanding.c b/validation/preprocessor/freestanding.c
new file mode 100644
index 000000000000..7ee35354f711
--- /dev/null
+++ b/validation/preprocessor/freestanding.c
@@ -0,0 +1,11 @@
+__STDC_HOSTED__
+
+/*
+ * check-name: freestanding
+ * check-command: sparse -E -ffreestanding $file
+ *
+ * check-output-start
+
+0
+ * check-output-end
+ */
diff --git a/validation/preprocessor/hosted.c b/validation/preprocessor/hosted.c
new file mode 100644
index 000000000000..e6b3d3c1d6b7
--- /dev/null
+++ b/validation/preprocessor/hosted.c
@@ -0,0 +1,11 @@
+__STDC_HOSTED__
+
+/*
+ * check-name: hosted
+ * check-command: sparse -E -fhosted $file
+ *
+ * check-output-start
+
+1
+ * check-output-end
+ */
-- 
2.27.0
