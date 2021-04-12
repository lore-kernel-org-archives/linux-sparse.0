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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C01C43461
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B7C6135C
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhDLVVs (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbhDLVVr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A970FC06138C
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 18so16810096edx.3
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7vBxDcK+CbBXGC7650Q3+DnkkKcVHAG3Vshdvo4C5U=;
        b=Rm4sYU9kfkfxHWoKFO2oGYbNcmmEtWVVPkGUThaHAzF66IPyfIUZnJWVNukDBOVtj4
         vpOtANeB3DDO8/qF1D9JhcyGXAhk/Om+EUvDnsZ9iJRtgjCcKumYlhMLKffI8vFSCgXx
         bkFCOXdgGZ++PywgUUdkD48nXf+8BKX5ats6elVQzsgBGSh/TxUVUDJ2QjPQIfS7tynB
         j+3fw4bE8qDTwI3tk/Ao7BH+U30F1lXypZkhjA104nWis0zqBguv3WyD6Ml7/p8GYHke
         Xpb4acDS36wAPko5PWfgpHckkMfkffoTBMwz9LY+tVx4yejFcG1JqAOddic6w+brNyo9
         H9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7vBxDcK+CbBXGC7650Q3+DnkkKcVHAG3Vshdvo4C5U=;
        b=DCVWqkbycPcyX70s/W1B+yK96vC+r2t0mOViI/V2ShsV0zYVEPGMHToWVQ4UhHEvVL
         a9idhaRK+rV9Lag+SLsIsgpsOpQCtO5FHgRA3ii+QQaENmxjFO9Ef2NaYbk8szOpfBWW
         qpEQHbXO+o0Qn1fwkaFC9Xd8Zfp4FrZYDhyT1rdHCP3DMQZW3zcIjj86uEMWC3WOzbQz
         7OhQ0/IPK12QqBTXzeuGgwGxRkwMUkry7U5GG2AfL0ZS7RVhEicUuyG5/h8PD0f9SH/U
         +ZQUzo9g5uZd3p5i2sknaBGQsXCvzHwXF7ccKwalOVbGmR6qVyAnVd+4pBrk0ievwc/6
         alsw==
X-Gm-Message-State: AOAM533DD8hyRypSu+C9UPQk327+IGi+K/gsHrYGZKigCanMVjAKyizA
        4WW3ny//clEt3ppzTbE+us7NFQ6dVDw=
X-Google-Smtp-Source: ABdhPJzYvN1g6sszemfIbobHnernHzcSsVEzHckrXunwGJDf/E7pJ1E3lVfO20xFH6sWxoHyQ1YmEA==
X-Received: by 2002:aa7:d3da:: with SMTP id o26mr20950491edr.147.1618262487487;
        Mon, 12 Apr 2021 14:21:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6903:692b:54da:df0c])
        by smtp.gmail.com with ESMTPSA id g11sm7744156edt.35.2021.04.12.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:27 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 8/8] scheck: support pre-conditions via __assume()
Date:   Mon, 12 Apr 2021 23:21:11 +0200
Message-Id: <20210412212111.29186-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A lot of simplifications are only valid when their variables
satisfy to some conditions (like "is within a given range" or
"is a power of two").

So, allow to add such pre-conditions via new _assume() statements.
Internally, all such preconditions are ANDed together and what is
checked is they imply the assertions:
	AND(pre-condition) implies assertion 1
	...

Note: IIUC, it seems that boolector has a native mechanism for such
      things but I'm not sure if t can be used here.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h           |  1 +
 scheck.c               | 33 ++++++++++++++++++++++++---------
 validation/scheck/ok.c |  6 ++++++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 6264fd062534..3c08e8ca9aa4 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -79,6 +79,7 @@ IDENT(copy_to_user); IDENT(copy_from_user);
 IDENT(main);
 
 /* used by the symbolic checker */
+IDENT(__assume);
 IDENT(__assert);
 IDENT(__assert_eq);
 IDENT(__assert_const);
