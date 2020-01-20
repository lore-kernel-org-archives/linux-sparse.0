From: john.levon@joyent.com
Subject: [PATCH] define __PRAGMA_REDEFINE_EXTNAME
Date: Mon, 20 Jan 2020 02:47:24 -0800
Message-ID: <20200120104724.20812-1-john.levon@joyent.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [8.12.47.4] ([8.12.47.4]:3980 "EHLO jlevon"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbgATKvZ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Jan 2020 05:51:25 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: John Levon <john.levon@joyent.com>

From: John Levon <john.levon@joyent.com>

As per:

https://gcc.gnu.org/onlinedocs/gcc-4.6.3/gcc/Symbol_002dRenaming-Pragmas.html

we should set this define.

Signed-off-by: John Levon <john.levon@joyent.com>
---
 lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib.c b/lib.c
index 14e51979..9b03895c 100644
--- a/lib.c
+++ b/lib.c
@@ -1507,6 +1507,8 @@ static void predefined_macros(void)
 	if (optimize_size)
 		predefine("__OPTIMIZE_SIZE__", 0, "1");
 
+	predefine("__PRAGMA_REDEFINE_EXTNAME", 1, "1");
+
 	// Temporary hacks
 	predefine("__extension__", 0, NULL);
 	predefine("__pragma__", 0, NULL);
-- 
2.23.0
