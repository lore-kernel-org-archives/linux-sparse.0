From: john.levon@joyent.com
Subject: [PATCH] add necessary defined for sunos-derived systems
Date: Mon, 20 Jan 2020 02:48:25 -0800
Message-ID: <20200120104825.20915-1-john.levon@joyent.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [8.12.47.4] ([8.12.47.4]:12737 "EHLO jlevon"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgATKwJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Jan 2020 05:52:09 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: John Levon <john.levon@joyent.com>

From: John Levon <john.levon@joyent.com>

Signed-off-by: John Levon <john.levon@joyent.com>
---
 lib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib.c b/lib.c
index 739074d1..7181c84f 100644
--- a/lib.c
+++ b/lib.c
@@ -1630,6 +1630,13 @@ static void predefined_macros(void)
 		predefine("__PIE__", 0, "%d", fpie);
 	}
 
+	if (arch_os == OS_SUNOS) {
+		predefine("__sun__", 1, "1");
+		predefine("__sun", 1, "1");
+		predefine("sun", 1, "1");
+		predefine("__svr4__", 1, "1");
+	}
+
 	predefined_cmodel();
 }
 
-- 
2.23.0
