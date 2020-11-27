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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5535CC64E7A
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B320795
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh/PmCRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgK0QwE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732128AbgK0QwD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 11:52:03 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57980C0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:03 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id f190so4086053wme.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jAC7LnI9d+ILNNjboWAHlG+DH0oCS0kBDK+Bkm8Eovo=;
        b=Fh/PmCRnulKfb7+Z4J7L74wEEEhKz20LXnJnhxOKyRUg/k16VyINUWnJBfCJabMKhP
         TVhKKSrWVPbgz9pVQr+PAZOMslZwkV4m2AXC8XO/+RtiluaX6+QkCS+2/LdT+tklQNbC
         t5ZswzgedH6dbLiv3u10sPIdWub/hJdBk/4IxwwNGIzVkIMmD1QlcqsmnSkqrnCViLiO
         sfufcAIwmkh53jyWzGIyA2QygycPZhmBeK81dQKKvIyWkX84HcmaWeMvYVRWBLDhde4P
         2XV9oYn2U1u2mLrLEIG5ufE7HpbCWJ7+9Go2ksBgN3K6QEk0myZLIYx9V0Xkm469RPQQ
         9Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAC7LnI9d+ILNNjboWAHlG+DH0oCS0kBDK+Bkm8Eovo=;
        b=Gc2RpF5SWPF8jeXa5azQBddoG5LHLfURgBtfuZnFwqKd50wZS1D1shyeLgI9dh8KWN
         ZB7zaVR8Ts/K3wZn2vQsOLUar3HrTueyuzmItwswtKMOTURbLKD/Q+C5N198ysYjSN6r
         E9E26mrdb8ww8IH249v6CGpJuaJWJUovnlU4pJP6eS0r5sKtU3rtOEvBADQ95nA6ZaY/
         CBIK+BdRGhd3YpbP+w63NLn+MwdJSUP/VSxqbfVhD0N/FgZrASKmPRi4J/S/xT5Woc6R
         sWvhmVR1UYH2xL/NXZcUkAuEyyrrDb95KdFp5OGpuaYOV6KSMSn1nnkZtdL2q0NxqRVP
         /q0Q==
X-Gm-Message-State: AOAM530TyGdJ/PMhvzirmz1kE5/bskV36EuAzJrrHrBo1ebTOpCRNes5
        X9TP52FeA86ppDGI/IyZmCt5ZtPxPEg=
X-Google-Smtp-Source: ABdhPJx34FGRXAn+p6xmYgK4Pk4Q4kz7vCplDvF63FH/i9LRyUAMOesxYdbWzI0Zn/UCrsV8QnqBeA==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr10192443wmj.169.1606495921904;
        Fri, 27 Nov 2020 08:52:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e9bd:38ae:745f:40ea])
        by smtp.gmail.com with ESMTPSA id y2sm15895539wrn.31.2020.11.27.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:52:01 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/8] add helper make_insn_pair() & swap_insn()
Date:   Fri, 27 Nov 2020 17:49:45 +0100
Message-Id: <20201127164950.41517-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
References: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add two helpers to create instruction pair OUT(IN(a, b), c).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/simplify.c b/simplify.c
index d16390caed49..24b3dcb52428 100644
--- a/simplify.c
+++ b/simplify.c
@@ -506,6 +506,37 @@ static inline int replace_opcode(struct instruction *insn, int op)
 	return REPEAT_CSE;
 }
 
+///
+// create an instruction pair OUT(IN(a, b), c)
+static int replace_insn_pair(struct instruction *out, int op_out, struct instruction *in, int op_in, pseudo_t a, pseudo_t b, pseudo_t c)
+{
+	pseudo_t old_a = in->src1;
+	pseudo_t old_b = in->src2;
+	pseudo_t old_1 = out->src1;
+	pseudo_t old_2 = out->src2;
+
+	use_pseudo(in, a, &in->src1);
+	use_pseudo(in, b, &in->src2);
+	use_pseudo(out, in->target, &out->src1);
+	use_pseudo(out, c, &out->src2);
+
+	remove_usage(old_a, &in->src1);
+	remove_usage(old_b, &in->src2);
+	remove_usage(old_1, &out->src1);
+	remove_usage(old_2, &out->src2);
+
+	out->opcode = op_out;
+	in->opcode = op_in;
+	return REPEAT_CSE;
+}
+
+///
+// create an instruction pair OUT(IN(a, b), c) with swapped opcodes
+static inline int swap_insn(struct instruction *out, struct instruction *in, pseudo_t a, pseudo_t b, pseudo_t c)
+{
+	return replace_insn_pair(out, in->opcode, in, out->opcode, a, b, c);
+}
+
 static inline int def_opcode(pseudo_t p)
 {
 	if (p->type != PSEUDO_REG)
-- 
2.29.2

