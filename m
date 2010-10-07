From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH v2] parser: add Blackfin gcc info
Date: Wed,  6 Oct 2010 20:09:48 -0400
Message-ID: <1286410188-6074-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:56615 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758804Ab0JGAHp (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Oct 2010 20:07:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 43D9A1B4079
	for <linux-sparse@vger.kernel.org>; Thu,  7 Oct 2010 00:07:44 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

The Blackfin port uses some custom attributes to control memory placement,
and it has some custom builtins.  So add the ones that the kernel actually
utilizes to avoid massive build errors with sparse.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
v2
	- put Blackin builtins behind __bfin__

 lib.c   |    9 +++++++++
 parse.c |    6 ++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index ae6a20c..e33d3a5 100644
--- a/lib.c
+++ b/lib.c
@@ -717,6 +717,15 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 	add_pre_buffer("extern long __builtin_labs(long);\n");
 
+	/* Add Blackfin-specific stuff */
+	add_pre_buffer(
+		"#ifdef __bfin__\n"
+		"extern void __builtin_bfin_csync(void);\n"
+		"extern void __builtin_bfin_ssync(void);\n"
+		"extern int __builtin_bfin_norm_fr1x32(int);\n"
+		"#endif\n"
+	);
+
 	/* And some floating point stuff.. */
 	add_pre_buffer("extern int __builtin_isgreater(float, float);\n");
 	add_pre_buffer("extern int __builtin_isgreaterequal(float, float);\n");
diff --git a/parse.c b/parse.c
index 9074b1d..32d2d0a 100644
--- a/parse.c
+++ b/parse.c
@@ -515,6 +515,12 @@ const char *ignored_attributes[] = {
 	"__format_arg__",
 	"hot",
 	"__hot__",
+	"l1_text",
+	"__l1_text__",
+	"l1_data",
+	"__l1_data__",
+	"l2",
+	"__l2__",
 	"malloc",
 	"__malloc__",
 	"may_alias",
-- 
1.7.3.1

