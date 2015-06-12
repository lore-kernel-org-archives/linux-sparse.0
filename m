From: Azat Khuzhin <a3at.mail@gmail.com>
Subject: [PATCH 2/2 v2] validation/prototype: regression for skipping prototypes
Date: Fri, 12 Jun 2015 08:20:40 +0300
Message-ID: <1434086440-26905-2-git-send-email-a3at.mail@gmail.com>
References: <1431815545-21250-1-git-send-email-a3at.mail@gmail.com>
 <1434086440-26905-1-git-send-email-a3at.mail@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33353 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbbFLFUv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Jun 2015 01:20:51 -0400
Received: by lbcue7 with SMTP id ue7so13749284lbc.0
        for <linux-sparse@vger.kernel.org>; Thu, 11 Jun 2015 22:20:50 -0700 (PDT)
In-Reply-To: <1434086440-26905-1-git-send-email-a3at.mail@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, Azat Khuzhin <a3at.mail@gmail.com>

Signed-off-by: Azat Khuzhin <a3at.mail@gmail.com>
---
v2: Add SOF.

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

