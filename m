From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 4/4] V2 fix warnings report by selfcheck
Date: Mon, 17 Jul 2017 22:56:38 -0400
Message-ID: <CANeU7QmR-XJ2AiuXKiRgh4Ytf30LDDbYd8_qQoq3qXiPasDawg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35373 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbdGRC4j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 22:56:39 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so987204pfq.2
        for <linux-sparse@vger.kernel.org>; Mon, 17 Jul 2017 19:56:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 ast-model.c | 2 +-
 ast-view.c  | 3 ++-
 lib.h       | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ast-model.c b/ast-model.c
index 704c487..63d2762 100644
--- a/ast-model.c
+++ b/ast-model.c
@@ -59,7 +59,7 @@ AstNode* ast_nth_child(AstNode *node, int n)
  inspect_child_node(node);

  if (n >= node->childnodes->len)
- return FALSE;
+ return NULL;
  return g_array_index(node->childnodes, AstNode *, n);
 }

diff --git a/ast-view.c b/ast-view.c
index c2b3963..22aba11 100644
--- a/ast-view.c
+++ b/ast-view.c
@@ -2,8 +2,9 @@
 #include <stdlib.h>
 #include "ast-model.h"
 #include "ast-inspect.h"
+#include "ast-view.h"

-GtkWidget *
+static GtkWidget *
 create_view_and_model (void *ptr)
 {
  GtkTreeViewColumn   *text;
diff --git a/lib.h b/lib.h
index 3f8d361..c90e0e3 100644
--- a/lib.h
+++ b/lib.h
@@ -150,6 +150,7 @@ extern int fdump_linearize;
 extern unsigned long long fmemcpy_max_count;

 extern int arch_m64;
+extern int arch_msize_long;
 extern int arch_big_endian;

 extern void declare_builtin_functions(void);
-- 
2.9.4
