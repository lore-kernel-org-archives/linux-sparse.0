Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7DC4361A
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47465229C4
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 16:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgLDQeB (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgLDQeA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Dec 2020 11:34:00 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76777C0613D1
        for <linux-sparse@vger.kernel.org>; Fri,  4 Dec 2020 08:33:20 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id lt17so9573452ejb.3
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 08:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7ERN8XxdyPoj4BQtDlcKWiR0oj9q3laAQLTl+aMK7A=;
        b=b06WPd79ypKB4zGakboq9TKg1OUORgPKiHuPlkXQjZN7R8Qmp1XJ6mhkV2V2zgYVpP
         Uxtjc0oKFsw1zdh3DCMsUcmHiaZhC1hX2zqsm/5ohgD0kyFpEGYsx8s5TS9brh/cXyXU
         ifMvh+jW2Z6u6DaqQa+tmNUp4MjDKsdnszHnIydxSeH9p28Qc/M//dmOpBVNYgMhE6uG
         iEqx/Rug/ehCPnbDSLjSL6TwfEVJGxhLSlp3i7sOak82hqT+aQDbqlx8ioPsZ7geHdTy
         wsvtB1DX0QxYrDvDAHZ4NmNuN500cONNtF6DGRUp/+prDbYwMM90vh2y7inZQxShhRi7
         hOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7ERN8XxdyPoj4BQtDlcKWiR0oj9q3laAQLTl+aMK7A=;
        b=s5qz4xBeKCk/BTQT7LkXZ/QtJgZhv0gxF2vNJi+z+Xk03J4SgpyPBZDOhMR4ygL/cL
         Iax9LpyTykxwR10Wu/SZ1OklmVEWJ/stcz4bXm96kq6iCiTJRlYgybDcg5kgf0ZAOw3r
         sSI7fFomwzeuj+E9lwEgJLoZCQvwepYX/b3XFOFcALfk4dWXgpJ0sncbUVRwcGk7kHt8
         lLcsHx3r4s1WwjwLlZpwOA5CTT0mEp9aeRY/0oUPu7gJ0DNK2KjgFWS4AFqGPCKq37oy
         3Qkdt50N37i4pw3JTiPR2fWb6ryv8lWLP80FVYPtaMt0XdZ9Qts/k+6Y3IBlrG+GdfMd
         Br6Q==
X-Gm-Message-State: AOAM533Yc06TfOxkKvDQHi2dYWbPga5mbvyPIDbtJF5lsP6gC0H8hCFZ
        7Bj0wpjhief3HsLqsfagijhnyGVtps4=
X-Google-Smtp-Source: ABdhPJzwH4hztZe35L7IzBdRfQW3zf6QtsLX99vRdxB2c7lVOi44pYcUboJPr7Mgp4KE7XvEgFg/lQ==
X-Received: by 2002:a17:906:b309:: with SMTP id n9mr7904671ejz.365.1607099598639;
        Fri, 04 Dec 2020 08:33:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:8183:34c1:3ce4:9984])
        by smtp.gmail.com with ESMTPSA id d13sm3279817ejc.44.2020.12.04.08.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:33:17 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] experimental: code sinking
Date:   Fri,  4 Dec 2020 17:33:15 +0100
Message-Id: <20201204163315.68538-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A lot of the false 'context imbalance' warnings are caused by
a potential jump-threading being blocked between 2 conditional
branches on the same condition because the second CBR belong
to a non-empty BB. Often the offending instructions can be moved
to some other BB, sometimes even with some added advantages.

This patch help a bit with these false warnings by doing a limited
form of code sinking: blocking instructions with a single user
are moved in the BB where they're used, possibly making the
original BB empty and thus making the jump-threading possible.

Note: It's not the intention to use the patch as is.
      Ideally, it should first be checked if the original BB
      can be made empty before moving the instructions around,
      but this should be coordinated with other ways of moving
      these instructions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile    |  1 +
 code-sink.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 optimize.c  |  2 ++
 optimize.h  |  3 ++
 4 files changed, 98 insertions(+)
 create mode 100644 code-sink.c

