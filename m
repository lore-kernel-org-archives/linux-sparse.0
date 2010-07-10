From: Morten Welinder <mortenw@gnome.org>
Subject: Small patch for __builtin_fabs and an attribute
Date: Fri, 9 Jul 2010 23:15:04 -0400
Message-ID: <AANLkTilLz1Tgfnf8nwvocJeX5B2bpBG5ZzObHdNKF_ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36204 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab0GJDPH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Jul 2010 23:15:07 -0400
Received: by gxk23 with SMTP id 23so1698147gxk.19
        for <linux-sparse@vger.kernel.org>; Fri, 09 Jul 2010 20:15:06 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

FYI.


diff --git a/lib.c b/lib.c
index a218bfc..7f0b524 100644
--- a/lib.c
+++ b/lib.c
@@ -716,6 +716,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_inslh(long, long);\n");
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 	add_pre_buffer("extern long __builtin_labs(long);\n");
+	add_pre_buffer("extern double __builtin_fabs(double);\n");

 	/* And some floating point stuff.. */
 	add_pre_buffer("extern int __builtin_isgreater(float, float);\n");
diff --git a/parse.c b/parse.c
index f81b19f..0645538 100644
--- a/parse.c
+++ b/parse.c
@@ -515,6 +515,8 @@ const char *ignored_attributes[] = {
 	"__format_arg__",
 	"hot",
 	"__hot__",
+	"may_alias",
+	"__may_alias__",
 	"malloc",
 	"__malloc__",
 	"model",
