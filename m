From: john.levon@joyent.com
Subject: [PATCH] predefine "i386" if needed
Date: Wed, 22 Jan 2020 16:01:36 -0800
Message-ID: <20200123000136.24109-1-john.levon@joyent.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [8.12.47.4] ([8.12.47.4]:29003 "EHLO jlevon"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgAWAFj (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Jan 2020 19:05:39 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: John Levon <john.levon@joyent.com>

From: John Levon <john.levon@joyent.com>

Signed-off-by: John Levon <john.levon@joyent.com>
---
 target-x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target-x86.c b/target-x86.c
index 01d213ef..d770349c 100644
--- a/target-x86.c
+++ b/target-x86.c
@@ -29,6 +29,7 @@ static void predefine_i386(const struct target *self)
 {
 	predefine("__i386__", 1, "1");
 	predefine("__i386", 1, "1");
+	predefine_nostd("i386");
 }
 
 const struct target target_i386 = {
-- 
2.23.0
