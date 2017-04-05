From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/9] MOD_ACCESSED is not a type modifier ...
Date: Wed,  5 Apr 2017 23:09:22 +0200
Message-ID: <20170405210927.27948-5-luc.vanoostenryck@gmail.com>
References: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35502 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934251AbdDEVJn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Apr 2017 17:09:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id t20so6062500wra.2
        for <linux-sparse@vger.kernel.org>; Wed, 05 Apr 2017 14:09:42 -0700 (PDT)
In-Reply-To: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

but is used to track which inline functions are
effectively used. So better remove it from the MOD_...
and implement the same functionality via a flag
in struct symbol.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 gdbhelpers   | 3 ---
 parse.c      | 2 +-
 show-parse.c | 1 -
 symbol.c     | 4 ++--
 symbol.h     | 4 ++--
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/gdbhelpers b/gdbhelpers
index 87ab5b8e9..3d1148a87 100644
--- a/gdbhelpers
+++ b/gdbhelpers
@@ -140,9 +140,6 @@ define gdb_show_ctype
 	if ($arg0->modifiers & MOD_NODEREF)
 		printf "MOD_NODEREF "
 	end
-	if ($arg0->modifiers & MOD_ACCESSED)
-		printf "MOD_ACCESSED "
-	end
 	if ($arg0->modifiers & MOD_TOPLEVEL)
 		printf "MOD_TOPLEVEL "
 	end
diff --git a/parse.c b/parse.c
index 80f0337cc..4c3ebbaac 100644
--- a/parse.c
+++ b/parse.c
@@ -2144,7 +2144,7 @@ static struct statement *start_function(struct symbol *sym)
 	start_function_scope();
 	ret = alloc_symbol(sym->pos, SYM_NODE);
 	ret->ctype = sym->ctype.base_type->ctype;
-	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_CONST | MOD_VOLATILE | MOD_TLS | MOD_INLINE | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF | MOD_ACCESSED | MOD_TOPLEVEL);
+	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_CONST | MOD_VOLATILE | MOD_TLS | MOD_INLINE | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF | MOD_TOPLEVEL);
 	ret->ctype.modifiers |= (MOD_AUTO | MOD_REGISTER);
 	bind_symbol(ret, &return_ident, NS_ITERATOR);
 	stmt->ret = ret;
diff --git a/show-parse.c b/show-parse.c
index 2adeae961..3364aec5e 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -137,7 +137,6 @@ const char *modifier_string(unsigned long mod)
 		{MOD_ADDRESSABLE,	"[addressable]"},
 		{MOD_NOCAST,		"[nocast]"},
 		{MOD_NODEREF,		"[noderef]"},
-		{MOD_ACCESSED,		"[accessed]"},
 		{MOD_TOPLEVEL,		"[toplevel]"},
 		{MOD_ASSIGNED,		"[assigned]"},
 		{MOD_TYPE,		"[type]"},
diff --git a/symbol.c b/symbol.c
index 08c85f40e..2e7fcf16e 100644
--- a/symbol.c
+++ b/symbol.c
@@ -48,9 +48,9 @@ struct symbol_list *translation_unit_used_list = NULL;
 void access_symbol(struct symbol *sym)
 {
 	if (sym->ctype.modifiers & MOD_INLINE) {
-		if (!(sym->ctype.modifiers & MOD_ACCESSED)) {
+		if (!sym->accessed) {
 			add_symbol(&translation_unit_used_list, sym);
-			sym->ctype.modifiers |= MOD_ACCESSED;
+			sym->accessed = 1;
 		}
 	}
 }
diff --git a/symbol.h b/symbol.h
index b8b81fdeb..5192cacd9 100644
--- a/symbol.h
+++ b/symbol.h
@@ -173,6 +173,7 @@ struct symbol {
 					string:1,
 					designated_init:1,
 					forced_arg:1,
+					accessed:1,
 					transparent_union:1;
 			struct expression *array_size;
 			struct ctype ctype;
@@ -222,7 +223,6 @@ struct symbol {
 
 #define MOD_NOCAST	0x100000
 #define MOD_NODEREF	0x200000
-#define MOD_ACCESSED	0x400000
 #define MOD_TOPLEVEL	0x800000	// scoping..
 
 #define MOD_ASSIGNED	0x2000000
@@ -242,7 +242,7 @@ struct symbol {
 #define MOD_SPECIFIER	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL | MOD_SIGNEDNESS)
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL)
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
-	MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
+	MOD_ASSIGNED | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED)
 #define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
 #define MOD_TYPEOF	(MOD_VOLATILE | MOD_CONST | MOD_NOCAST | MOD_SPECIFIER)
-- 
2.12.0

