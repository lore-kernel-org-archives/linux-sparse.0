From: john.levon@joyent.com
Subject: [PATCH] pre-define __unix__ and friends
Date: Mon, 20 Jan 2020 02:48:03 -0800
Message-ID: <20200120104803.20864-1-john.levon@joyent.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [8.12.47.4] ([8.12.47.4]:10474 "EHLO jlevon"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbgATKvq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Jan 2020 05:51:46 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: John Levon <john.levon@joyent.com>

From: John Levon <john.levon@joyent.com>

GCC defines these, so should we.

Signed-off-by: John Levon <john.levon@joyent.com>
---
 lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib.c b/lib.c
index 9b03895c..739074d1 100644
--- a/lib.c
+++ b/lib.c
@@ -1507,6 +1507,10 @@ static void predefined_macros(void)
 	if (optimize_size)
 		predefine("__OPTIMIZE_SIZE__", 0, "1");
 
+	predefine("__unix__", 1, "1");
+	predefine("__unix", 1, "1");
+	predefine("unix", 1, "1");
+
 	predefine("__PRAGMA_REDEFINE_EXTNAME", 1, "1");
 
 	// Temporary hacks
-- 
2.23.0
