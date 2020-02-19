From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 2/2] dissect: fix sym_is_local(SYM_STRUCT/UNION/ENUM)
Date: Wed, 19 Feb 2020 17:29:34 +0100
Message-ID: <20200219162934.GA26799@redhat.com>
References: <20200219162911.GA26790@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51519 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726659AbgBSQ3m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Feb 2020 11:29:42 -0500
In-Reply-To: <20200219162911.GA26790@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Now that struct_union_enum_specifier() always sets sym->scope we can
simplify sym_is_local(sym) and rely on toplevel() even if sym is type.

Test-case:

	// copied from linux kernel
	# define __force	__attribute__((force))
	#define WRITE_ONCE(x, val) \
	({							\
		union { typeof(x) __val; char __c[1]; } __u =	\
			{ .__val = (__force typeof(x)) (val) }; \
		__write_once_size(&(x), __u.__c, sizeof(x));	\
		__u.__val;					\
	})

	void func(int *p)
	{
		WRITE_ONCE(*p, 0);
	}

before this patch the widely used WRITE_ONCE() generates a lot of spam which
can't be filtered out using sym_is_local(),

	11:6                    def   f func                             void ( ... )
	11:11  func             def . v p                                int *
	13:9                    def   s :__u
	13:9                    --- . v p                                int *
	13:9                    def   m :__u.__val                       int
	13:9                    def   m :__u.__c                         char [1]
	13:9   func             def . v __u                              union :__u
	13:9   func             -w- . v __u                              union :__u
	13:9   func             -w-   m :__u.__val                       int
	13:9   func             --- . v p                                int *
	13:9   func             --r   f __write_once_size                bad type
	13:9   func             -r- . v p                                int *
	13:9   func             -r- . v __u                              union :__u
	13:9   func             m--   m :__u.__c                         char [1]
	13:9   func             --- . v p                                int *
	13:9   func             --- . v __u                              union :__u
	13:9   func             ---   m :__u.__val                       int

plus it triggers warning("no context") in test-dissect.c. With this patch
the only "nonlocal" report is __write_once_size() call.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 4 ++--
 dissect.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/dissect.c b/dissect.c
index 40baf64..c48214b 100644
--- a/dissect.c
+++ b/dissect.c
@@ -152,7 +152,6 @@ static inline struct symbol *expr_symbol(struct expression *expr)
 		if (!sym) {
 			sym = alloc_symbol(expr->pos, SYM_BAD);
 			bind_symbol(sym, expr->symbol_name, NS_SYMBOL);
-			sym->ctype.modifiers = MOD_EXTERN | MOD_TOPLEVEL;
 			sym->kind = expr->op ?: 'v'; /* see EXPR_CALL */
 		}
 	}
@@ -238,7 +237,8 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 				return;
 
 			dctx = dissect_ctx;
-			dissect_ctx = NULL;
+			if (toplevel(base->scope))
+				dissect_ctx = NULL;
 
 			if (base->ident || deanon(base, name, parent))
 				reporter->r_symdef(base);
diff --git a/dissect.h b/dissect.h
index 326d3dc..a77a932 100644
--- a/dissect.h
+++ b/dissect.h
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include "parse.h"
 #include "expression.h"
+#include "scope.h"
 
 #define	U_SHIFT		8
 
@@ -29,7 +30,7 @@ extern struct symbol *dissect_ctx;
 
 static inline bool sym_is_local(struct symbol *sym)
 {
-	return sym->kind == 'v' && !(sym->ctype.modifiers & MOD_TOPLEVEL);
+	return !toplevel(sym->scope);
 }
 
 extern void dissect(struct reporter *, struct string_list *);
-- 
2.5.0
