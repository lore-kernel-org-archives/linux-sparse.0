From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] C11: teach sparse about '_Thread_local'
Date: Thu,  5 Jan 2017 04:22:16 +0100
Message-ID: <20170105032220.7339-2-luc.vanoostenryck@gmail.com>
References: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33312 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967163AbdAEDXE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Jan 2017 22:23:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so94395867wmu.0
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 19:22:28 -0800 (PST)
In-Reply-To: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is simply a new name for GCC's '__thread' which was already
supported.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                       | 1 +
 validation/c11-thread-local.c | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 validation/c11-thread-local.c

diff --git a/parse.c b/parse.c
index b52c6abe..7fc145db 100644
--- a/parse.c
+++ b/parse.c
@@ -443,6 +443,7 @@ static struct init_keyword {
 	{ "static",	NS_TYPEDEF, .op = &static_op },
 	{ "extern",	NS_TYPEDEF, .op = &extern_op },
 	{ "__thread",	NS_TYPEDEF, .op = &thread_op },
+	{ "_Thread_local",	NS_TYPEDEF, .op = &thread_op },
 
 	/* Statement */
 	{ "if",		NS_KEYWORD, .op = &if_op },
diff --git a/validation/c11-thread-local.c b/validation/c11-thread-local.c
new file mode 100644
index 00000000..464c3e16
--- /dev/null
+++ b/validation/c11-thread-local.c
@@ -0,0 +1,9 @@
+static _Thread_local int foo;
+
+/*
+ * check-name: c11-thread-local
+ * check-command: test-parsing -std=c11 $file
+ *
+ * check-output-ignore
+ * check-output-contains: \[tls\]
+ */
-- 
2.11.0

