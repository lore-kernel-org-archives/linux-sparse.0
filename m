Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7698C433DB
	for <linux-sparse@archiver.kernel.org>; Fri, 29 Jan 2021 00:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7062564DEB
	for <linux-sparse@archiver.kernel.org>; Fri, 29 Jan 2021 00:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhA2A3g (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhA2A33 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Jan 2021 19:29:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5091AC061573
        for <linux-sparse@vger.kernel.org>; Thu, 28 Jan 2021 16:28:49 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id g3so10483334ejb.6
        for <linux-sparse@vger.kernel.org>; Thu, 28 Jan 2021 16:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2iR6dWTaLu/Lqc9tystWWe6HIDceOxnTZEnvBm1x1s=;
        b=PdaK+nmimOuF1XDYZ79gBp0Za9FIv75DmXWfr1+gkjjKa8GJRM6H53q3yPswoskcl3
         bElyxIIPgaSS8osJMiwceql3eBjhr2cV0+T+NQ/zqX4ZT5wH+21Mf2SrGXoTe3fqtUiG
         WYA4glcBhG9DVdCzidUIBB8/TMJK/YECxbg40zIoEeM6Y0hz3TG2OKmL4ISZ3ohCZyYs
         iKV3jmRC25mIOX9jrf81tK3wv49NgaTdXyjStcd59c3qrSEw32Sb2Kr/sb2SvCV8193j
         vw9e5OUlQf1S9uOH6HGhI3rQZuUOLYyr7vbIw9GJxYsrOe7ORlFG81aHKPwiSuTEqOyN
         pv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2iR6dWTaLu/Lqc9tystWWe6HIDceOxnTZEnvBm1x1s=;
        b=kq0s5mCV+TFATTjnlXM1+UgyUw1RFptZkDCTU4a0iArfoHOHp5GxTMR6yxBcfrFXYy
         vsAkOaXhdp4zDMbmeCoxeh2lKqo+PZ4Diu/3S6m/aZa+HxlrTaLgHpy1i/wMsxcFFwRQ
         xhajy+zPvE8Xt7vde6Mj5Lu453RfGLXWEcTCKToS6ayPVt5ccCi0HtgvfK719tsgDS+Y
         0XpILodGn+AuI+2ECMdpnACWENO2DStVe2M4AVFup/VDtbrZkEPEDIzNGX9YYGFSbcPc
         i8IvXaNDL/UYaEH0Pp5fwL5/DISQryp1uQyERdDXAZGUiTxh9eR0l1RnaS6MmwDp+BhU
         bkPg==
X-Gm-Message-State: AOAM532lCktIP3EEmQbkCA9OES37g6UvzaKY6P0KcE4h8uQ4FPffVzz1
        54ZNlOEDiSIrKS1r4BiUATKyP7KU1rQ=
X-Google-Smtp-Source: ABdhPJxtSVIAUZjt1BNpDIp4NX6vQPChK5VZuzb1RmXdp85ydkSPPmgrFqH9IdsOvmVID3AtN3AwLw==
X-Received: by 2002:a17:907:9f9:: with SMTP id ce25mr2158856ejc.352.1611880128026;
        Thu, 28 Jan 2021 16:28:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:2c9d:c007:e1d0:a3a6])
        by smtp.gmail.com with ESMTPSA id h19sm3044663ejl.26.2021.01.28.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 16:28:47 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix add_join_conditional() one of the alternative is VOID
Date:   Fri, 29 Jan 2021 01:28:39 +0100
Message-Id: <20210129002839.1579-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

add_join_conditional()'s job is to take the 2 alternatives
of the conditional, make a phi-node from them and return
the corresponding pseudo but if one of the alternatives
is not available it's useless to create a phi-node and
the other alternative can then directly be returned.

The problem is that in this later case, the pseudo directly
returned is the PSEUDO_PHI of the corresponding phi-source.
This gives erroneous code like, for example:
	phisrc.32	%phi1 <- $0
	ret.32		%phi1
instead of:
	ret.32		$0
since the %ph1 should only be used by a phi-node instruction.

Fix this by returning phi-source's operand instead.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                           |  4 ++--
 validation/linear/join-cond-discard.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 validation/linear/join-cond-discard.c

diff --git a/linearize.c b/linearize.c
index e80715ab2458..7a6f745fd4fc 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1678,9 +1678,9 @@ static pseudo_t add_join_conditional(struct entrypoint *ep, struct expression *e
 	struct instruction *phi_node;
 
 	if (phi1 == VOID)
-		return phi2;
+		return (phi2 == VOID) ? phi2 : phi2->def->src;
 	if (phi2 == VOID)
-		return phi1;
+		return (phi1 == VOID) ? phi1 : phi1->def->src;
 
 	phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
 	use_pseudo(phi_node, phi1, add_pseudo(&phi_node->phi_list, phi1));
diff --git a/validation/linear/join-cond-discard.c b/validation/linear/join-cond-discard.c
new file mode 100644
index 000000000000..9f07a7d499f6
--- /dev/null
+++ b/validation/linear/join-cond-discard.c
@@ -0,0 +1,19 @@
+void abort(void) __attribute__((noreturn));
+
+int bar(int a)
+{
+	return a ? (abort(), 0) : 0;
+}
+
+int qux(int a)
+{
+	return a ? (abort(), 0) : (abort(), 1);
+}
+
+/*
+ * check-name: join-cond-discard
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: phisrc\\..*phi
+ */
-- 
2.30.0

