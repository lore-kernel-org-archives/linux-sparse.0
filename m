From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: fun with declarations and definitions
Date: Mon, 2 Feb 2009 07:30:19 +0000
Message-ID: <20090202073018.GB28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46848 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbZBBHaU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2009 02:30:20 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LTtG7-0006bz-2n
	for linux-sparse@vger.kernel.org; Mon, 02 Feb 2009 07:30:19 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

	There are several interesting problems caused by the fact that
we create a separate symbol for each declaration of given function.

1)

static inline int f(void);
static int g(void)
{
	return f();
}
static inline int f(void)
{
	return 0;
}
gives an error, since the instance of f in g is not associated with anything
useful.  Needless to say, this is a perfectly valid C.  Moreover,
static inline int f(void)
{
	return 0;
}
static inline int f(void);
static int g(void)
{
	return f();
}
will step on the same thing.  Currently we get the former case all over the
place in the kernel, thanks to the way DEFINE_SYSCALLx() is done.

I have a kinda-sorta fix for that (basically, add a reference to external
definition to struct symbol and update it correctly - it's not hard).
However, that doesn't cover *another* weirdness in the same area -
gccisms around extern inline.  There we can have inline and external
definitions in the same translation unit (and they can be different,
to make the things even more interesting).  Anyway, that's a separate
story - as it is, we don't even have a way to tell 'extern inline ...'
from 'inline ...'

2) More fun in the same area: checks for SYM_FN in external_declaration()
do not take into account the possibility of
	void f(int);
	typeof(f) g;
Ergo, we get linkage-less function declarations.  Fun, innit?  No patch.

3) Better yet, sparse does _NOT_ reject
	typeof(f) g
	{
		...
	}
which is obviously a Bloody Bad Idea(tm) (just think what that does to
argument list).  Similar crap is triggerable with typedef.  IMO, we really
ought to reject _that_ - not only 6.9.1(2) explicitly requires that, but
there's no even remotely sane way to deal with arguments.

4)
	static void f(void);
	...
	void f(void);
triggers "warning: symbol 'f' was not declared. Should it be static?"
which is at least very confusing - it *is* declared and it *is* static.
IOW, we do not collect the linkage information sanely.  (2) will make
fixing that one very interesting.

Anyway, proposed patch for (1) follows:

Subject: [PATCH] Handle mix of declarations and definitions

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c                 |    7 +++++++
 parse.c                    |   16 ++++++++++++++++
 symbol.h                   |    1 +
 validation/context-named.c |    2 ++
 validation/definitions.c   |   12 ++++++++++++
 5 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 validation/definitions.c

diff --git a/evaluate.c b/evaluate.c
index f976645..5ed31a9 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2747,6 +2747,10 @@ static int evaluate_symbol_call(struct expression *expr)
 	if (ctype->ctype.modifiers & MOD_INLINE) {
 		int ret;
 		struct symbol *curr = current_fn;
+
+		if (ctype->definition)
+			ctype = ctype->definition;
+
 		current_fn = ctype->ctype.base_type;
 
 		ret = inline_function(expr, ctype);
@@ -3052,6 +3056,9 @@ static struct symbol *evaluate_symbol(struct symbol *sym)
 	if (base_type->type == SYM_FN) {
 		struct symbol *curr = current_fn;
 
+		if (sym->definition && sym->definition != sym)
+			return evaluate_symbol(sym->definition);
+
 		current_fn = base_type;
 
 		examine_fn_arguments(base_type);
diff --git a/parse.c b/parse.c
index eb31871..3cdcf63 100644
--- a/parse.c
+++ b/parse.c
@@ -2105,6 +2105,7 @@ static struct token *parse_function_body(struct token *token, struct symbol *dec
 	struct symbol_list **old_symbol_list;
 	struct symbol *base_type = decl->ctype.base_type;
 	struct statement *stmt, **p;
+	struct symbol *prev;
 	struct symbol *arg;
 
 	old_symbol_list = function_symbol_list;
@@ -2138,6 +2139,18 @@ static struct token *parse_function_body(struct token *token, struct symbol *dec
 	if (!(decl->ctype.modifiers & MOD_INLINE))
 		add_symbol(list, decl);
 	check_declaration(decl);
+	decl->definition = decl;
+	prev = decl->same_symbol;
+	if (prev && prev->definition) {
+		warning(decl->pos, "multiple definitions for function '%s'",
+			show_ident(decl->ident));
+		info(prev->definition->pos, " the previous one is here");
+	} else {
+		while (prev) {
+			prev->definition = decl;
+			prev = prev->same_symbol;
+		}
+	}
 	function_symbol_list = old_symbol_list;
 	if (function_computed_goto_list) {
 		if (!function_computed_target_list)
@@ -2282,6 +2295,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			}
 		}
 	} else if (base_type && base_type->type == SYM_FN) {
+		if (decl->next_id && decl->next_id->scope == decl->scope)
 		/* K&R argument declaration? */
 		if (lookup_type(token))
 			return parse_k_r_arguments(token, decl, list);
@@ -2309,6 +2323,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			}
 		}
 		check_declaration(decl);
+		if (decl->same_symbol)
+			decl->definition = decl->same_symbol->definition;
 
 		if (!match_op(token, ','))
 			break;
diff --git a/symbol.h b/symbol.h
index c4d7f28..e5369d2 100644
--- a/symbol.h
+++ b/symbol.h
@@ -155,6 +155,7 @@ struct symbol {
 			struct expression *initializer;
 			struct entrypoint *ep;
 			long long value;		/* Initial value */
+			struct symbol *definition;
 		};
 	};
 	union /* backend */ {
diff --git a/validation/context-named.c b/validation/context-named.c
index 58310e9..a896621 100644
--- a/validation/context-named.c
+++ b/validation/context-named.c
@@ -501,6 +501,8 @@ static void good_mixed_with_if(void)
  * check-name: Check -Wcontext with lock names
  *
  * check-error-start
+context-named.c:417:13: warning: multiple definitions for function 'good_fn2'
+context-named.c:408:13:  the previous one is here
 context-named.c:86:3: warning: context imbalance in 'warn_lock1': wrong count at exit
 context-named.c:86:3:    context 'TEST': wanted 0, got 1
 context-named.c:93:3: warning: context imbalance in 'warn_lock2': wrong count at exit
diff --git a/validation/definitions.c b/validation/definitions.c
new file mode 100644
index 0000000..fce7393
--- /dev/null
+++ b/validation/definitions.c
@@ -0,0 +1,12 @@
+static inline int f(void);
+static int g(void)
+{
+        return f();
+}
+static inline int f(void)
+{
+	return 0;
+}
+/*
+ * check-name: finding definitions
+ */
-- 
1.5.6.6

