From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 1/2] test-inspect: handle special case iter==NULL
Date: Thu, 10 Aug 2017 17:02:03 -0400
Message-ID: <CANeU7QnP1afR6ey0Zu1tkoGFGYcCWGaA-Oc1+mbDJdHNSTk1qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37998 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbdHJVCF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 17:02:05 -0400
Received: by mail-yw0-f196.google.com with SMTP id p68so1170044ywg.5
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 14:02:05 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

GtkTreeView has this special case that iter==NULL means the
root node.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 ast-model.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ast-model.c b/ast-model.c
index 63d2762..cbd82db 100644
--- a/ast-model.c
+++ b/ast-model.c
@@ -401,7 +401,8 @@ static gint
 ast_iter_n_children (GtkTreeModel *tree_model,
                           GtkTreeIter  *iter)
 {
- AstNode  *node = iter->user_data;
+ AstNode  *node = iter ? iter->user_data
+ : AST_NODE(tree_model);

  inspect_child_node(node);
  return node->childnodes->len;
-- 
2.13.3
