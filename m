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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29999C388F9
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68FE20885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDgCWJmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgKHBVb (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHBVb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:21:31 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9CFC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:21:31 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id gn41so7255987ejc.4
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ybkTI1DFG/k+ICg4+d9d+6SaAn12c8V5pJbjpzsC00=;
        b=IDgCWJmyQuCyvXjkN5v8bhcdg0s68e1lEE9TZMOl1Aq2WQyjPM2JQrfP5uRigzmLun
         aTRNrHmi4rOjRRdQwsoJWnj52HFI2uAAqm5u9GWfdLMy+PoJwp/YtU8rjEUadWnS2yTm
         AdBENYtSYMPsoCqJtFPlY2m7a7Yz/IYilTLuW5qeLigfVqIoXXzYx0Bf5lGQ3AwJx8SO
         TrFkeH4S6kxowPt2wTPnexcEe9FUdyexLEuGayVCkEuHOOSNcDS1AyCFCQuxrGD6fu3/
         6UB7dBNnOVpfNPbbiJXY/fRXOjhvdtxXDbzfzVMTYzoJp18Ez/jne6Vcf6ABdUZPlQT+
         WazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ybkTI1DFG/k+ICg4+d9d+6SaAn12c8V5pJbjpzsC00=;
        b=b2KwTUcwdQTDl0mBiUoDb6IwZ+lkQq87l1QD7HZLZDUr+B8/OURX0/p7i7XO2cLjKP
         nDy6QXXNx0KEbaxQZuqyW686UVMiLrnREk2wXFOkoOW1VTr9/H594UAMOWlRQqhpsvj6
         GD2m/w2JlAxAicDEMY4Ptsvt/e+ObC1Ch+ETbliec2IK3nfb/rUx5lnh1NFIVHNjH/rB
         Rlh1Do8pPS2JopdF6WiLg/+wwvq5SEZAChrnt3puGL1js85B8PpSgn2Vg7SnfLr3g6J4
         KeL0PPuRVLBoe1YvXkOoSwBhwvPhloJ9klUsPoG/WzZYWzlt4xblUh1kY4MRF9wRlhYc
         Xa7A==
X-Gm-Message-State: AOAM533LxKv9wJBlpg0m3JmlVUR101dWkYZGzYklTwWrfDzlQuQIFQrC
        340dGd8tgNSnAL9LzxzcohkN/bPyaQ0=
X-Google-Smtp-Source: ABdhPJyfAf19zQ7aIxCM0RprJAz1aPRw0r2BacDOE3AxdW0TEPYQ6oYkeXXnrTkUZ0QYvR88DTgopA==
X-Received: by 2002:a17:906:77c5:: with SMTP id m5mr8937646ejn.424.1604798489644;
        Sat, 07 Nov 2020 17:21:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id u25sm4511426eje.99.2020.11.07.17.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:21:29 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/16] cmp: simplify sext(x) cmp C --> x cmp C
Date:   Sun,  8 Nov 2020 02:21:20 +0100
Message-Id: <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When doing a compare of a sign-extended value against a constant
the, sign-extension can be dropped and the comparison done on the
original type if the constant is within the original range.

Simplify away these sign-extensions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                  | 24 ++++++++++++++++++++++++
 validation/optim/cmp-sext.c |  1 -
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 2176f90dc133..eb2c724f6307 100644
--- a/simplify.c
+++ b/simplify.c
@@ -415,6 +415,13 @@ static inline int constant(pseudo_t pseudo)
 	return pseudo->type == PSEUDO_VAL;
 }
 
+///
+// is this same signed value when interpreted with both size?
+static inline bool is_signed_constant(long long val, unsigned osize, unsigned nsize)
+{
+	return bits_extend(val, osize, 1) == bits_extend(val, nsize, 1);
+}
+
 ///
 // replace the operand of an instruction
 // @insn: the instruction
@@ -1082,6 +1089,9 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 static int simplify_compare_constant(struct instruction *insn, long long value)
 {
 	unsigned long long bits = bits_mask(insn->itype->bit_size);
+	struct instruction *def;
+	pseudo_t src1, src2;
+	unsigned int osize;
 	int changed = 0;
 
 	switch (insn->opcode) {
@@ -1126,6 +1136,20 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			changed |= replace_binop_value(insn, OP_SET_LT, 0);
 		break;
 	}
+
+	src1 = insn->src1;
+	src2 = insn->src2;
+	value = src2->value;
+	switch (DEF_OPCODE(def, src1)) {
+	case OP_SEXT:				// sext(x) cmp C --> x cmp trunc(C)
+		osize = def->orig_type->bit_size;
+		if (is_signed_constant(value, osize, def->size)) {
+			insn->itype = def->orig_type;
+			insn->src2 = value_pseudo(zero_extend(value, osize));
+			return replace_pseudo(insn, &insn->src1, def->src);
+		}
+		break;
+	}
 	return changed;
 }
 
diff --git a/validation/optim/cmp-sext.c b/validation/optim/cmp-sext.c
index 2dd60fff064c..13f4fbdfad77 100644
--- a/validation/optim/cmp-sext.c
+++ b/validation/optim/cmp-sext.c
@@ -17,7 +17,6 @@ _Bool cmpgtu_sext(int a) { return (a >= 0x80000000ULL) == (a <  0); }
 /*
  * check-name: cmp-sext
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

