From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] attribute: add support for unused
Date: Mon, 18 May 2020 01:31:20 +0200
Message-ID: <20200517233122.1872-5-luc.vanoostenryck@gmail.com>
References: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXbb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:31:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA1C05BD09
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so8347674wmd.0
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:31 -0700 (PDT)
In-Reply-To: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add support for the attribute 'unused' (and its double underscore
variant. There is no semantic attached to it but it's now at least
parsed and added to the modifiers.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c      | 2 ++
 show-parse.c | 1 +
 symbol.h     | 6 +++---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index c1573b396840..281140bf2ee4 100644
--- a/parse.c
+++ b/parse.c
@@ -571,6 +571,8 @@ static struct init_keyword {
 	{ "__noderef__",NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
 	{ "safe",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
 	{ "__safe__",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
+	{ "unused",	NS_KEYWORD,	MOD_UNUSED,	.op = &attr_mod_op },
+	{ "__unused__",	NS_KEYWORD,	MOD_UNUSED,	.op = &attr_mod_op },
 	{ "force",	NS_KEYWORD,	.op = &attr_force_op },
 	{ "__force__",	NS_KEYWORD,	.op = &attr_force_op },
 	{ "bitwise",	NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
diff --git a/show-parse.c b/show-parse.c
index 0c4b9ec27645..f4c7de30da2c 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -140,6 +140,7 @@ const char *modifier_string(unsigned long mod)
 		{MOD_TLS,		"[tls]"},
 		{MOD_TOPLEVEL,		"[toplevel]"},
 		{MOD_UNSIGNED,		"[unsigned]"},
+		{MOD_UNUSED,		"[unused]"},
 		{MOD_USERTYPE,		"[usertype]"},
 	};
 
diff --git a/symbol.h b/symbol.h
index 9ba764b596da..b594eb36ced0 100644
--- a/symbol.h
+++ b/symbol.h
@@ -235,8 +235,8 @@ struct symbol {
      // MOD UNUSED		0x00080000
      // MOD UNUSED		0x00100000
      // MOD UNUSED		0x00200000
-     // MOD UNUSED		0x00400000
 
+#define MOD_UNUSED		0x00400000
 #define MOD_SAFE		0x00800000	// non-null/non-trapping pointer
 #define MOD_PURE		0x01000000
 #define MOD_BITWISE		0x02000000
@@ -252,7 +252,7 @@ struct symbol {
 #define MOD_ESIGNED	(MOD_SIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SPECIFIER	MOD_SIGNEDNESS
-#define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED | MOD_EXT_VISIBLE)
+#define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED | MOD_EXT_VISIBLE | MOD_UNUSED)
 #define MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE | MOD_RESTRICT)
 #define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_ATOMIC | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
@@ -262,7 +262,7 @@ struct symbol {
 /* like cvr-qualifiers but 'reversed' (OK: source <= target) */
 #define MOD_REV_QUAL	(MOD_PURE|MOD_NORETURN)
 /* do not warn when these are duplicated */
-#define MOD_DUP_OK	0
+#define MOD_DUP_OK	(MOD_UNUSED)
 
 
 /* Current parsing/evaluation function */
-- 
2.26.2
