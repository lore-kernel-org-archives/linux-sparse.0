From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] [RFC] some modifiers need to be preserved by 'typeof()'
Date: Thu, 24 Nov 2016 18:09:47 +0100
Message-ID: <20161124170947.14379-7-luc.vanoostenryck@gmail.com>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:33221 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756864AbcKXRKG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 12:10:06 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so3656150wjc.0
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 09:10:06 -0800 (PST)
In-Reply-To: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently when we use typeof() all the modifiers from the source
type are ignored and thus not present in the resulting type.

This give all sort of problems. One simple example is:
	const int obj;
	typeof(obj) *ptr;
	*ptr = 0;

We can expect that 'ptr' will have the type 'const int *' and thus
that sparse will warn on the assignment in the last line but it's
not case because 'ptr' has in fact the type 'int *'.

The patch fix this by preserving some of the modifiers when using
typeof().

WARNING: it may be that the old behaviour was so more or less on
  purpose as it provide a way to remove some modifiers by casting
  while still being able to use generic macros. For exmaple, it
  was possible to write the following macro:
	#define noconst(x) (typeof(x))
  and use 'noconst()' as a cast to remove 'const' from types.
  Of course, the problem with this macros is that it remove
  *all* modifiers, not only 'const'.
  With the patch, it won't be possible anymore to do this sort of
  things, which maybe is fine for 'const' but it's why MOD_NOREFREF
  is still dropped as it create problems in the Linew kernel, for example
  in the macro to convert back a percpu variable into a plain one.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c                 | 8 ++++++--
 symbol.h                 | 2 ++
 validation/typeof-mods.c | 1 -
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/symbol.c b/symbol.c
index 92a7a625..a65ad17b 100644
--- a/symbol.c
+++ b/symbol.c
@@ -466,12 +466,16 @@ struct symbol *examine_symbol_type(struct symbol * sym)
 	case SYM_TYPEOF: {
 		struct symbol *base = evaluate_expression(sym->initializer);
 		if (base) {
+			unsigned long mod = 0;
+
 			if (is_bitfield_type(base))
 				warning(base->pos, "typeof applied to bitfield type");
-			if (base->type == SYM_NODE)
+			if (base->type == SYM_NODE) {
+				mod |= base->ctype.modifiers & MOD_TYPEOF;
 				base = base->ctype.base_type;
+			}
 			sym->type = SYM_NODE;
-			sym->ctype.modifiers = 0;
+			sym->ctype.modifiers = mod;
 			sym->ctype.base_type = base;
 			return examine_node_type(sym);
 		}
diff --git a/symbol.h b/symbol.h
index afc4e232..51be81fb 100644
--- a/symbol.h
+++ b/symbol.h
@@ -248,6 +248,8 @@ struct symbol {
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
 #define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
+/* modifiers preserved by typeof() operator */
+#define MOD_TYPEOF	(MOD_VOLATILE | MOD_CONST | MOD_NOCAST | MOD_SPECIFIER)
 
 
 /* Current parsing/evaluation function */
diff --git a/validation/typeof-mods.c b/validation/typeof-mods.c
index 8c98ab8c..9822e96f 100644
--- a/validation/typeof-mods.c
+++ b/validation/typeof-mods.c
@@ -102,7 +102,6 @@ static void test_nocast(void)
 
 /*
  * check-name: typeof-mods
- * check-known-to-fail
  *
  * check-error-start
  * check-error-end
-- 
2.10.2

