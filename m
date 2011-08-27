From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] Make 'linearize_iterator()' helper function
Date: Sat, 27 Aug 2011 14:27:19 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1108271426450.18733@i5.linux-foundation.org>
References: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:60269 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab1H0V1W (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 17:27:22 -0400
Received: by pzk37 with SMTP id 37so6219152pzk.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 14:27:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>
Cc: Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Aug 2011 11:30:31 -0700
Subject: [PATCH 1/3] Make 'linearize_iterator()' helper function

Rather than do it in that huge 'linearize_statement()' function, split
out the iterator case.  Avoids one level of indentation, and makes for
simpler and more straightforward functions.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 linearize.c |   85 +++++++++++++++++++++++++++++++---------------------------
 1 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/linearize.c b/linearize.c
index 1899978c1d08..2decd5300859 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1843,6 +1843,49 @@ static pseudo_t linearize_declaration(struct entrypoint *ep, struct statement *s
 	return VOID;
 }
 
+static pseudo_t linearize_iterator(struct entrypoint *ep, struct statement *stmt)
+{
+	struct statement  *pre_statement = stmt->iterator_pre_statement;
+	struct expression *pre_condition = stmt->iterator_pre_condition;
+	struct statement  *statement = stmt->iterator_statement;
+	struct statement  *post_statement = stmt->iterator_post_statement;
+	struct expression *post_condition = stmt->iterator_post_condition;
+	struct basic_block *loop_top, *loop_body, *loop_continue, *loop_end;
+
+	concat_symbol_list(stmt->iterator_syms, &ep->syms);
+	linearize_statement(ep, pre_statement);
+
+	loop_body = loop_top = alloc_basic_block(ep, stmt->pos);
+	loop_continue = alloc_basic_block(ep, stmt->pos);
+	loop_end = alloc_basic_block(ep, stmt->pos);
+
+	/* An empty post-condition means that it's the same as the pre-condition */
+	if (!post_condition) {
+		loop_top = alloc_basic_block(ep, stmt->pos);
+		set_activeblock(ep, loop_top);
+	}
+
+	if (pre_condition)
+			linearize_cond_branch(ep, pre_condition, loop_body, loop_end);
+
+	bind_label(stmt->iterator_continue, loop_continue, stmt->pos);
+	bind_label(stmt->iterator_break, loop_end, stmt->pos);
+
+	set_activeblock(ep, loop_body);
+	linearize_statement(ep, statement);
+	add_goto(ep, loop_continue);
+
+	set_activeblock(ep, loop_continue);
+	linearize_statement(ep, post_statement);
+	if (!post_condition)
+		add_goto(ep, loop_top);
+	else
+		linearize_cond_branch(ep, post_condition, loop_top, loop_end);
+	set_activeblock(ep, loop_end);
+
+	return VOID;
+}
+
 pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 {
 	struct basic_block *bb;
@@ -2049,46 +2092,8 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 		break;
 	}
 
-	case STMT_ITERATOR: {
-		struct statement  *pre_statement = stmt->iterator_pre_statement;
-		struct expression *pre_condition = stmt->iterator_pre_condition;
-		struct statement  *statement = stmt->iterator_statement;
-		struct statement  *post_statement = stmt->iterator_post_statement;
-		struct expression *post_condition = stmt->iterator_post_condition;
-		struct basic_block *loop_top, *loop_body, *loop_continue, *loop_end;
-
-		concat_symbol_list(stmt->iterator_syms, &ep->syms);
-		linearize_statement(ep, pre_statement);
-
- 		loop_body = loop_top = alloc_basic_block(ep, stmt->pos);
- 		loop_continue = alloc_basic_block(ep, stmt->pos);
- 		loop_end = alloc_basic_block(ep, stmt->pos);
- 
-		/* An empty post-condition means that it's the same as the pre-condition */
-		if (!post_condition) {
-			loop_top = alloc_basic_block(ep, stmt->pos);
-			set_activeblock(ep, loop_top);
-		}
-
-		if (pre_condition) 
- 			linearize_cond_branch(ep, pre_condition, loop_body, loop_end);
-
-		bind_label(stmt->iterator_continue, loop_continue, stmt->pos);
-		bind_label(stmt->iterator_break, loop_end, stmt->pos);
-
-		set_activeblock(ep, loop_body);
-		linearize_statement(ep, statement);
-		add_goto(ep, loop_continue);
