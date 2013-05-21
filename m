From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/5] lib.c: Add __sync_lock_test_and_set as a builtin function
Date: Tue, 21 May 2013 20:19:11 +0100
Message-ID: <519BC8AF.8060804@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:33946 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752760Ab3EUT2L (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 15:28:11 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib.c b/lib.c
index 7e822eb..2dca810 100644
--- a/lib.c
+++ b/lib.c
@@ -779,6 +779,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern double __builtin_fabs(double);\n");
 	add_pre_buffer("extern void __sync_synchronize();\n");
 	add_pre_buffer("extern int __sync_bool_compare_and_swap(void *, ...);\n");
+	add_pre_buffer("extern int __sync_lock_test_and_set(volatile long *const, const long);\n");
 
 	/* Add Blackfin-specific stuff */
 	add_pre_buffer(
-- 
1.8.2