diff --git a/scheck.c b/scheck.c
index f5ea4cf11902..6752b9d9baaf 100644
--- a/scheck.c
+++ b/scheck.c
@@ -31,6 +31,7 @@
 
 #define dyntype incomplete_ctype
 static const struct builtin_fn builtins_scheck[] = {
+	{ "__assume", &void_ctype, 0, { &dyntype }, .op = &generic_int_op },
 	{ "__assert", &void_ctype, 0, { &bool_ctype }, .op = &generic_int_op },
 	{ "__assert_eq", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
 	{ "__assert_const", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
@@ -195,11 +196,22 @@ static void ternop(Btor *btor, struct instruction *insn)
 	insn->target->priv = t;
 }
 
-static bool check_btor(Btor *btor, BoolectorNode *n, struct instruction *insn)
+static bool add_precondition(Btor *btor, BoolectorNode **pre, struct instruction *insn)
+{
+	BoolectorNode *a = get_arg(btor, insn, 0);
+	BoolectorNode *z = boolector_zero(btor, boolector_get_sort(btor, a));
+	BoolectorNode *n = boolector_ne(btor, a, z);
+	BoolectorNode *p = boolector_and(btor, *pre, n);
+	*pre = p;
+	return true;
+}
+
+static bool check_btor(Btor *btor, BoolectorNode *p, BoolectorNode *n, struct instruction *insn)
 {
 	char model_format[] = "btor";
 	int res;
 
+	n = boolector_implies(btor, p, n);
 	boolector_assert(btor, boolector_not(btor, n));
 	res = boolector_sat(btor);
 	switch (res) {
@@ -218,20 +230,20 @@ static bool check_btor(Btor *btor, BoolectorNode *n, struct instruction *insn)
 	return 0;
 }
 
-static bool check_assert(Btor *btor, struct instruction *insn)
+static bool check_assert(Btor *btor, BoolectorNode *pre, struct instruction *insn)
 {
 	BoolectorNode *a = get_arg(btor, insn, 0);
 	BoolectorNode *z = boolector_zero(btor, boolector_get_sort(btor, a));
 	BoolectorNode *n = boolector_ne(btor, a, z);
-	return check_btor(btor, n, insn);
+	return check_btor(btor, pre, n, insn);
 }
 
-static bool check_equal(Btor *btor, struct instruction *insn)
+static bool check_equal(Btor *btor, BoolectorNode *pre, struct instruction *insn)
 {
 	BoolectorNode *a = get_arg(btor, insn, 0);
 	BoolectorNode *b = get_arg(btor, insn, 1);
 	BoolectorNode *n = boolector_eq(btor, a, b);
-	return check_btor(btor, n, insn);
+	return check_btor(btor, pre, n, insn);
 }
 
 static bool check_const(Btor *ctxt, struct instruction *insn)
@@ -250,15 +262,17 @@ static bool check_const(Btor *ctxt, struct instruction *insn)
 	return 0;
 }
 
-static bool check_call(Btor *btor, struct instruction *insn)
+static bool check_call(Btor *btor, BoolectorNode **pre, struct instruction *insn)
 {
 	pseudo_t func = insn->func;
 	struct ident *ident = func->ident;
 
+	if (ident == &__assume_ident)
+		return add_precondition(btor, pre, insn);
 	if (ident == &__assert_ident)
-		return check_assert(btor, insn);
+		return check_assert(btor, *pre, insn);
 	if (ident == &__assert_eq_ident)
-		return check_equal(btor, insn);
+		return check_equal(btor, *pre, insn);
 	if (ident == &__assert_const_ident)
 		return check_const(btor, insn);
 	return 0;
@@ -267,6 +281,7 @@ static bool check_call(Btor *btor, struct instruction *insn)
 static bool check_function(struct entrypoint *ep)
 {
 	Btor *btor = boolector_new();
+	BoolectorNode *pre = boolector_true(btor);
 	struct basic_block *bb;
 	int rc = 0;
 
@@ -294,7 +309,7 @@ static bool check_function(struct entrypoint *ep)
 				ternop(btor, insn);
 				break;
 			case OP_CALL:
-				rc &= check_call(btor, insn);
+				rc &= check_call(btor, &pre, insn);
 				break;
 			case OP_RET:
 				goto out;
diff --git a/validation/scheck/ok.c b/validation/scheck/ok.c
index 8f65013e1618..1e5314f24ded 100644
--- a/validation/scheck/ok.c
+++ b/validation/scheck/ok.c
@@ -10,6 +10,12 @@ static void always(int x)
 	__assert((x - x) == 0);		// true and simplified
 }
 
+static void assumed(int x, int a, int b)
+{
+	__assume((a & ~b) == 0);
+	__assert_eq((x ^ a) | b, x | b);
+}
+
 /*
  * check-name: scheck-ok
  * check-command: scheck $file
-- 
2.31.1

