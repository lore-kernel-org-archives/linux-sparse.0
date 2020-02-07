From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: change do_symbol(SYM_FN) to check base_type->stmt
 != NULL
Date: Fri, 7 Feb 2020 11:32:07 +0100
Message-ID: <20200207103207.GA16991@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38712 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgBGKcN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 05:32:13 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

examine_fn_arguments() silently degenerates function arguments into
pointers but dissect doesn't do evaluate_symbol_list(), that is why
do_sym_list(type->arguments) can report the bogus definitions.

Test case:

	void extf(int MUST_NOT_BE_REPORTED);
	typedef void (fptr_t)(int MUST_NOT_BE_REPORTED);

	void func1(fptr_t fptr) {}
	void func2(typeof(extf) fptr) {}
	void func3(void) { typeof(extf) fptr; };
	void func4(void (fptr)(int MUST_NOT_BE_REPORTED)) {}

without this patch:

	4:6                    def  func1                            void ( ... )
	4:12  func1            def  fptr                             void ( ... )
	2:23  fptr             def  MUST_NOT_BE_REPORTED             int
	5:6                    def  func2                            void ( ... )
	5:19  func2            ---  extf                             void ( ... )
	5:12  func2            def  fptr                             void ( ... )
	1:11  fptr             def  MUST_NOT_BE_REPORTED             int
	6:6                    def  func3                            void ( ... )
	6:27  func3            ---  extf                             void ( ... )
	6:33  func3            def  fptr                             void ( ... )
	1:11  fptr             def  MUST_NOT_BE_REPORTED             int
	7:6                    def  func4                            void ( ... )
	7:12  func4            def  fptr                             void ( ... )
	7:24  fptr             def  MUST_NOT_BE_REPORTED             int

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/dissect.c b/dissect.c
index 54e11d2..b48cd85 100644
--- a/dissect.c
+++ b/dissect.c
@@ -589,6 +589,7 @@ static inline struct symbol *do_symbol(struct symbol *sym)
 {
 	struct symbol *type = base_type(sym);
 	struct symbol *dctx = dissect_ctx;
+	struct statement *stmt;
 
 	reporter->r_symdef(sym);
 
@@ -603,12 +604,22 @@ static inline struct symbol *do_symbol(struct symbol *sym)
 		dissect_ctx = dctx;
 
 	break; case SYM_FN:
+		stmt = sym->ctype.modifiers & MOD_INLINE
+			? type->inline_stmt
+			: type->stmt;
+		if (!stmt)
+			break;
+
+		if (dctx)
+			sparse_error(dctx->pos,
+				"dissect_ctx change %.*s -> %s",
+				dctx->ident->len, dctx->ident->name,
+				show_ident(sym->ident));
+
 		dissect_ctx = sym;
 		return_type = base_type(type);
 		do_sym_list(type->arguments);
-		do_statement(U_VOID, sym->ctype.modifiers & MOD_INLINE
-					? type->inline_stmt
-					: type->stmt);
+		do_statement(U_VOID, stmt);
 		dissect_ctx = dctx;
 		return_type = NULL;
 	}
-- 
2.5.0
