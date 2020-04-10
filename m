From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE PATCH 4/5] extract add_jump() from add_goto()
Date: Fri, 10 Apr 2020 20:49:17 +0200
Message-ID: <20200410184918.64692-5-luc.vanoostenryck@gmail.com>
References: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37942 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJStd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Apr 2020 14:49:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id f20so3612761wmh.3
        for <linux-sparse@vger.kernel.org>; Fri, 10 Apr 2020 11:49:32 -0700 (PDT)
In-Reply-To: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

add_goto() uses the active BB (and automaticallydesactive
it just after). This is fine at linearization but is not
what is needed at later stages.

So, extract the gist into a separate helper: add_jump().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/linearize.c b/linearize.c
index 4e9f9b3693e9..a2cde941ce18 100644
--- a/linearize.c
+++ b/linearize.c
@@ -633,16 +633,21 @@ static void finish_block(struct entrypoint *ep)
 		ep->active = NULL;
 }
 
+static void add_jump(struct basic_block *src, struct basic_block *dst)
+{
+	struct instruction *br = alloc_instruction(OP_BR, 0);
+	br->bb_true = dst;
+	add_bb(&dst->parents, src);
+	add_bb(&src->children, dst);
+	br->bb = src;
+	add_instruction(&src->insns, br);
+}
+
 static void add_goto(struct entrypoint *ep, struct basic_block *dst)
 {
 	struct basic_block *src = ep->active;
 	if (bb_reachable(src)) {
-		struct instruction *br = alloc_instruction(OP_BR, 0);
-		br->bb_true = dst;
-		add_bb(&dst->parents, src);
-		add_bb(&src->children, dst);
-		br->bb = src;
-		add_instruction(&src->insns, br);
+		add_jump(src, dst);
 		ep->active = NULL;
 	}
 }
-- 
2.26.0
