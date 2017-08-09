From: Christopher Li <sparse@chrisli.org>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Wed, 9 Aug 2017 15:22:38 -0400
Message-ID: <CANeU7Qk37J8WTVmzDhzjCbpmJ6cf59LNB6sX6ncRFHP=wvJFQw@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
 <20170807184653.a6xtjfbutnsnecnf@ltop.local> <CANeU7Qm3JuMq_0OMiNxgcLKMkO8rhLNcWF3yeXqORZPpbvLUmg@mail.gmail.com>
 <CACXZuxeTzEGNME0WV8S9Gbe-Vbu--pq6XF4sH4YEKPD_gysiNA@mail.gmail.com>
 <CACXZuxfrgT1Q9X5B7iw=+zYA7bO4uchBo8txqsqnBw-xf+2C_A@mail.gmail.com>
 <CANeU7QmpT1-zEXmxtesaicD+W_dwMMxODno7og+5C6tuBFimpQ@mail.gmail.com> <CACXZuxcWQBtjH=szWHOzjU9D1+t3E+Bd-2XK=+e_Fx9rO29jvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34631 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHITWj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:22:39 -0400
Received: by mail-yw0-f175.google.com with SMTP id s143so46005171ywg.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:22:39 -0700 (PDT)
In-Reply-To: <CACXZuxcWQBtjH=szWHOzjU9D1+t3E+Bd-2XK=+e_Fx9rO29jvg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 2:47 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Thread 1 "test-inspect" received signal SIGSEGV, Segmentation fault.
> ast_iter_n_children (tree_model=0x725400, iter=0x0) at ast-model.c:404

Err, iter == NULL.

The function comment said it all. if iter == NULL, should return the
root node's children number.

Can you try the following one line change?
I can only verify it compiles. But I have no way to test it.

I also totally forget how this tree view model works now.
Let's hope that fix it.

Thanks

Chris

diff --git a/ast-model.c b/ast-model.c
index 704c487..cbfdc1f 100644
--- a/ast-model.c
+++ b/ast-model.c
@@ -401,7 +401,7 @@ static gint
 ast_iter_n_children (GtkTreeModel *tree_model,
                           GtkTreeIter  *iter)
 {
-       AstNode  *node = iter->user_data;
+       AstNode  *node = iter ? iter->user_data : AST_NODE(tree_model);

        inspect_child_node(node);
        return node->childnodes->len;
