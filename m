From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 15/16] Show required context in instruction output
Date: Fri, 19 Dec 2008 01:35:29 +0300
Message-ID: <20081218223514.23692.77595.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:18638 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973AbYLRW0Q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 17:26:16 -0500
Received: by ey-out-2122.google.com with SMTP id 22so46429eye.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 14:26:14 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Johannes Berg <johannes@sipsolutions.net>

Just eases debugging sparse/the context tracking itself.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 expression.c |    2 ++
 linearize.c  |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/expression.c b/expression.c
index 198816b..8c4451d 100644
--- a/expression.c
+++ b/expression.c
@@ -648,6 +648,8 @@ static struct token *postfix_expression(struct token *token, struct expression *
 					copy->in = c->in;
 					copy->out = c->out;
 					copy->exact = c->exact;
+					copy->token = c->token;
+					copy->in_fn = c->context;
 					add_ptr_list(&call->contexts, copy);
 
 					if (!c->token)
diff --git a/linearize.c b/linearize.c
index 808b1bc..c9fe922 100644
--- a/linearize.c
+++ b/linearize.c
@@ -445,7 +445,7 @@ const char *show_instruction(struct instruction *insn)
 			expression_str(insn->context_expr, ctxbuf, sizeof(ctxbuf));
 			buf += sprintf(buf, "%s, ", ctxbuf);
 		}
-		buf += sprintf(buf, "%d", insn->increment);
+		buf += sprintf(buf, "%d %d", insn->increment, insn->required);
 		break;
 	}
 	case OP_RANGE:

