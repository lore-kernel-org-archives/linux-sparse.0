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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF3FC433E9
	for <linux-sparse@archiver.kernel.org>; Sun, 24 Jan 2021 23:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D61922C9F
	for <linux-sparse@archiver.kernel.org>; Sun, 24 Jan 2021 23:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhAXXTd (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 24 Jan 2021 18:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbhAXXT0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 24 Jan 2021 18:19:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8E5C061573
        for <linux-sparse@vger.kernel.org>; Sun, 24 Jan 2021 15:18:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d22so13131966edy.1
        for <linux-sparse@vger.kernel.org>; Sun, 24 Jan 2021 15:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4DDjj8hE4sPgXxEuchKiPYgQfqWAber6EiBdRWTtGE=;
        b=aWU+27kFLbq2gWKMlNhbvKzsS7Wf8NgZIgj6B5qpPD1bP3D14N8LImqDtJ9SWG9wU6
         fDDIwC5iz79xRVn9Ic3DE3TwisjI4pFTbpVd5v9qcaQXoShPLjkqPHnP6ps8kFlRZGab
         TQhU0ZHEXv2wnBakaLK6+G4J1dUEChfz6Gj88FID5NEEPjnk6thKfXOLlkRTkKSa5hb0
         8OtdYPeuCKhAKcxIy7SNJD/eX5eirHATC7P2z1CFmouCVybsYDlb7jbqCZTy3kisdluB
         2DURNK6z+6vqNf8ZmjplyekBRBYs62k42bPRjLY0xUuq/3QFZ/tUnMqXryuihX3Gavtl
         9ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4DDjj8hE4sPgXxEuchKiPYgQfqWAber6EiBdRWTtGE=;
        b=oUj1Z3E/0lqCI3jEiQre1nsQdZqxKkqE+mt5nxUvnlnub+QsHxA0h+KCGpOwPlKkTO
         IehGv1qcvXG7tTUZpddH60OxPBTqkYMJWmeixCOlEsn8ce3Ic8H+XvOQFS6Z9zHaFbwS
         pTXDOwovn3Z83Wp3m1Hw/j6iTqKtMOtYJGYIOHVdT7TtON5SFMyuxvlJtGCTHcLaGlNC
         etl3yjWywEPU3h4kbitLGhTFIpK9iovYWyjfVfCeILNuWtf1gJ3jzIKyajdSa40DWIx5
         imtGuIA2cgLsPm7TZmiARAf90sZSO7LCcGzrXa5q06WAcMpNAe6m43EVHiix7+6rP7Ox
         3zag==
X-Gm-Message-State: AOAM533zNl5qxBeODjdLu2wkMnKAW+ohK42ruD/BEBg6tz3wfpjXPZFv
        OYnCe0xSWYeII9soP2qLiALnF8USYLk=
X-Google-Smtp-Source: ABdhPJz5JGeestpM/RZlKioej1RhbHhCmo4+SxK+/P9kHm35L3N3Knl6pzBb69ixFCOI9KOKIz2Xgg==
X-Received: by 2002:a50:fd83:: with SMTP id o3mr227525edt.359.1611530325114;
        Sun, 24 Jan 2021 15:18:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5d28:ebfe:28e4:3112])
        by smtp.gmail.com with ESMTPSA id cy13sm9509976edb.27.2021.01.24.15.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 15:18:44 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] simplify LSR + SEXT into ASR
Date:   Mon, 25 Jan 2021 00:18:36 +0100
Message-Id: <20210124231836.18100-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A logical shift right followed by a sign extension is equivalent
to an arithmetic shift. Teach this to sparse.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                    | 13 ++++++++++++-
 validation/optim/lsr-to-asr.c | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/lsr-to-asr.c

diff --git a/simplify.c b/simplify.c
index 1e7648486c49..3d398292f172 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2066,7 +2066,7 @@ static int simplify_memop(struct instruction *insn)
 static int simplify_cast(struct instruction *insn)
 {
 	unsigned long long mask;
-	struct instruction *def;
+	struct instruction *def, *def2;
 	pseudo_t src = insn->src;
 	pseudo_t val;
 	int osize;
@@ -2163,6 +2163,17 @@ static int simplify_cast(struct instruction *insn)
 		case OP_TRUNC:
 			insn->orig_type = def->orig_type;
 			return replace_pseudo(insn, &insn->src1, def->src);
+		case OP_SEXT:
+			if (size != def->orig_type->bit_size)
+				break;
+			if (DEF_OPCODE(def2, def->src) != OP_LSR)
+				break;
+			if (def2->src2 != value_pseudo(size - def->size))
+				break;
+			// SEXT(TRUNC(LSR(x, N))) --> ASR(x, N)
+			insn->opcode = OP_ASR;
+			insn->src2 = def2->src2;
+			return replace_pseudo(insn, &insn->src1, def2->src1);
 		case OP_ZEXT:
 			if (size != def->orig_type->bit_size)
 				break;
diff --git a/validation/optim/lsr-to-asr.c b/validation/optim/lsr-to-asr.c
new file mode 100644
index 000000000000..269277396429
--- /dev/null
+++ b/validation/optim/lsr-to-asr.c
@@ -0,0 +1,27 @@
+int lsr_to_asr24(int x)
+{
+	return ((signed char)(((unsigned)x) >> 24)) == (x >> 24);
+}
+
+
+struct s {
+	int :30;
+	signed int f:2;
+};
+
+int lsr_to_asr30(int a)
+{
+	union {
+		int i;
+		struct s s;
+	} u = { .i = a };
+	return u.s.f == (a >> 30);
+}
+
+/*
+ * check-name: lsr-to-asr
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.30.0

