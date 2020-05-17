From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] attribute: teach sparse about attribute((gnu_inline))
Date: Mon, 18 May 2020 01:31:22 +0200
Message-ID: <20200517233122.1872-7-luc.vanoostenryck@gmail.com>
References: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgEQXbd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:31:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05776C061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so9717600wrn.6
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:32 -0700 (PDT)
In-Reply-To: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

But for the moment do nothing special with it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c      | 2 ++
 show-parse.c | 1 +
 symbol.h     | 8 ++++----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/parse.c b/parse.c
index 96e6fda59663..9e7b74f98638 100644
--- a/parse.c
+++ b/parse.c
@@ -590,6 +590,8 @@ static struct init_keyword {
 	{"const",	NS_KEYWORD,	MOD_PURE,	.op = &attr_fun_op },
 	{"__const",	NS_KEYWORD,	MOD_PURE,	.op = &attr_fun_op },
 	{"__const__",	NS_KEYWORD,	MOD_PURE,	.op = &attr_fun_op },
+	{"gnu_inline",	NS_KEYWORD,	MOD_GNU_INLINE,	.op = &attr_fun_op },
+	{"__gnu_inline__",NS_KEYWORD,	MOD_GNU_INLINE,	.op = &attr_fun_op },
 	{"externally_visible",	NS_KEYWORD,	.op = &ext_visible_op },
 	{"__externally_visible__",	NS_KEYWORD,	.op = &ext_visible_op },
 
diff --git a/show-parse.c b/show-parse.c
index f4c7de30da2c..eb71b6504be4 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -131,6 +131,7 @@ const char *modifier_string(unsigned long mod)
 		{MOD_ATOMIC,		"[atomic]"},
 		{MOD_BITWISE,		"[bitwise]"},
 		{MOD_EXPLICITLY_SIGNED,	"[explicitly-signed]"},
+		{MOD_GNU_INLINE,	"[gnu_inline]"},
 		{MOD_NOCAST,		"[nocast]"},
 		{MOD_NODEREF,		"[noderef]"},
 		{MOD_NORETURN,		"[noreturn]"},
diff --git a/symbol.h b/symbol.h
index 4bce78d55e54..7241f13df4e4 100644
--- a/symbol.h
+++ b/symbol.h
@@ -229,7 +229,7 @@ struct symbol {
 #define MOD_UNSIGNED		0x00004000
 #define MOD_EXPLICITLY_SIGNED	0x00008000
 
-     // MOD UNUSED		0x00010000
+#define MOD_GNU_INLINE		0x00010000
 #define MOD_USERTYPE		0x00020000
      // MOD UNUSED		0x00040000
      // MOD UNUSED		0x00080000
@@ -252,7 +252,7 @@ struct symbol {
 #define MOD_ESIGNED	(MOD_SIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SPECIFIER	MOD_SIGNEDNESS
-#define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED | MOD_EXT_VISIBLE | MOD_UNUSED)
+#define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED | MOD_EXT_VISIBLE | MOD_UNUSED | MOD_GNU_INLINE)
 #define MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE | MOD_RESTRICT)
 #define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_ATOMIC | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
@@ -262,9 +262,9 @@ struct symbol {
 /* like cvr-qualifiers but 'reversed' (OK: source <= target) */
 #define MOD_REV_QUAL	(MOD_PURE|MOD_NORETURN)
 /* do not warn when these are duplicated */
-#define MOD_DUP_OK	(MOD_UNUSED)
+#define MOD_DUP_OK	(MOD_UNUSED|MOD_GNU_INLINE)
 /* must be part of the declared symbol, not its type */
-#define MOD_DECLARE	(MOD_STORAGE|MOD_UNUSED|MOD_PURE|MOD_NORETURN|MOD_EXT_VISIBLE)
+#define MOD_DECLARE	(MOD_STORAGE|MOD_GNU_INLINE|MOD_UNUSED|MOD_PURE|MOD_NORETURN|MOD_EXT_VISIBLE)
 
 
 
-- 
2.26.2
