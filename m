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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA072C43460
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAA061278
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbhDLVVs (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242786AbhDLVVq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE5CC06175F
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mh2so1042152ejb.8
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3Atag3Uhwbwc86Jz5JwLkrDGBV8Qf2M+gfpyGrCfvo=;
        b=sPLFFq8fzjhcuxnjwbrQ+zb9boNHeulDeLBsT3/zUq1avOml8HXpiTggj01GH58lbO
         CQUCUE3eXqaQjZs2fNCUHLAY4MeHv4JacZT+uE1AVouoQomOPHeffvdDf7GEHKbZYJUX
         vkMJ/vAIKU3hfO9OLuvCDklSeWZSvDNhTWcgtZEvUq1p2S3fbYuGkq2cU7CybElTx37g
         MY7vV1l0bhLsFsfOPnvJJT3rnz2IUWfRZrHNI+9nnbgbGSXf2/iBdY0bHqkwIt5GVCCK
         k3DDq0kL1t7IwTeScFq+57vPwfeoB4No6VYpYU1CAB6J/BYJP9DoGQG3ka+KCmBSb49n
         CoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3Atag3Uhwbwc86Jz5JwLkrDGBV8Qf2M+gfpyGrCfvo=;
        b=Gzg6CTiv5rB17iosqeY4T6xdQCZM7tssPACuJ+HJC0HOARFJ/fFq60fWQWlBXzhlYL
         w4PVJJglEXxmYQRYEEgL6FQCTBiASXZAhdB0kY0NlpVcPRmu9x5xv4Ka7hIN6eZr/Ksb
         CVar0ddPZeV3AHBqiOFUSayPaRX8jRUPnPCNUPK9ugE5KMTQgT8iSYzLxDjm3+96MdR9
         vebRXVaHeosWfUkMttAMR0dx4/20G+/aGDDOlrMajQmMdshUwdXacDIv/1ae9l8ReOTm
         0aHoRkg5Y8tQ6Ytsi9j+OCguSKyE+G3TfflxhFxiUPhl1PXtlxhQHs0+yg2RpRr9FtKf
         /6qQ==
X-Gm-Message-State: AOAM532q5EVCco+2l6qVIdSZsWfpeaoditocv1Y/+OjRLAd7gt+Vfl9l
        k4bSZqg2DtrHsMNZ2rPslTh6JCKybsM=
X-Google-Smtp-Source: ABdhPJyjQVhu0QByvdW74Amr/HdOTAnq4cplv+MGR40P/EiHogZCjm/hvJkUp+OF8hSd+X1SUmLCwg==
X-Received: by 2002:a17:907:2137:: with SMTP id qo23mr29541216ejb.442.1618262486815;
        Mon, 12 Apr 2021 14:21:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6903:692b:54da:df0c])
        by smtp.gmail.com with ESMTPSA id g11sm7744156edt.35.2021.04.12.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:26 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 7/8] scheck: assert_const()
Date:   Mon, 12 Apr 2021 23:21:10 +0200
Message-Id: <20210412212111.29186-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Since, the symbolic checker check expressions at the ... symbolic
level, this can be used to check if two expressions are equivalent
but not if this equivalence is effectively used.

So, add a new assertion (this time not at the symbolic level) to
check if an expression which is expected to simplify to a constant
is effectively simplified to this constant.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h           |  1 +
 scheck.c               | 19 +++++++++++++++++++
 validation/scheck/ok.c |  1 +
 3 files changed, 21 insertions(+)

diff --git a/ident-list.h b/ident-list.h
index ab5bc5f52e01..6264fd062534 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -81,6 +81,7 @@ IDENT(main);
 /* used by the symbolic checker */
 IDENT(__assert);
 IDENT(__assert_eq);
+IDENT(__assert_const);
 
 #undef __IDENT
 #undef IDENT
diff --git a/scheck.c b/scheck.c
index efa5c1c3247b..f5ea4cf11902 100644
--- a/scheck.c
+++ b/scheck.c
@@ -33,6 +33,7 @@
 static const struct builtin_fn builtins_scheck[] = {
 	{ "__assert", &void_ctype, 0, { &bool_ctype }, .op = &generic_int_op },
 	{ "__assert_eq", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
+	{ "__assert_const", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
 	{}
 };
 
@@ -233,6 +234,22 @@ static bool check_equal(Btor *btor, struct instruction *insn)
 	return check_btor(btor, n, insn);
 }
 
+static bool check_const(Btor *ctxt, struct instruction *insn)
+{
+	pseudo_t src1 = ptr_list_nth(insn->arguments, 0);
+	pseudo_t src2 = ptr_list_nth(insn->arguments, 1);
+
+	if (src2->type != PSEUDO_VAL)
+		sparse_error(insn->pos, "should be a constant: %s", show_pseudo(src2));
+	if (src1 == src2)
+		return 1;
+	if (src1->type != PSEUDO_VAL)
+		sparse_error(insn->pos, "not a constant: %s", show_pseudo(src1));
+	else
+		sparse_error(insn->pos, "invalid value: %s != %s", show_pseudo(src1), show_pseudo(src2));
+	return 0;
+}
+
 static bool check_call(Btor *btor, struct instruction *insn)
 {
 	pseudo_t func = insn->func;
@@ -242,6 +259,8 @@ static bool check_call(Btor *btor, struct instruction *insn)
 		return check_assert(btor, insn);
 	if (ident == &__assert_eq_ident)
 		return check_equal(btor, insn);
+	if (ident == &__assert_const_ident)
+		return check_const(btor, insn);
 	return 0;
 }
 
diff --git a/validation/scheck/ok.c b/validation/scheck/ok.c
index f4a0daabfe9a..8f65013e1618 100644
--- a/validation/scheck/ok.c
+++ b/validation/scheck/ok.c
@@ -2,6 +2,7 @@ static void ok(int x)
 {
 	__assert((~x) == (~0 - x));	// true but not simplified yet
 	__assert_eq(~x, ~0 - x);
+	__assert_const(x & 0, 0);
 }
 
 static void always(int x)
-- 
2.31.1

