From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] graph: do not scan removed instructions
Date: Tue,  7 Nov 2017 11:54:30 +0100
Message-ID: <20171107105430.4810-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:57148 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754677AbdKGK4j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Nov 2017 05:56:39 -0500
Received: by mail-wm0-f68.google.com with SMTP id z3so2863801wme.5
        for <linux-sparse@vger.kernel.org>; Tue, 07 Nov 2017 02:56:38 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 graph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/graph.c b/graph.c
index 8cbc22027..c9af9a580 100644
--- a/graph.c
+++ b/graph.c
@@ -130,6 +130,8 @@ static void graph_calls(struct entrypoint *ep, int internal)
 			continue;
 
 		FOR_EACH_PTR(bb->insns, insn) {
+			if (!insn->bb)
+				continue;
 			if (insn->opcode == OP_CALL &&
 			    internal == !(insn->func->sym->ctype.modifiers & MOD_EXTERN)) {
 
-- 
2.14.0

