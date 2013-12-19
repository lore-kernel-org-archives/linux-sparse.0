From: "Emilio G. Cota" <cota@braap.org>
Subject: [PATCH] Define __CHAR_BIT__
Date: Thu, 19 Dec 2013 00:46:27 -0500
Message-ID: <1387431987-29219-1-git-send-email-cota@braap.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42332 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872Ab3LSFrO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Dec 2013 00:47:14 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

From: "Emilio G. Cota" <cota@braap.org>

gcc defines __CHAR_BIT__ as a pre-defined macro.

Define __CHAR_BIT__ in sparse so that code that needs it (e.g. code
using CHAR_BIT from limits.h) does not generate false warnings.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib.c b/lib.c
index fe20f93..bbdb9b7 100644
--- a/lib.c
+++ b/lib.c
@@ -911,6 +911,7 @@ void create_builtin_stream(void)
 	add_pre_buffer("#weak_define __LONG_LONG_MAX__ " STRINGIFY(__LONG_LONG_MAX__) "\n");
 	add_pre_buffer("#weak_define __WCHAR_MAX__ " STRINGIFY(__WCHAR_MAX__) "\n");
 	add_pre_buffer("#weak_define __SIZEOF_POINTER__ " STRINGIFY(__SIZEOF_POINTER__) "\n");
+	add_pre_buffer("#weak_define __CHAR_BIT__ " STRINGIFY(__CHAR_BIT__) "\n");
 }
 
 static struct symbol_list *sparse_tokenstream(struct token *token)
-- 
1.8.3

