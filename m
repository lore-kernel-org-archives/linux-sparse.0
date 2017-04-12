From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] add helper handle_simple_switch()
Date: Wed, 12 Apr 2017 10:37:01 +0200
Message-ID: <20170412083703.11552-4-luc.vanoostenryck@gmail.com>
References: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35916 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbdDLIhv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 04:37:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id o21so3069502wrb.3
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 01:37:50 -0700 (PDT)
In-Reply-To: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib.c b/lib.c
index 8c9c36bd5..1d21a2fb7 100644
--- a/lib.c
+++ b/lib.c
@@ -454,6 +454,25 @@ static void handle_arch_finalize(void)
 }
 
 
+static int handle_simple_switch(const char *arg, const char *name, int *flag)
+{
+	int val = 1;
+
+	// Prefixe "no-" mean to turn flag off.
+	if (strncmp(arg, "no-", 3) == 0) {
+		arg += 3;
+		val = 0;
+	}
+
+	if (strcmp(arg, name) == 0) {
+		*flag = val;
+		return 1;
+	}
+
+	// not handled
+	return 0;
+}
+
 static char **handle_switch_o(char *arg, char **next)
 {
 	if (!strcmp (arg, "o")) {       // "-o foo"
-- 
2.12.0

