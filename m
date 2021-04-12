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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020D9C433B4
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D944B61278
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbhDLVVr (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbhDLVVo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8FDC061574
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u21so22572132ejo.13
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFigMdQ4IIzSB3aVsxjFRTm7LBjV+V/rgt0UVSYJPDQ=;
        b=jHv63XmVvD2NsdTOQm7pd15ObmOHy9C8CihGhJUC+B8h/NC4Ap6jMhmewz+y1ABfrc
         2+JXby8Uds0TCNnQaIOc5e7pefrZ1WhqV68AG8tn7uRdKify6DmoH9lQ1stckemZbd0R
         qGwdYfPzwSS82MThvvRlDFVsMuo6dfYSZnyHOe6/6wB/dAEKhbxnnr+6qgyK+y0LGZ6w
         39DELIAEuPQKdxW6YG7OOHf1sA5vBkTDp5cWEXU+k5/oEmxsZNStileGwqsUh9KRUBEV
         PPHPH9Ty/+w5Pg+WZaZLwRxPa/vhOtxqEbcW3IYUHLTQ7RqPmYUaC832+VRUSU5ucypZ
         Vgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFigMdQ4IIzSB3aVsxjFRTm7LBjV+V/rgt0UVSYJPDQ=;
        b=IRbvBaRJEb5ER7QdJSULEvCArpmzeSjBqtgS75WlwK80PcAyLJ11mV3dUOiB71f2Bw
         RrbMwU0VWPpy7pElKZZO4WxUa03W2QyjvJ0FvmidDK2Bvm1414sANqmavWd7vJv8ikqM
         9X5rK9USjRwdCqI1strYXwAcb1sbCzE08u1n1+8ggwZtf3Z7qZywbm/qD5Pg3V4LI8a4
         9RHWTINmq5kystCqOA0nsnA4VMBZoYN+FY2if14A63elpv0qX5tglQuLHLw6AphKmmyZ
         RgWkU/vHryWc4L/5iEzKIfTynOiUBdzrdy1eC53/20elgbL51p0fjFm41Gfn9c7/HGF5
         Yoew==
X-Gm-Message-State: AOAM532A+phge7zeW6cqBvyewlw7f5Hg9RWyz38wGS+gTPIiExoxS0yK
        ivAYmCfkU6D902j8+ADOH6vAwzQXI0E=
X-Google-Smtp-Source: ABdhPJzAYdeB/gR/lV8TPQ3vcjDDuCKko4EfElpP4OahrTMtZausJskssAl+k9xC44rhJJWMU14zpQ==
X-Received: by 2002:a17:906:c143:: with SMTP id dp3mr27641629ejc.499.1618262484927;
        Mon, 12 Apr 2021 14:21:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6903:692b:54da:df0c])
        by smtp.gmail.com with ESMTPSA id g11sm7744156edt.35.2021.04.12.14.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:24 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 5/8] scheck: assert_eq()
Date:   Mon, 12 Apr 2021 23:21:08 +0200
Message-Id: <20210412212111.29186-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Testing the equivalence of two sub-expressions can be done with
with a single assertion like __assert(A == B).

However, in some cases, Sparse can use the equality to simplify
the whole expression although it's unable to simplify one of
the two sub-expressions into the other.

So, add a new assertion, __assert_eq(), testing the equality of
the two expressions given in argument independently of each other.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h           |  1 +
 scheck.c               | 11 +++++++++++
 validation/scheck/ok.c |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/ident-list.h b/ident-list.h
index 918f54d75fc4..ab5bc5f52e01 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -80,6 +80,7 @@ IDENT(main);
 
 /* used by the symbolic checker */
 IDENT(__assert);
+IDENT(__assert_eq);
 
 #undef __IDENT
 #undef IDENT
diff --git a/scheck.c b/scheck.c
index 63cbfa2d3404..c64e865136c5 100644
--- a/scheck.c
+++ b/scheck.c
@@ -32,6 +32,7 @@
 #define dyntype incomplete_ctype
 static const struct builtin_fn builtins_scheck[] = {
 	{ "__assert", &void_ctype, 0, { &bool_ctype }, .op = &generic_int_op },
+	{ "__assert_eq", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
 	{}
 };
 
@@ -224,6 +225,14 @@ static bool check_assert(Btor *btor, struct instruction *insn)
 	return check_btor(btor, n, insn);
 }
 
+static bool check_equal(Btor *btor, struct instruction *insn)
+{
+	BoolectorNode *a = get_arg(btor, insn, 0);
+	BoolectorNode *b = get_arg(btor, insn, 1);
+	BoolectorNode *n = boolector_eq(btor, a, b);
+	return check_btor(btor, n, insn);
+}
+
 static bool check_call(Btor *btor, struct instruction *insn)
 {
 	pseudo_t func = insn->func;
@@ -231,6 +240,8 @@ static bool check_call(Btor *btor, struct instruction *insn)
 
 	if (ident == &__assert_ident)
 		return check_assert(btor, insn);
+	if (ident == &__assert_eq_ident)
+		return check_equal(btor, insn);
 	return 0;
 }
 
diff --git a/validation/scheck/ok.c b/validation/scheck/ok.c
index 113912e01aad..76c04c4f6870 100644
--- a/validation/scheck/ok.c
+++ b/validation/scheck/ok.c
@@ -3,6 +3,11 @@ static void ok(int x)
 	__assert((~x) == (~0 - x));	// true but not simplified yet
 }
 
+static void also_ok(int x)
+{
+	__assert_eq(~x, ~0 - x);
+}
+
 static void always(int x)
 {
 	__assert((x - x) == 0);		// true and simplified
-- 
2.31.1

