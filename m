Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0727DC388F7
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 13:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A1220719
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 13:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJJETv4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKGNkD (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 08:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNkD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 08:40:03 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C6C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 05:40:02 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id t9so717062edq.8
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OX9z1BAM0UwPlyRNcI6kZqJwETQUafPsNgDd03PhOxk=;
        b=ZJJETv4tdmjTucvtXd4g4Darh3fYbK/iQWPFOJxyo+U7xCC4vwaAf4yWrUFTKHLyZG
         rgqSHMHN/wRaxq1ZvE9/ILNUrZmUCRv5PwRCb6h4y3VX2f08d4UhySBpBY96vbDI9Wvk
         Z0pyn8SHmqQvFHczRbHJeTZcgbI77nJ47a4BhiY/8R+EaNS23MuxINi4UBZkvA0CTlab
         1U3BhRXIr7NAH7Q5YKGOUA/akFsBD1ZS5xg1V+yKyu0QDL1Ga8llEFMbgDfhW/KLjH99
         hJ1c58j4UJtpIQgbguyWCyLMTP2IayxpFJ9Y3OhvhO3C/Qq62k+9/RQKeWG45c9hy8KO
         bTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OX9z1BAM0UwPlyRNcI6kZqJwETQUafPsNgDd03PhOxk=;
        b=jSdE9PV7ajmzlR//zcqUY6lNUdUgOQ1bAsVTo2nA3XbI6+P+erwrWqVUjFv+cL5O4Z
         nm1CCXVyt6FPzpaf59cq5DxDGgnwT6cpWkEeCFdY4fTzTS8bsEEa7PN+YxPkifNmpUPF
         7bM0b7+vCDUXb7NozT2wJy+PpVfhLtlcUQppJYhTpbWXX5TL77Ogr+FKyUvBHcN/13cN
         NvjJ9divXdKnDioKqC/Z0xca91ypnqE5dWOQ9lRYxTVYdBA6kX+IqSHlmB5mnyzohrwE
         511xLWwjA9TeEWpxgWiRnQEfDyQeTJLtQHFJ8em6Vot2y0ICwsBjUKXwAeAZ2mZYqWP5
         lu3Q==
X-Gm-Message-State: AOAM530GhUdv+PDvraVr+t6JosQQEtXhiUu5uEtVgLr/P3Rs9jvhnsNR
        pAFr3/g2FZWLNgWZpIwv3Lxvp9F+kyY=
X-Google-Smtp-Source: ABdhPJxE/MqdKSSDbMCbAo3l0a9xs+XJF5ji2XAdkK5XEwmCeePu/dqo5GhKNW2QDV6TDZYpvPS5/Q==
X-Received: by 2002:a05:6402:4d:: with SMTP id f13mr6935581edu.306.1604756401367;
        Sat, 07 Nov 2020 05:40:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:59a2:5681:b2fc:1a9])
        by smtp.gmail.com with ESMTPSA id k11sm3371343edh.72.2020.11.07.05.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 05:40:00 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] simplify SEL(x == y, x, y) and friends
Date:   Sat,  7 Nov 2020 14:39:56 +0100
Message-Id: <20201107133956.16217-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If the condition of a select instruction is a equality test of the
select's operands, then the result of the select is always the same as
its second operand. Same for the first operand with an inequality test.

Simplify away these selects.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                     | 16 ++++++++++++++++
 validation/optim/eqne-select.c | 12 ++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 validation/optim/eqne-select.c

diff --git a/simplify.c b/simplify.c
index f2aaa52de84b..2d165cfe143c 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1747,6 +1747,7 @@ static int simplify_cast(struct instruction *insn)
 
 static int simplify_select(struct instruction *insn)
 {
+	struct instruction *def;
 	pseudo_t cond, src1, src2;
 
 	cond = insn->src1;
@@ -1782,6 +1783,21 @@ static int simplify_select(struct instruction *insn)
 		kill_use(&insn->src3);
 		return replace_with_value(insn, 0);
 	}
+
+	switch (DEF_OPCODE(def, cond)) {
+	case OP_SET_EQ:
+		if (src1 == def->src1 && src2 == def->src2)
+			return replace_with_pseudo(insn, src2); // SEL(x==y,x,y) --> y
+		if (src2 == def->src1 && src1 == def->src2)
+			return replace_with_pseudo(insn, src2); // SEL(y==x,x,y) --> y
+		break;
+	case OP_SET_NE:
+		if (src1 == def->src1 && src2 == def->src2)
+			return replace_with_pseudo(insn, src1); // SEL(x!=y,x,y) --> x
+		if (src2 == def->src1 && src1 == def->src2)
+			return replace_with_pseudo(insn, src1); // SEL(y!=x,x,y) --> x
+		break;
+	}
 	return 0;
 }
 
diff --git a/validation/optim/eqne-select.c b/validation/optim/eqne-select.c
new file mode 100644
index 000000000000..9dfd88b5eb4d
--- /dev/null
+++ b/validation/optim/eqne-select.c
@@ -0,0 +1,12 @@
+int sel_eq01(int a, int b) { return ((a == b) ? a : b) == b; }
+int sel_eq10(int a, int b) { return ((a == b) ? b : a) == a; }
+int sel_ne01(int a, int b) { return ((a != b) ? a : b) == a; }
+int sel_ne10(int a, int b) { return ((a != b) ? b : a) == b; }
+
+/*
+ * check-name: eqne-select
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.29.2

