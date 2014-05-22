From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] Fix offsets in anonymous unions
Date: Thu, 22 May 2014 14:22:57 +0100
Message-ID: <f6d65cc35d3627885e7a1c89e70a48c3368d4f66.1400764815.git.john@keeping.me.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from jackal.aluminati.org ([72.9.247.210]:57716 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbaEVNXW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 May 2014 09:23:22 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: John Keeping <john@keeping.me.uk>

Commit 38d1124 (Fix error at anoymous unions, 2014-04-03) says:

    Ok, this fixes the warning, but we seem to still mess up the actual
    initializer. It looks like some later phase gets the offset wrong, so
    when we lay things out in memory, we'll put things at offset zero
    (which is right for your test-case, but not if there was something
    before that anonymous union).

This is because in evaluate.c::convert_ident() the offset of a member of
the inner union is set to the offset within the union, not the overall
offset.

Earlier, the correct offset has been calculated for check_designators()
by find_identifier() so by setting the offset there we end up using the
correct offset later on.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
I'm pretty sure this is the wrong fix and I suspect it breaks some other
scenarios like mixing designators and plain initializers, but I've run
out of time to investigate this further and hopefully the correct patch
will be obvious to someone who knows the code better...

 evaluate.c              | 3 +--
 validation/anon-union.c | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 7ce8c55..cb58ccc 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2223,9 +2223,7 @@ static void convert_index(struct expression *e)
 static void convert_ident(struct expression *e)
 {
 	struct expression *child = e->ident_expression;
-	struct symbol *sym = e->field;
 	e->type = EXPR_POS;
-	e->init_offset = sym->offset;
 	e->init_nr = 1;
 	e->init_expr = child;
 }
@@ -2328,6 +2326,7 @@ static struct expression *check_designators(struct expression *e,
 				break;
 			}
 			e->field = e->ctype = ctype;
+			e->init_offset = offset;
 			last = e;
 			if (!e->ident_expression) {
 				err = "invalid";
diff --git a/validation/anon-union.c b/validation/anon-union.c
index 487f957..8670868 100644
--- a/validation/anon-union.c
+++ b/validation/anon-union.c
@@ -1,10 +1,11 @@
 struct s {
+        int type;
         union {
                 int val;
         };
 };
 
-static struct s foo = { .val = 5, };
+static struct s foo = { .type = 42, .val = 5, };
 /*
  * check-name: test anonymous union initializer
  */
-- 
2.0.0.rc2.4.g1dc51c6

