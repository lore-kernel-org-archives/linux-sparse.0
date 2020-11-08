Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B886FC388F9
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDB820885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW8AESS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgKHBTu (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKHBTu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:50 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1534C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:49 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id o20so5077201eds.3
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2glrVwxHoe+54MBaX9AG99cybD+dpavIZChprse/WE=;
        b=QW8AESS4icI6NQZK52H+D+dx1kBsgdoHF60U5jdRIzANIgepqlu6gdyYeOfyNLUos7
         w0V7K4Baqz3HRJpwsC4kPZUqRDRzFlPWSIU1r86EeOsSsCwfT73QqV63jwnUGTKmROBg
         jdSSmLDmqpdXwOBztjse5Qg+NXe7F8TFgV7uZfLgpDalsjFLgvuydapRy93TZQtNBxQY
         Q4gupecGJ8He4eAFU39QSE5IPW6VO/h2LUc6yf7DzV+CHK/f9vB6nQlTQNwOAm6EB4OQ
         rkhPWRULTUg33G4FEVrmNrK6GvvIMdKq2EzD0F7GMbSo/rCO8x4siawPle51v8+psSbg
         Y2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2glrVwxHoe+54MBaX9AG99cybD+dpavIZChprse/WE=;
        b=KaRWCuHWgEFHYoIEIrC5D+6KxqCghFqedidQWCbLD/5UbC8dICcJ6GWxdJDdcEb7XT
         eSlNu17E1iV/Wn4nKke0Rz4jPfg/bnVsUwf9ojuiEmh6TYWTnnEFe85eHSnhqr7KJEFq
         4PIpKGxa50NaInOD7uga0qsSA/2+j9IwQ08/eucaK8ExzKRaNuFHnims+5QYYOs6P3LB
         AtmzI00DCNfqAjtGyWHzr8rcv5t0x+gkmWeFsU9DFVT7KQVztE7UYpibXgT/JNQh28lO
         OTC333BAreH/QzrabrC2FrX1Ku+U1WHgIET2r6w5QD3l5dQIULd0Q5A1gs9kh8dNxE+k
         E7AQ==
X-Gm-Message-State: AOAM533NPcjC4oNeVd+sZr98taTah4QG/L3sKY68bX4ZiAmK9403aEIt
        +roxJ/uZd9rOqhRv2/hF6ijE64Tn168=
X-Google-Smtp-Source: ABdhPJwdLCh7bZaWm33SplH02TJ5g/V3oYUIiL9IPumsPyIaMWJGvducFIe8L9GeWKlzMjv3NTUqlw==
X-Received: by 2002:a05:6402:17ad:: with SMTP id j13mr8587380edy.347.1604798388342;
        Sat, 07 Nov 2020 17:19:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:47 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/16] cmp: use a few helpers for the simplification of compares
Date:   Sun,  8 Nov 2020 02:19:35 +0100
Message-Id: <20201108011939.94252-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current code for the simplification of compares is quite
simple but also repetitive because everything must be done 4 times,
one for each operations (<,<=,>=,>).

So, add 2 helpers to factor out the details of the common parts.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/simplify.c b/simplify.c
index 3338b72e6845..59e6d1eee291 100644
--- a/simplify.c
+++ b/simplify.c
@@ -470,6 +470,28 @@ static inline int replace_with_unop(struct instruction *insn, int op, pseudo_t s
 	return REPEAT_CSE;
 }
 
+///
+// replace rightside's value
+// @insn: the instruction to be replaced
+// @op: the instruction's new opcode
+// @src: the instruction's new operand
+// @return: REPEAT_CSE
+static inline int replace_binop_value(struct instruction *insn, int op, long long val)
+{
+	insn->opcode = op;
+	insn->src2 = value_pseudo(val);
+	return REPEAT_CSE;
+}
+
+///
+// replace the opcode of an instruction
+// @return: REPEAT_CSE
+static inline int replace_opcode(struct instruction *insn, int op)
+{
+	insn->opcode = op;
+	return REPEAT_CSE;
+}
+
 static inline int def_opcode(pseudo_t p)
 {
 	if (p->type != PSEUDO_REG)
@@ -1061,34 +1083,24 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 {
 	switch (insn->opcode) {
 	case OP_SET_B:
-		if (!value) {			// (x < 0) --> 0
+		if (!value)			// (x < 0) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
-		} else if (value == 1) {	// (x < 1) --> (x == 0)
-			insn->src2 = value_pseudo(0);
-			insn->opcode = OP_SET_EQ;
-			return REPEAT_CSE;
-		}
+		if (value == 1)			// (x < 1) --> (x == 0)
+			return replace_binop_value(insn, OP_SET_EQ, 0);
 		break;
 	case OP_SET_AE:
-		if (!value) {			// (x >= 0) --> 1
+		if (!value)			// (x >= 0) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
-		} else if (value == 1) {	// (x >= 1) --> (x != 0)
-			insn->src2 = value_pseudo(0);
-			insn->opcode = OP_SET_NE;
-			return REPEAT_CSE;
-		}
+		if (value == 1)			// (x >= 1) --> (x != 0)
+			return replace_binop_value(insn, OP_SET_NE, 0);
 		break;
 	case OP_SET_BE:
-		if (!value) {			// (x <= 0) --> (x == 0)
-			insn->opcode = OP_SET_EQ;
-			return REPEAT_CSE;
-		}
+		if (!value)			// (x <= 0) --> (x == 0)
+			return replace_opcode(insn, OP_SET_EQ);
 		break;
 	case OP_SET_A:
-		if (!value) {			// (x > 0) --> (x != 0)
-			insn->opcode = OP_SET_NE;
-			return REPEAT_CSE;
-		}
+		if (!value)			// (x > 0) --> (x != 0)
+			return replace_opcode(insn, OP_SET_NE);
 		break;
 	}
 	return 0;
-- 
2.29.2

