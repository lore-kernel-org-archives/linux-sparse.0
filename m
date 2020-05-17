From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] attribute: allow some attribute to be present multiple times
Date: Mon, 18 May 2020 01:31:19 +0200
Message-ID: <20200517233122.1872-4-luc.vanoostenryck@gmail.com>
References: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgEQXbb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:31:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63473C061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f13so7478658wmc.5
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:30 -0700 (PDT)
In-Reply-To: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A warning is issued when a qualifier or another modifier
is present more than once in a declaration.

This is fine but in the kernel some attributes, for example
'unused' & 'gnu_inline', are sometimes present multiple times
in the same declaration (mainly they are added in the define
used for 'inline'). This then creates a lot of useless noise.

So, use a (now empty) white list to not warn when these attributes
are present multiple times in the same declaration.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c  | 2 +-
 symbol.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 974ff7a1961c..c1573b396840 100644
--- a/parse.c
+++ b/parse.c
@@ -1129,7 +1129,7 @@ static struct token *attribute_aligned(struct token *token, struct symbol *attr,
 
 static void apply_mod(struct position *pos, unsigned long *mods, unsigned long mod)
 {
-	if (*mods & mod)
+	if (*mods & mod & ~MOD_DUP_OK)
 		warning(*pos, "duplicate %s", modifier_string(mod));
 	*mods |= mod;
 }
diff --git a/symbol.h b/symbol.h
index 18476582aa8d..9ba764b596da 100644
--- a/symbol.h
+++ b/symbol.h
@@ -261,6 +261,8 @@ struct symbol {
 #define MOD_FUN_ATTR	(MOD_PURE|MOD_NORETURN)
 /* like cvr-qualifiers but 'reversed' (OK: source <= target) */
 #define MOD_REV_QUAL	(MOD_PURE|MOD_NORETURN)
+/* do not warn when these are duplicated */
+#define MOD_DUP_OK	0
 
 
 /* Current parsing/evaluation function */
-- 
2.26.2
