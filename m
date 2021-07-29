Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE74C43214
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E833960C51
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhG2VVI (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233900AbhG2VVI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jul 2021 17:21:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E60F1604D7;
        Thu, 29 Jul 2021 21:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627593664;
        bh=nE32FZ8ab2v2n9Lf03BC/xIYv79pcx9aMJnX/IpA9Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhC5xKDNlG6pgR2+de21UkMKSuqlIpV+ImPOkIHXttFNoCcV6+mWeFlJiYFLU83I2
         vfAWu0U3GDTPVFNr31M+OfIC39t2tv1vJ9p/oETp015bGu2ZxB6m7WqRM6YISokdCI
         hiaLjyszAnehwUCp1PYBGqZKWsYHt13Rhwt7Ta0fxQxBPgKJHn1nxFwwyCVTsS/Aeq
         O6UKMM4bAjrcgAcpaZW2elamix7Mp6MQ1TUKSDniIvXYCu5WTCoEGpiTLO6/vaqTt9
         NBtiwuTz6H54A0fEI/ge1US6rcxBjjr+vmYk1+G17sjAjOzfCS2rljnMr46pJ5sXRC
         SPbF+A23pH26g==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] scheck: fix type of operands in casts
Date:   Thu, 29 Jul 2021 23:20:54 +0200
Message-Id: <20210729212054.34327-6-lucvoo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729212054.34327-1-lucvoo@kernel.org>
References: <20210729212054.34327-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Casts were using the target type for their operands.

Fix this by using the new helper mkivar() for them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scheck.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/scheck.c b/scheck.c
index 07b15a0600e3..bb052d97996d 100644
--- a/scheck.c
+++ b/scheck.c
@@ -165,18 +165,16 @@ static void icmp(Btor *btor, struct instruction *insn)
 
 static void unop(Btor *btor, struct instruction *insn)
 {
-	BoolectorSort s = get_sort(btor, insn->type, insn->pos);
-	BoolectorNode *t, *a;
+	pseudo_t src = insn->src;
+	BoolectorNode *t;
 
-	a = mkvar(btor, s, insn->src1);
-	if (!a)
-		return;
 	switch (insn->opcode) {
-	case OP_NEG:	t = boolector_neg(btor, a); break;
-	case OP_NOT:	t = boolector_not(btor, a); break;
-	case OP_SEXT:	t = sext(btor, insn, a); break;
-	case OP_ZEXT:	t = zext(btor, insn, a); break;
-	case OP_TRUNC:	t = slice(btor, insn, a); break;
+	case OP_SEXT:	t = sext(btor, insn, mkivar(btor, insn, src)); break;
+	case OP_ZEXT:	t = zext(btor, insn, mkivar(btor, insn, src)); break;
+	case OP_TRUNC:	t = slice(btor, insn, mkivar(btor, insn, src)); break;
+
+	case OP_NEG:	t = boolector_neg(btor, mktvar(btor, insn, src)); break;
+	case OP_NOT:	t = boolector_not(btor, mktvar(btor, insn, src)); break;
 	default:
 		fprintf(stderr, "unsupported insn: %s\n", show_instruction(insn));
 		return;
-- 
2.32.0

