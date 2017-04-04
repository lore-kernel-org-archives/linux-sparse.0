From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] fix -dD for never-defined #undef
Date: Tue,  4 Apr 2017 23:49:55 +0200
Message-ID: <20170404214955.47926-7-luc.vanoostenryck@gmail.com>
References: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34412 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754821AbdDDVuQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 17:50:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id x75so8017293wma.1
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 14:50:15 -0700 (PDT)
In-Reply-To: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Note: to support this, we have to create a symbol where
      it wasn't needed before.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c                         | 3 +--
 validation/preprocessor/dump-macros.c | 6 +++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 63df3f71c..5067b59b2 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1400,8 +1400,7 @@ static int do_handle_undef(struct stream *stream, struct token **line, struct to
 			return 1;
 		if (attr == sym->attr && sym->namespace == NS_UNDEF)
 			return 1;
-	} else if (attr <= SYM_ATTR_NORMAL)
-		return 1;
+	}
 
 	if (!sym || sym->scope != file_scope) {
 		sym = alloc_symbol(left->pos, SYM_NODE);
diff --git a/validation/preprocessor/dump-macros.c b/validation/preprocessor/dump-macros.c
index 5508233aa..a10325171 100644
--- a/validation/preprocessor/dump-macros.c
+++ b/validation/preprocessor/dump-macros.c
@@ -6,9 +6,11 @@
 #define DEF xyz
 
 #define NYDEF ydef
+
+#undef	NDEF2
 /*
  * check-name: dump-macros
- * check-command: sparse -E -dD -DIJK=ijk -UNDEF -UNYDEF $file
+ * check-command: sparse -E -dD -DIJK=ijk -UNDEF1 -UNYDEF $file
  *
  * check-output-ignore
 check-output-pattern-1-times: #define __CHECKER__ 1
@@ -16,4 +18,6 @@ check-output-contains: #define IJK ijk
 check-output-contains: #define DEF xyz
 check-output-contains: #define NYDEF ydef
 check-output-contains: #undef ABC
+check-output-contains: #undef NDEF1
+check-output-contains: #undef NDEF2
  */
-- 
2.12.0