diff --git a/Makefile b/Makefile
index 313664467151..5ba54659f625 100644
--- a/Makefile
+++ b/Makefile
@@ -35,6 +35,7 @@ LIB_OBJS :=
 LIB_OBJS += allocate.o
 LIB_OBJS += builtin.o
 LIB_OBJS += char.o
+LIB_OBJS += code-sink.o
 LIB_OBJS += compat-$(OS).o
 LIB_OBJS += cse.o
 LIB_OBJS += dissect.o
diff --git a/code-sink.c b/code-sink.c
new file mode 100644
index 000000000000..566ddec028a0
--- /dev/null
+++ b/code-sink.c
@@ -0,0 +1,92 @@
+#include "optimize.h"
+#include "lib.h"
+#include "linearize.h"
+
+
+static inline struct instruction *get_user(pseudo_t p)
+{
+	struct pseudo_user *pu;
+
+	FOR_EACH_PTR(p->users, pu) {
+		if (!pu)
+			continue;
+		return pu->insn;
+	} END_FOR_EACH_PTR(pu);
+	return NULL;
+}
+
+static bool sink_insn(struct instruction *insn, struct basic_block *bb)
+{
+	struct instruction *curr;
+
+	FOR_EACH_PTR(bb->insns, curr) {
+		if (!curr->bb)
+			continue;
+		if (curr->opcode == OP_PHI)
+			continue;
+		INSERT_CURRENT(insn, curr);
+		insn->bb = bb;
+		return true;
+	} END_FOR_EACH_PTR(curr);
+	return false;
+}
+
+static int code_sink_bb(struct basic_block *bb)
+{
+	struct instruction *insn;
+	int changed = 0;
+
+	FOR_EACH_PTR_REVERSE(bb->insns, insn) {
+		struct instruction *user;
+		pseudo_t target;
+
+		if (!insn->bb)
+			continue;
+		switch (insn->opcode) {
+		case OP_BINARY ... OP_BINCMP_END:
+		case OP_UNOP ... OP_UNOP_END:
+		case OP_SYMADDR:
+		case OP_SLICE:
+		case OP_SEL: case OP_FMADD:
+		case OP_LABEL: case OP_SETVAL: case OP_SETFVAL:
+			break;
+		case OP_CBR:
+		case OP_INLINED_CALL:
+		case OP_NOP:
+			continue;
+		default:
+			continue;
+		}
+
+		target = insn->target;
+		if (!one_use(target))
+			continue;
+		user = get_user(target);
+		if (!user || !user->bb || user->bb == bb)
+			continue;
+		if (!sink_insn(insn, user->bb))
+			continue;
+		DELETE_CURRENT_PTR(insn);
+		changed = 1;
+	} END_FOR_EACH_PTR_REVERSE(insn);
+	return changed;
+}
+
+int code_sink(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+	int changed = 0;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		struct instruction *last;
+
+		if (!bb->ep)
+			continue;
+		last = last_instruction(bb->insns);
+		switch (last->opcode) {
+		case OP_CBR:
+			changed |= code_sink_bb(bb);
+		}
+	} END_FOR_EACH_PTR(bb);
+	return changed;
+}
diff --git a/optimize.c b/optimize.c
index 3351e67b9d5e..b652b0e76d2a 100644
--- a/optimize.c
+++ b/optimize.c
@@ -105,6 +105,8 @@ repeat:
 		pack_basic_blocks(ep);
 		if (repeat_phase & REPEAT_CFG_CLEANUP)
 			cleanup_cfg(ep);
+		if (code_sink(ep))
+			repeat_phase |= REPEAT_CSE;
 	} while (repeat_phase);
 
 	vrfy_flow(ep);
diff --git a/optimize.h b/optimize.h
index 31e2cf081704..d9ac9cd48ea2 100644
--- a/optimize.h
+++ b/optimize.h
@@ -6,4 +6,7 @@ struct entrypoint;
 /* optimize.c */
 void optimize(struct entrypoint *ep);
 
+/* sink.c */
+int code_sink(struct entrypoint *ep);
+
 #endif
-- 
2.29.2

