From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/9] MOD_STORAGE redundancy
Date: Wed,  5 Apr 2017 23:09:24 +0200
Message-ID: <20170405210927.27948-7-luc.vanoostenryck@gmail.com>
References: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32884 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934280AbdDEVJp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Apr 2017 17:09:45 -0400
Received: by mail-wr0-f195.google.com with SMTP id g19so6061931wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 05 Apr 2017 14:09:45 -0700 (PDT)
In-Reply-To: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 parse.c  | 2 +-
 symbol.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index 4c3ebbaac..7d86ccce3 100644
--- a/parse.c
+++ b/parse.c
@@ -2144,7 +2144,7 @@ static struct statement *start_function(struct symbol *sym)
 	start_function_scope();
 	ret = alloc_symbol(sym->pos, SYM_NODE);
 	ret->ctype = sym->ctype.base_type->ctype;
-	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_CONST | MOD_VOLATILE | MOD_TLS | MOD_INLINE | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF | MOD_TOPLEVEL);
+	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_TLS | MOD_CONST | MOD_VOLATILE | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF);
 	ret->ctype.modifiers |= (MOD_AUTO | MOD_REGISTER);
 	bind_symbol(ret, &return_ident, NS_ITERATOR);
 	stmt->ret = ret;
diff --git a/symbol.h b/symbol.h
index b6c777253..a90efc898 100644
--- a/symbol.h
+++ b/symbol.h
@@ -240,7 +240,7 @@ struct symbol {
 #define MOD_LONG_ALL	(MOD_LONG | MOD_LONGLONG | MOD_LONGLONGLONG)
 #define MOD_SPECIFIER	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL | MOD_SIGNEDNESS)
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL)
-#define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
+#define MOD_IGNORE	(MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED)
 #define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
-- 
2.12.0

