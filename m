From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] reorganize the definition of the modifiers
Date: Wed,  5 Apr 2017 23:09:23 +0200
Message-ID: <20170405210927.27948-6-luc.vanoostenryck@gmail.com>
References: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34341 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933224AbdDEVJo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Apr 2017 17:09:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so6043424wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 05 Apr 2017 14:09:43 -0700 (PDT)
In-Reply-To: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now they are grouped a bit more logically.

Note: MOD_ASSIGNED & MOD_ADDRESSABLE are not type modifiers
      but properties of the symbol. As such they should be
      moved to struct symbol. However, as they should be
      correctly propagated to the symbol components if any,
      better to leave them as is.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 65 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/symbol.h b/symbol.h
index 5192cacd9..b6c777253 100644
--- a/symbol.h
+++ b/symbol.h
@@ -200,39 +200,38 @@ struct symbol {
 };
 
 /* Modifiers */
-#define MOD_AUTO	0x0001
-#define MOD_REGISTER	0x0002
-#define MOD_STATIC	0x0004
-#define MOD_EXTERN	0x0008
-
-#define MOD_CONST	0x0010
-#define MOD_VOLATILE	0x0020
-#define MOD_SIGNED	0x0040
-#define MOD_UNSIGNED	0x0080
-
-#define MOD_CHAR	0x0100
-#define MOD_SHORT	0x0200
-#define MOD_LONG	0x0400
-#define MOD_LONGLONG	0x0800
-#define MOD_LONGLONGLONG	0x1000
-#define MOD_PURE	0x2000
-
-#define MOD_TLS		0x20000
-#define MOD_INLINE	0x40000
-#define MOD_ADDRESSABLE	0x80000
-
-#define MOD_NOCAST	0x100000
-#define MOD_NODEREF	0x200000
-#define MOD_TOPLEVEL	0x800000	// scoping..
-
-#define MOD_ASSIGNED	0x2000000
-#define MOD_TYPE	0x4000000
-#define MOD_SAFE	0x8000000	// non-null/non-trapping pointer
-
-#define MOD_USERTYPE	0x10000000
-#define MOD_NORETURN	0x20000000
-#define MOD_EXPLICITLY_SIGNED	0x40000000
-#define MOD_BITWISE	0x80000000
+#define MOD_AUTO		0x00000001
+#define MOD_REGISTER		0x00000002
+#define MOD_STATIC		0x00000004
+#define MOD_EXTERN		0x00000008
+#define MOD_TOPLEVEL		0x00000010	// scoping..
+#define MOD_TLS			0x00000020
+#define MOD_INLINE		0x00000040
+
+#define MOD_ASSIGNED		0x00000080
+#define MOD_ADDRESSABLE		0x00000100
+
+#define MOD_CONST		0x00000200
+#define MOD_VOLATILE		0x00000400
+
+#define MOD_SIGNED		0x00002000
+#define MOD_UNSIGNED		0x00004000
+#define MOD_EXPLICITLY_SIGNED	0x00008000
+
+#define MOD_TYPE		0x00010000
+#define MOD_USERTYPE		0x00020000
+#define MOD_CHAR		0x00040000
+#define MOD_SHORT		0x00080000
+#define MOD_LONG		0x00100000
+#define MOD_LONGLONG		0x00200000
+#define MOD_LONGLONGLONG	0x00400000
+
+#define MOD_SAFE		0x00800000	// non-null/non-trapping pointer
+#define MOD_PURE		0x01000000
+#define MOD_BITWISE		0x02000000
+#define MOD_NOCAST		0x04000000
+#define MOD_NODEREF		0x08000000
+#define MOD_NORETURN		0x10000000
 
 
 #define MOD_NONLOCAL	(MOD_EXTERN | MOD_TOPLEVEL)
-- 
2.12.0

