From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] add an implicit __builtin_unreachable() for __noreturn
Date: Wed, 18 Mar 2020 18:31:18 +0100
Message-ID: <20200318173120.63939-4-luc.vanoostenryck@gmail.com>
References: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33485 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgCRRb3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Mar 2020 13:31:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so31485683wrd.0
        for <linux-sparse@vger.kernel.org>; Wed, 18 Mar 2020 10:31:27 -0700 (PDT)
In-Reply-To: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The semantic of a __noreturn function is that ... it doesn't return.

So, insert an instruction OP_UNREACH after calls to such functions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                               | 10 ++++++++++
 validation/linear/noreturn-unreachable0.c |  1 -
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index f1e538e23ae1..19c284c4a456 100644
--- a/linearize.c
+++ b/linearize.c
@@ -657,6 +657,13 @@ static void add_one_insn(struct entrypoint *ep, struct instruction *insn)
 	}
 }
 
+static void add_unreachable(struct entrypoint *ep)
+{
+	struct instruction *insn = alloc_instruction(OP_UNREACH, 0);
+	add_one_insn(ep, insn);
+	ep->active = NULL;
+}
+
 static void set_activeblock(struct entrypoint *ep, struct basic_block *bb)
 {
 	if (!bb_terminated(ep->active))
@@ -1551,6 +1558,9 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 				add_one_insn(ep, insn);
 			}
 		} END_FOR_EACH_PTR(context);
+
+		if (ctype->modifiers & MOD_NORETURN)
+			add_unreachable(ep);
 	}
 
 	return retval;
diff --git a/validation/linear/noreturn-unreachable0.c b/validation/linear/noreturn-unreachable0.c
index b76319458e96..13fddc8cfd40 100644
--- a/validation/linear/noreturn-unreachable0.c
+++ b/validation/linear/noreturn-unreachable0.c
@@ -9,7 +9,6 @@ int foo(void)
 /*
  * check-name: noreturn-unreachable0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-start
 foo:
-- 
2.25.1
