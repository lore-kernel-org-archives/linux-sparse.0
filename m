From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix: evaluate_dereference() unexamined base type
Date: Sat, 25 Nov 2017 10:31:15 +0100
Message-ID: <20171125093115.95791-3-luc.vanoostenryck@gmail.com>
References: <20171125093115.95791-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33177 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdKYJdk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 25 Nov 2017 04:33:40 -0500
Received: by mail-wr0-f194.google.com with SMTP id 55so5889580wrx.0
        for <linux-sparse@vger.kernel.org>; Sat, 25 Nov 2017 01:33:40 -0800 (PST)
In-Reply-To: <20171125093115.95791-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Examination of a pointer type doesn't examine the corresponding base type
(this base type maybe not yet be complete).
The examination of thz base type must thus be done later.

However, in some cases (maybe only when typeof() is involved) it's
possible to call evaluate_dereference() while the base type is still
unexamined.

Fix this by adding the missing examine_symbol_type() on the base type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                                | 2 +-
 validation/bugs/unexamined-base-type-00.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 4bca13542..bb128ecd8 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1777,7 +1777,7 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 		ctype = ctype->ctype.base_type;
 
 	node = alloc_symbol(expr->pos, SYM_NODE);
-	target = ctype->ctype.base_type;
+	target = examine_symbol_type(ctype->ctype.base_type);
 
 	switch (ctype->type) {
 	default:
diff --git a/validation/bugs/unexamined-base-type-00.c b/validation/bugs/unexamined-base-type-00.c
index 2032599b7..7749a9def 100644
--- a/validation/bugs/unexamined-base-type-00.c
+++ b/validation/bugs/unexamined-base-type-00.c
@@ -21,7 +21,6 @@ static int foo(struct s *s)
  *		cast.32     %r5 <- (0) %r4	; !! WRONG
  *		and.32      %r6 <- %r5, $1
  *		ret.32      %r6
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load[^.]
-- 
2.15.0

