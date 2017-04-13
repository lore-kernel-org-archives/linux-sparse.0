From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/8] add helper add_load_dominators()
Date: Thu, 13 Apr 2017 18:55:45 +0200
Message-ID: <20170413165551.2785-3-luc.vanoostenryck@gmail.com>
References: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34932 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbdDMQ4B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Apr 2017 12:56:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so9375489wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 13 Apr 2017 09:56:00 -0700 (PDT)
In-Reply-To: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 12 ++++++++++++
 flow.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/flow.c b/flow.c
index 50507a5e7..25a5bffbe 100644
--- a/flow.c
+++ b/flow.c
@@ -417,6 +417,18 @@ void add_dominator(struct pseudo_list **phi_list, struct instruction *insn,
 	use_pseudo(insn, phi, add_pseudo(phi_list, phi));
 }
 
+struct pseudo_list *add_load_dominators(struct instruction *insn, struct instruction_list *doms,
+	struct ident *ident)
+{
+	struct pseudo_list *phi_list = NULL;
+	struct instruction *dom;
+
+	FOR_EACH_PTR(doms, dom) {
+		add_dominator(&phi_list, insn, dom, ident);
+	} END_FOR_EACH_PTR(dom);
+	return phi_list;
+}
+
 /*
  * We should probably sort the phi list just to make it easier to compare
  * later for equality. 
diff --git a/flow.h b/flow.h
index 800585547..a6d0881c2 100644
--- a/flow.h
+++ b/flow.h
@@ -39,6 +39,7 @@ void check_access(struct instruction *insn);
 void convert_load_instruction(struct instruction *, pseudo_t);
 void rewrite_load_instruction(struct instruction *, struct pseudo_list *);
 void add_dominator(struct pseudo_list **, struct instruction *, struct instruction *, struct ident*);
+struct pseudo_list *add_load_dominators(struct instruction *, struct instruction_list *, struct ident*);
 int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom, int local);
 
 extern void clear_liveness(struct entrypoint *ep);
-- 
2.12.0

