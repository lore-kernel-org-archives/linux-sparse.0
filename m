From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [FAIL 2/5] inspect: Show context information
Date: Wed, 17 Feb 2016 10:51:32 +0100
Message-ID: <1455702695-6199-3-git-send-email-daniel.wagner@bmw-carit.de>
References: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>
List-Id: linux-sparse@vger.kernel.org

Add the function context attributes and the context instruction
to the model.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 ast-inspect.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/ast-inspect.c b/ast-inspect.c
index 24d4a4a..4502575 100644
--- a/ast-inspect.c
+++ b/ast-inspect.c
@@ -83,7 +83,10 @@ void inspect_statement(AstNode *node)
 			ast_append_child(node, "ret_value:", stmt->ret_value, inspect_expression);
 			ast_append_child(node, "ret_target:", stmt->ret_target, inspect_symbol);
 			break;
-
+		case STMT_CONTEXT:
+			ast_append_child(node, "expression:", stmt->expression, inspect_expression);
+			ast_append_child(node, "context:", stmt->context, inspect_expression);
+			break;
 		default:
 			break;
 	}
@@ -96,6 +99,27 @@ void inspect_statement_list(AstNode *node)
 }
 
 
+static const char *unnamed_context = "<unnamed>";
+
+static const char *context_name(struct context *context)
+{
+	if (context->context && context->context->symbol_name)
+		return show_ident(context->context->symbol_name);
+	return unnamed_context;
+}
+
+static void inspect_context(AstNode *node)
+{
+	struct context *context = node->ptr;
+	node->text = g_strdup_printf("%s %s: in %d out %d", node->text,
+				context_name(context), context->in, context->out);
+}
+
+static void inspect_context_list(AstNode *node)
+{
+	inspect_ptr_list(node, "context_list", inspect_context);
+}
+
 static const char *symbol_type_name(enum type type)
 {
 	static const char *type_name[] = {
@@ -134,6 +158,7 @@ void inspect_symbol(AstNode *node)
 		case NS_PREPROCESSOR:
 			break;
 		default:
+			ast_append_child(node, "contexts:", sym->ctype.contexts, inspect_context_list);
 			ast_append_child(node, "arguments:", sym->arguments, inspect_symbol_list);
 			ast_append_child(node, "symbol_list:", sym->symbol_list, inspect_symbol_list);
 			ast_append_child(node, "stmt:", sym->stmt, inspect_statement);
-- 
2.5.0
