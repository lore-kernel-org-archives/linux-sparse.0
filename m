From: Azat Khuzhin <a3at.mail@gmail.com>
Subject: [PATCH 2/2] validation/prototype: regression for skipping prototypes
Date: Sun, 17 May 2015 01:32:25 +0300
Message-ID: <1431815545-21250-3-git-send-email-a3at.mail@gmail.com>
References: <1431815545-21250-1-git-send-email-a3at.mail@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:33255 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbEPWci (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 May 2015 18:32:38 -0400
Received: by lagr1 with SMTP id r1so88894870lag.0
        for <linux-sparse@vger.kernel.org>; Sat, 16 May 2015 15:32:37 -0700 (PDT)
In-Reply-To: <1431815545-21250-1-git-send-email-a3at.mail@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse ML <linux-sparse@vger.kernel.org>
Cc: Azat Khuzhin <a3at.mail@gmail.com>

---
 validation/prototype.c | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 validation/prototype.c

diff --git a/validation/prototype.c b/validation/prototype.c
new file mode 100644
index 0000000..481cc93
--- /dev/null
+++ b/validation/prototype.c
@@ -0,0 +1,6 @@
+static int prototype(void);
+
+/*
+ * check-name: Compile skip function prototype
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
2.1.4

