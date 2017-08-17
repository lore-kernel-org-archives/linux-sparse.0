From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 02/14] cast: add tests for warnings issued by sparse -v
Date: Thu, 17 Aug 2017 06:05:17 +0200
Message-ID: <20170817040529.7289-3-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35153 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdHQEFm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:05:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id p8so123644wrf.2
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:05:41 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The sparse command (aka the 'checker') do a number of additional
checks when used with the -v flag. I strongly believes that this
option is rarely used let me not disgress about it here.

One of this additional checks are about casts.
Let add soe testcase in thr tessuite in order to avoid any
regression there.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/cast-kinds-check.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 validation/cast-kinds-check.c

diff --git a/validation/cast-kinds-check.c b/validation/cast-kinds-check.c
new file mode 100644
index 000000000..f3ece313a
--- /dev/null
+++ b/validation/cast-kinds-check.c
@@ -0,0 +1,26 @@
+#include "cast-kinds.c"
+
+/*
+ * check-name: cast-kinds check
+ * check-command: sparse -m64 -v $file
+ *
+ * check-error-start
+cast-kinds.c:5:45: warning: cast drops bits
+cast-kinds.c:6:47: warning: cast drops bits
+cast-kinds.c:7:46: warning: cast drops bits
+cast-kinds.c:8:45: warning: cast drops bits
+cast-kinds.c:10:49: warning: cast drops bits
+cast-kinds.c:12:48: warning: cast drops bits
+cast-kinds.c:13:50: warning: cast drops bits
+cast-kinds.c:14:49: warning: cast drops bits
+cast-kinds.c:15:48: warning: cast drops bits
+cast-kinds.c:17:52: warning: cast drops bits
+cast-kinds.c:21:49: warning: cast wasn't removed
+cast-kinds.c:22:48: warning: cast wasn't removed
+cast-kinds.c:28:52: warning: cast wasn't removed
+cast-kinds.c:29:51: warning: cast wasn't removed
+cast-kinds.c:34:52: warning: cast wasn't removed
+cast-kinds.c:35:54: warning: cast wasn't removed
+cast-kinds.c:36:52: warning: cast wasn't removed
+ * check-error-end
+ */
-- 
2.14.0

