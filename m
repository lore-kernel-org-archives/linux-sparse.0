From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] predefine: add helper predefine_{strong,weak}()
Date: Sun,  5 Jul 2020 15:16:03 +0200
Message-ID: <20200705131605.26551-2-luc.vanoostenryck@gmail.com>
References: <20200705131605.26551-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgGENQO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:16:14 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B229DC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:16:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so32217271edr.9
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:16:13 -0700 (PDT)
In-Reply-To: <20200705131605.26551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A lot of predefined macros are just set to the value '1' and
of them have a name that is not statically known. OTOH, the
function predefine() is designed for a statically known name
but a variable value.

Add a set of helpers to cover the first case: predefine_strong()
and predefine_weak().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h         |  2 ++
 pre-process.c | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/lib.h b/lib.h
index 46483f2bed5c..a3288a3abf4e 100644
--- a/lib.h
+++ b/lib.h
@@ -127,6 +127,8 @@ enum phase {
 
 extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
 extern void predefine(const char *name, int weak, const char *fmt, ...) FORMAT_ATTR(3);
+extern void predefine_strong(const char *name, ...) FORMAT_ATTR(1);
+extern void predefine_weak(const char *name, ...) FORMAT_ATTR(1);
 extern void predefine_nostd(const char *name);
 extern void predefined_macros(void);
 
diff --git a/pre-process.c b/pre-process.c
index 38167802f465..403e3507611c 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1439,6 +1439,32 @@ void predefine_nostd(const char *name)
 		predefine(name, 1, "1");
 }
 
+static void predefine_fmt(const char *fmt, int weak, va_list ap)
+{
+	static char buf[256];
+
+	vsnprintf(buf, sizeof(buf), fmt, ap);
+	predefine(buf, weak, "1");
+}
+
+void predefine_strong(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	predefine_fmt(fmt, 0, ap);
+	va_end(ap);
+}
+
+void predefine_weak(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	predefine_fmt(fmt, 1, ap);
+	va_end(ap);
+}
+
 static int do_handle_define(struct stream *stream, struct token **line, struct token *token, int attr)
 {
 	struct token *arglist, *expansion;
-- 
2.27.0
