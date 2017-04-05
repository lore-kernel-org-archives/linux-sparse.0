From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/9] MOD_QUALIFIER
Date: Wed,  5 Apr 2017 23:09:25 +0200
Message-ID: <20170405210927.27948-8-luc.vanoostenryck@gmail.com>
References: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32896 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934281AbdDEVJq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Apr 2017 17:09:46 -0400
Received: by mail-wr0-f195.google.com with SMTP id g19so6062011wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 05 Apr 2017 14:09:45 -0700 (PDT)
In-Reply-To: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 evaluate.c | 2 +-
 expand.c   | 2 +-
 parse.c    | 2 +-
 symbol.h   | 5 +++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 47eeaef2e..b93982e19 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -627,7 +627,7 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
 
 static void examine_fn_arguments(struct symbol *fn);
 
-#define MOD_IGN (MOD_VOLATILE | MOD_CONST | MOD_PURE)
+#define MOD_IGN (MOD_QUALIFIER | MOD_PURE)
 
 const char *type_difference(struct ctype *c1, struct ctype *c2,
 	unsigned long mod1, unsigned long mod2)
diff --git a/expand.c b/expand.c
index 11f7255bf..7af91e8e5 100644
--- a/expand.c
+++ b/expand.c
@@ -479,7 +479,7 @@ static int expand_comma(struct expression *expr)
 	return cost;
 }
 
-#define MOD_IGN (MOD_VOLATILE | MOD_CONST)
+#define MOD_IGN (MOD_QUALIFIER)
 
 static int compare_types(int op, struct symbol *left, struct symbol *right)
 {
diff --git a/parse.c b/parse.c
index 7d86ccce3..897d4caa4 100644
--- a/parse.c
+++ b/parse.c
@@ -2144,7 +2144,7 @@ static struct statement *start_function(struct symbol *sym)
 	start_function_scope();
 	ret = alloc_symbol(sym->pos, SYM_NODE);
 	ret->ctype = sym->ctype.base_type->ctype;
-	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_TLS | MOD_CONST | MOD_VOLATILE | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF);
+	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_TLS | MOD_QUALIFIER | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF);
 	ret->ctype.modifiers |= (MOD_AUTO | MOD_REGISTER);
 	bind_symbol(ret, &return_ident, NS_ITERATOR);
 	stmt->ret = ret;
diff --git a/symbol.h b/symbol.h
index a90efc898..16d58594e 100644
--- a/symbol.h
+++ b/symbol.h
@@ -242,9 +242,10 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL)
 #define MOD_IGNORE	(MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED)
-#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
+#define	MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE)
+#define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
-#define MOD_TYPEOF	(MOD_VOLATILE | MOD_CONST | MOD_NOCAST | MOD_SPECIFIER)
+#define MOD_TYPEOF	(MOD_QUALIFIER | MOD_NOCAST | MOD_SPECIFIER)
 
 
 /* Current parsing/evaluation function */
-- 
2.12.0

