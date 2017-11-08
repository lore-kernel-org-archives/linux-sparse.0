From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 5/7] define MOD_QUALIFIER for (MOD_CONST | MOD_VOLATILE)
Date: Wed,  8 Nov 2017 22:06:11 +0100
Message-ID: <20171108210613.14252-6-luc.vanoostenryck@gmail.com>
References: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:47518 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753503AbdKHVI2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 16:08:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id r196so13168288wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 13:08:27 -0800 (PST)
In-Reply-To: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is slightly shorter (and thus may avoid long lines) and
facilitate the introduction of MOD_RETRICT in a later patch.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 2 +-
 expand.c   | 2 +-
 parse.c    | 2 +-
 symbol.h   | 5 +++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index cf3cf244d..cfe53f747 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -627,7 +627,7 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
 
 static void examine_fn_arguments(struct symbol *fn);
 
-#define MOD_IGN (MOD_VOLATILE | MOD_CONST | MOD_PURE)
+#define MOD_IGN (MOD_QUALIFIER | MOD_PURE)
 
 const char *type_difference(struct ctype *c1, struct ctype *c2,
 	unsigned long mod1, unsigned long mod2)
diff --git a/expand.c b/expand.c
index 5f908c971..60986b3ff 100644
--- a/expand.c
+++ b/expand.c
@@ -478,7 +478,7 @@ static int expand_comma(struct expression *expr)
 	return cost;
 }
 
-#define MOD_IGN (MOD_VOLATILE | MOD_CONST)
+#define MOD_IGN (MOD_QUALIFIER)
 
 static int compare_types(int op, struct symbol *left, struct symbol *right)
 {
diff --git a/parse.c b/parse.c
index e7e112847..c6dccfbd8 100644
--- a/parse.c
+++ b/parse.c
@@ -2184,7 +2184,7 @@ static struct statement *start_function(struct symbol *sym)
 	start_function_scope();
 	ret = alloc_symbol(sym->pos, SYM_NODE);
 	ret->ctype = sym->ctype.base_type->ctype;
-	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_CONST | MOD_VOLATILE | MOD_TLS | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF);
+	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_QUALIFIER | MOD_TLS | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF);
 	ret->ctype.modifiers |= (MOD_AUTO | MOD_REGISTER);
 	bind_symbol(ret, &return_ident, NS_ITERATOR);
 	stmt->ret = ret;
diff --git a/symbol.h b/symbol.h
index d33afc97d..994a11a7f 100644
--- a/symbol.h
+++ b/symbol.h
@@ -242,9 +242,10 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL)
 #define MOD_IGNORE	(MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED)
-#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
+#define MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE)
+#define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
-#define MOD_TYPEOF	(MOD_VOLATILE | MOD_CONST | MOD_NOCAST | MOD_SPECIFIER)
+#define MOD_TYPEOF	(MOD_QUALIFIER | MOD_NOCAST | MOD_SPECIFIER)
 
 
 /* Current parsing/evaluation function */
-- 
2.14.0

