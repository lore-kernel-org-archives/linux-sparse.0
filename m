From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 1/2] struct_union_enum_specifier: always initialize
 sym->scope
Date: Wed, 19 Feb 2020 17:29:11 +0100
Message-ID: <20200219162911.GA26790@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726712AbgBSQ3T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Feb 2020 11:29:19 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Currently it is not possible to figure out the scope of the private
struct/union/enum type, its ->scope is NULL because bind_symbol() is
not called.

Change struct_union_enum_specifier() to set sym->scope = block_scope
in this case, this is what bind_symbol() does when type has a name.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 parse.c | 2 ++
 scope.c | 5 +++++
 scope.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/parse.c b/parse.c
index a08165a..3e7c60e 100644
--- a/parse.c
+++ b/parse.c
@@ -772,6 +772,8 @@ static struct token *struct_union_enum_specifier(enum type type,
 	}
 
 	sym = alloc_symbol(token->pos, type);
+	/* make toplevel(sym->scope) work */
+	set_current_scope(sym);
 	token = parse(token->next, sym);
 	ctx->ctype.base_type = sym;
 	token =  expect(token, '}', "at end of specifier");
diff --git a/scope.c b/scope.c
index cbf2fcf..420c0f5 100644
--- a/scope.c
+++ b/scope.c
@@ -40,6 +40,11 @@ struct scope	*block_scope = &builtin_scope,		// regular automatic variables etc
 		*file_scope = &builtin_scope,		// static
 		*global_scope = &builtin_scope;		// externally visible
 
+void set_current_scope(struct symbol *sym)
+{
+	sym->scope = block_scope;
+}
+
 void bind_scope(struct symbol *sym, struct scope *scope)
 {
 	sym->scope = scope;
diff --git a/scope.h b/scope.h
index d9a14aa..3cad514 100644
--- a/scope.h
+++ b/scope.h
@@ -53,6 +53,7 @@ extern void end_symbol_scope(void);
 extern void start_function_scope(void);
 extern void end_function_scope(void);
 
+extern void set_current_scope(struct symbol *);
 extern void bind_scope(struct symbol *, struct scope *);
 extern void rebind_scope(struct symbol *, struct scope *);
 
-- 
2.5.0
