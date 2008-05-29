From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 8/9] show required context in instruction output
Date: Thu, 29 May 2008 10:54:10 +0200
Message-ID: <20080529085518.170577000@sipsolutions.net>
References: <20080529085402.814224000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:45629 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbYE2I5B (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 04:57:01 -0400
Content-Disposition: inline; filename=009-show-context-required.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

Just eases debugging sparse/the context tracking itself.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 expression.c |    2 ++
 linearize.c  |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- sparse.orig/expression.c	2008-04-28 16:18:40.000000000 +0200
+++ sparse/expression.c	2008-04-28 16:18:40.000000000 +0200
@@ -648,6 +648,8 @@ static struct token *postfix_expression(
 					copy->in = c->in;
 					copy->out = c->out;
 					copy->exact = c->exact;
+					copy->token = c->token;
+					copy->in_fn = c->context;
 					add_ptr_list(&call->contexts, copy);
 
 					if (!c->token)
--- sparse.orig/linearize.c	2008-04-28 16:18:40.000000000 +0200
+++ sparse/linearize.c	2008-04-28 16:18:40.000000000 +0200
@@ -443,7 +443,7 @@ const char *show_instruction(struct inst
 			expression_str(insn->context_expr, ctxbuf, sizeof(ctxbuf));
 			buf += sprintf(buf, "%s, ", ctxbuf);
 		}
-		buf += sprintf(buf, "%d", insn->increment);
+		buf += sprintf(buf, "%d %d", insn->increment, insn->required);
 		break;
 	}
 	case OP_RANGE:

-- 

