From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] avoid to redefine __INT_MAX__ and friends
Date: Fri, 19 May 2017 13:20:52 +0200
Message-ID: <20170519112053.24632-3-luc.vanoostenryck@gmail.com>
References: <20170519112053.24632-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36434 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754399AbdESLVG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 May 2017 07:21:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so2612020wrc.3
        for <linux-sparse@vger.kernel.org>; Fri, 19 May 2017 04:21:05 -0700 (PDT)
In-Reply-To: <20170519112053.24632-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Since commit 4fae9be00 & 5466cf8f3 ("predefine __INT_MAX__ and friends" &
"predefine __SIZEOF_INT__ & friends"), macros like __INT_MAX__  and
__SIZEOF_POINTER__ are predefine twice.

Fix this by removing the old definition, based on the size of these
types on the machine where sparse was compiled.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib.c b/lib.c
index cf6bea645..20eb72e95 100644
--- a/lib.c
+++ b/lib.c
@@ -1072,11 +1072,7 @@ void create_builtin_stream(void)
 	/* GCC defines these for limits.h */
 	add_pre_buffer("#weak_define __SHRT_MAX__ " STRINGIFY(__SHRT_MAX__) "\n");
 	add_pre_buffer("#weak_define __SCHAR_MAX__ " STRINGIFY(__SCHAR_MAX__) "\n");
-	add_pre_buffer("#weak_define __INT_MAX__ " STRINGIFY(__INT_MAX__) "\n");
-	add_pre_buffer("#weak_define __LONG_MAX__ " STRINGIFY(__LONG_MAX__) "\n");
-	add_pre_buffer("#weak_define __LONG_LONG_MAX__ " STRINGIFY(__LONG_LONG_MAX__) "\n");
 	add_pre_buffer("#weak_define __WCHAR_MAX__ " STRINGIFY(__WCHAR_MAX__) "\n");
-	add_pre_buffer("#weak_define __SIZEOF_POINTER__ " STRINGIFY(__SIZEOF_POINTER__) "\n");
 	add_pre_buffer("#weak_define __CHAR_BIT__ " STRINGIFY(__CHAR_BIT__) "\n");
 }
 
-- 
2.13.0

