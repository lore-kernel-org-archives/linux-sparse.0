From: Pekka Enberg <penberg@kernel.org>
Subject: [RFC/PATCH 1/2] sparse, llvm: Make function declaration accessible to backend
Date: Wed,  1 Feb 2012 11:55:51 +0200
Message-ID: <1328090152-28299-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46391 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753405Ab2BAJ4B (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 04:56:01 -0500
Received: by lagu2 with SMTP id u2so546456lag.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Feb 2012 01:55:59 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Pekka Enberg <penberg@kernel.org>

From: Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Aug 30, 2011 at 10:43 AM, Jeff Garzik <jeff@garzik.org> wrote:
> * if someone knows how to access a function declaration, I can solve the
> varargs problem

Hmm. Right now we do not have access to the function declaration at
linearize time. We've checked that the arguments match, and we've cast
the arguments to the right types (evaluate.c), so the thinking was
that you just use the arguments as-is.

But if llvm needs the declaration of a function, we'd need to squirrel it away.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
[ penberg@kernel.org: Fix validation/context.c breakage. ]
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 linearize.c |    8 ++++++++
 linearize.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/linearize.c b/linearize.c
index 1899978..7d57474 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1195,6 +1195,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	struct instruction *insn = alloc_typed_instruction(OP_CALL, expr->ctype);
 	pseudo_t retval, call;
 	struct ctype *ctype = NULL;
+	struct symbol *fntype;
 	struct context *context;
 
 	if (!expr->ctype) {
@@ -1212,6 +1213,13 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	if (fn->ctype)
 		ctype = &fn->ctype->ctype;
 
+	fntype = fn->ctype;
+	if (fntype) {
+		if (fntype->type == SYM_NODE)
+			fntype = fntype->ctype.base_type;
+	}
+	insn->fntype = fntype;
+
 	if (fn->type == EXPR_PREOP) {
 		if (fn->unop->type == EXPR_SYMBOL) {
 			struct symbol *sym = fn->unop->symbol;
diff --git a/linearize.h b/linearize.h
index 424ba97..61fbd83 100644
--- a/linearize.h
+++ b/linearize.h
@@ -116,6 +116,7 @@ struct instruction {
 		struct /* call */ {
 			pseudo_t func;
 			struct pseudo_list *arguments;
+			struct symbol *fntype;
 		};
 		struct /* context */ {
 			int increment;
-- 
1.7.6.4

