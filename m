From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] define __LP64__ & _LP64 if arch_m64 is enabled
Date: Tue,  7 Feb 2017 21:04:22 +0100
Message-ID: <20170207200425.34189-2-luc.vanoostenryck@gmail.com>
References: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36652 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753893AbdBGUGd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:06:33 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so30412968wmd.3
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:06:32 -0800 (PST)
In-Reply-To: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

They're part of GCC's common predefined macros and some
code & header files depend on them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib.c b/lib.c
index 3abc3e64b..3996c5673 100644
--- a/lib.c
+++ b/lib.c
@@ -406,6 +406,8 @@ static void handle_arch_m64_finalize(void)
 		pointer_alignment = 8;
 		size_t_ctype = &ulong_ctype;
 		ssize_t_ctype = &long_ctype;
+		add_pre_buffer("#weak_define __LP64__ 1\n");
+		add_pre_buffer("#weak_define _LP64 1\n");
 #ifdef __x86_64__
 		add_pre_buffer("#weak_define __x86_64__ 1\n");
 #endif
-- 
2.11.0

