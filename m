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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB2C388F9
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97E5208FE
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYmG5LQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgKHBVh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgKHBVh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:21:37 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05721C0613D3
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:21:37 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o21so7266511ejb.3
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9J992tTLG2w4CWdNXUkzfs6Rt3w4UoHYyRE09KHFY0=;
        b=HYmG5LQUB3e+culG/vzQftPNAv0mYhMHHFHO7ULdbQAgyyyh0ERo6YORaZI03hrHlu
         crIYPJd5sQmmRYKJ23p5kEaDFY1ZNCtJ5HJ97TFRAT4aoYv36sZSvjKDCuUDnz+/mm3+
         4KEPAaB8f6wK81dgIrT6xzmVolhv9aNLwS/gdtcI+HKnMBVdSLp2st7eIUl9Il8Um7UL
         9R4NUMmWv91u/akFjAd2UVOk+4//xqJZYCfG+geeVrAlv19OEzFUoCKsK90EeQrnDTOY
         EFIuODu+2HzHr4MC8/dydEWqU9HDDCYw/yEBxA+Hwpu5yaTMADpPMSpFhDp8Thz7BcOG
         AVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9J992tTLG2w4CWdNXUkzfs6Rt3w4UoHYyRE09KHFY0=;
        b=UOtXUgOKVymLOz0rDeaPa68h2kCgGDlqQSCOQ6Iqu+0b4K+lYG9cRiEoc7THYHbNah
         adGMK55nI21pfkVDtdtJ8SuowRSKyV+srXcfzZx0M4m9cU8H0WUhn6u3LXibm0ciXbEx
         wBItiPeJY5uYv7Pp1tBofDVyedR1qbRupYs0rjs2SuuBKTxGivvyLO6tyXvUbUIOp0BP
         +Ol/aNjihOM+loFRFh+ipp0swf6d5tsU0UZS+TEUaqxISuUH1iVKE/hpICcSs5uN3XMA
         XcmmPxx0XZh4axurNQeQqCLwAq9DSpEFQuNVtSKBKLGgqKHZfWG+SkaUtgp0fyja6vGR
         TwhQ==
X-Gm-Message-State: AOAM530ih8o96QBZpKCi7sIUb1+X/nNeOAP/pv67X6fuHW80UYNHJrhI
        yZGRd1vcu334ubUndQ5lI6jS28PGejk=
X-Google-Smtp-Source: ABdhPJxRMsNqpAaKmi30ikXZnF8Sz2JaHO078SvxVNy916Rr7ccY7WOLUC/qdwuQyqi0MUWV3zOwHg==
X-Received: by 2002:a17:906:400c:: with SMTP id v12mr9352913ejj.387.1604798495426;
        Sat, 07 Nov 2020 17:21:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id u25sm4511426eje.99.2020.11.07.17.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:21:34 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 16/16] cmp: simplify compares and sign/zero extend
Date:   Sun,  8 Nov 2020 02:21:26 +0100
Message-Id: <20201108012126.94339-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
 <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Compare instructions with both operands sign or zero-extended
from the same original size are equivalent to a compare of
the original values. If the values were zero-extended, a signed
compare becomes an unsigned one.

Simplify away the sign/zero-extensions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 52 ++++++++++++++++++++++++++------
 validation/optim/cmp-sext-sext.c |  1 -
 validation/optim/cmp-zext-zext.c |  1 -
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/simplify.c b/simplify.c
index 7538c9393b41..d56d4c89a078 100644
--- a/simplify.c
+++ b/simplify.c
@@ -422,6 +422,22 @@ static inline bool is_signed_constant(long long val, unsigned osize, unsigned ns
 	return bits_extend(val, osize, 1) == bits_extend(val, nsize, 1);
 }
 
+///
+// is @src generated by an instruction with the given opcode and size?
+static inline pseudo_t is_same_op(pseudo_t src, int op, unsigned osize)
+{
+	struct instruction *def;
+
+	if (src->type != PSEUDO_REG)
+		return NULL;
+	def = src->def;
+	if (def->opcode != op)
+		return NULL;
+	if (def->orig_type->bit_size != osize)
+		return NULL;
+	return def->src;
+}
+
 ///
 // replace the operand of an instruction
 // @insn: the instruction
@@ -1570,6 +1586,30 @@ static int simplify_sub(struct instruction *insn)
 	return 0;
 }
 
+static int simplify_compare(struct instruction *insn)
+{
+	pseudo_t src1 = insn->src1;
+	pseudo_t src2 = insn->src2;
+	struct instruction *def;
+	unsigned int osize;
+	pseudo_t src;
+
+	switch (DEF_OPCODE(def, src1)) {
+	case OP_SEXT: case OP_ZEXT:
+		osize = def->orig_type->bit_size;
+		if ((src = is_same_op(src2, def->opcode, osize))) {
+			const struct opcode_table *op = &opcode_table[insn->opcode];
+			if ((def->opcode == OP_ZEXT) && (op->flags & OPF_SIGNED))
+				insn->opcode = op->sign;
+			insn->itype = def->orig_type;
+			replace_pseudo(insn, &insn->src1, def->src);
+			return replace_pseudo(insn, &insn->src2, src);
+		}
+		break;
+	}
+	return 0;
+}
+
 static int simplify_constant_unop(struct instruction *insn)
 {
 	long long val = insn->src1->value;
@@ -2083,17 +2123,9 @@ int simplify_instruction(struct instruction *insn)
 	case OP_DIVS:
 	case OP_MODU:
 	case OP_MODS:
-	case OP_SET_EQ:
-	case OP_SET_NE:
-	case OP_SET_LE:
-	case OP_SET_GE:
-	case OP_SET_LT:
-	case OP_SET_GT:
-	case OP_SET_B:
-	case OP_SET_A:
-	case OP_SET_BE:
-	case OP_SET_AE:
 		break;
+	case OP_BINCMP ... OP_BINCMP_END:
+		return simplify_compare(insn);
 	case OP_LOAD:
 	case OP_STORE:
 		return simplify_memop(insn);
diff --git a/validation/optim/cmp-sext-sext.c b/validation/optim/cmp-sext-sext.c
index ba6ed54e940c..3bd22fb738ca 100644
--- a/validation/optim/cmp-sext-sext.c
+++ b/validation/optim/cmp-sext-sext.c
@@ -11,7 +11,6 @@ _Bool cmpu_sext_sext(ARGS(INT32)) { return TEST(UINT64, UINT32, a, < , b); }
 /*
  * check-name: cmp-sext-sext
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/optim/cmp-zext-zext.c b/validation/optim/cmp-zext-zext.c
index 9f188297e214..88f9078f9480 100644
--- a/validation/optim/cmp-zext-zext.c
+++ b/validation/optim/cmp-zext-zext.c
@@ -11,7 +11,6 @@ _Bool cmpu_zext_zext(ARGS(UINT32)) { return TEST(UINT64, UINT32, a, < , b); }
 /*
  * check-name: cmp-zext-zext
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

