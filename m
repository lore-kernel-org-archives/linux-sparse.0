From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] make -m32/-m64 more useful
Date: Wed,  7 Dec 2016 18:38:02 +0100
Message-ID: <20161207173802.23314-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35869 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753235AbcLGSmP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 13:42:15 -0500
Received: by mail-wj0-f195.google.com with SMTP id j10so23966085wjb.3
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 10:42:14 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The option -m64 to just set the size of longs & pointers to 64 bits.

This patch makes this option much more effective by:
- adding define for LONG_MAX & SIZEOF_POINTER
- define __LP64__
- let the dual option, -m32, do the same as -m64 but for 32 bit
---
 lib.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib.c b/lib.c
index d5b56b01..e5b0bb63 100644
--- a/lib.c
+++ b/lib.c
@@ -402,9 +402,21 @@ static void handle_arch_m64_finalize(void)
 		pointer_alignment = 8;
 		size_t_ctype = &ulong_ctype;
 		ssize_t_ctype = &long_ctype;
+		add_pre_buffer("#weak_define __LONG_MAX__ 0x7fffffffffffffff\n");
+		add_pre_buffer("#weak_define __SIZEOF_POINTER__ 8\n");
+		add_pre_buffer("#weak_define __LP64__ 1\n");
 #ifdef __x86_64__
 		add_pre_buffer("#weak_define __x86_64__ 1\n");
 #endif
+	} else {
+		bits_in_long = 32;
+		max_int_alignment = 4;
+		bits_in_pointer = 32;
+		pointer_alignment = 4;
+		size_t_ctype = &ulong_ctype;
+		ssize_t_ctype = &long_ctype;
+		add_pre_buffer("#weak_define __LONG_MAX__ 0x7fffffff\n");
+		add_pre_buffer("#weak_define __SIZEOF_POINTER__ 4\n");
 	}
 }
 
-- 
2.10.2

