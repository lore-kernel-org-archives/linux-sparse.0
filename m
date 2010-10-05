From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] parser: add Blackfin gcc info
Date: Tue,  5 Oct 2010 04:34:30 -0400
Message-ID: <1286267670-20974-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:38643 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290Ab0JEIdE (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Oct 2010 04:33:04 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: michael.hennerich@analog.com

The Blackfin port uses some custom attributes to control memory placement,
and it has some custom builtins.  So add the ones that the kernel actually
utilizes to avoid massive build errors with sparse.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 lib.c   |    3 +++
 parse.c |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index ae6a20c..24176d8 100644
--- a/lib.c
+++ b/lib.c
@@ -716,6 +716,9 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_inslh(long, long);\n");
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 	add_pre_buffer("extern long __builtin_labs(long);\n");
+	add_pre_buffer("extern void __builtin_bfin_csync(void);\n");
+	add_pre_buffer("extern void __builtin_bfin_ssync(void);\n");
+	add_pre_buffer("extern int __builtin_bfin_norm_fr1x32(int);\n");
 
 	/* And some floating point stuff.. */
 	add_pre_buffer("extern int __builtin_isgreater(float, float);\n");
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

