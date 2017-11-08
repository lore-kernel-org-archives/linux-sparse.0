From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 4/7] remove redundancy in MOD_STORAGE
Date: Wed,  8 Nov 2017 22:06:10 +0100
Message-ID: <20171108210613.14252-5-luc.vanoostenryck@gmail.com>
References: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:49609 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753235AbdKHVI2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 16:08:28 -0500
Received: by mail-wm0-f68.google.com with SMTP id b189so13014290wmd.4
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 13:08:26 -0800 (PST)
In-Reply-To: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

MOD_TOPLEVEL & MOD_INLINE are already include in MOD_STORAGE
so there is no need to repeat them in MOD_IGNORE & elsewhere
where MOD_STORAGE is used.

Change this by removing the redundant MOD_TOPLEVEL & MOD_INLINE.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c  | 2 +-
 symbol.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index b7917ca05..e7e112847 100644
--- a/parse.c
+++ b/parse.c
@@ -2184,7 +2184,7 @@ static struct statement *start_function(struct symbol *sym)
 	start_function_scope();
 	ret = alloc_symbol(sym->pos, SYM_NODE);
 	ret->ctype = sym->ctype.base_type->ctype;
-	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_CONST | MOD_VOLATILE | MOD_TLS | MOD_INLINE | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF | MOD_TOPLEVEL);
+	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_CONST | MOD_VOLATILE | MOD_TLS | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF);
 	ret->ctype.modifiers |= (MOD_AUTO | MOD_REGISTER);
 	bind_symbol(ret, &return_ident, NS_ITERATOR);
 	stmt->ret = ret;
diff --git a/symbol.h b/symbol.h
index fdecbc548..d33afc97d 100644
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
2.14.0

