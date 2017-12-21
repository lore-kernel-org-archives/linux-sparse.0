From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix: evaluate_dereference() unexamined base type
Date: Thu, 21 Dec 2017 01:30:17 +0100
Message-ID: <20171221003017.57211-3-luc.vanoostenryck@gmail.com>
References: <20171221003017.57211-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43048 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756563AbdLUAaY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:30:24 -0500
Received: by mail-wm0-f66.google.com with SMTP id n138so12995655wmg.2
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:30:23 -0800 (PST)
In-Reply-To: <20171221003017.57211-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Examination of a pointer type doesn't examine the corresponding
base type (this base type may not yet be complete). So, this
examination must be done later, when the base type is needed.

However, in some cases it's possible to call evaluate_dereference()
while the base type is still unexamined.

Fix this by adding the missing examine_symbol_type() on the base type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                               | 1 +
 validation/linear/deref-ptr-ptr.c        | 1 -
 validation/linear/unexamined-base-type.c | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 6b3e2c257..85f1b21bb 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1778,6 +1778,7 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 
 	node = alloc_symbol(expr->pos, SYM_NODE);
 	target = ctype->ctype.base_type;
+	examine_symbol_type(target);
 
 	switch (ctype->type) {
 	default:
diff --git a/validation/linear/deref-ptr-ptr.c b/validation/linear/deref-ptr-ptr.c
index 022595d78..963acd36c 100644
--- a/validation/linear/deref-ptr-ptr.c
+++ b/validation/linear/deref-ptr-ptr.c
@@ -6,7 +6,6 @@ char *foo(char **pfmt)
 /*
  * check-name: deref-ptr-ptr
  * check-command: test-linearize -m64 -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-excludes: load[^.]
  * check-output-contains: load\.
diff --git a/validation/linear/unexamined-base-type.c b/validation/linear/unexamined-base-type.c
index a138ba132..96aee3f0e 100644
--- a/validation/linear/unexamined-base-type.c
+++ b/validation/linear/unexamined-base-type.c
@@ -28,7 +28,6 @@ static void bar(struct s *d, struct s *s1, struct s *s2)
  *		                   ^^^		!! WRONG !!
  *		and.32      %r6 <- %r5, $1
  *		ret.32      %r6
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load[^.]
-- 
2.15.0

