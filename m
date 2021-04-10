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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640B6C433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379D361028
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhDJNbR (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhDJNbP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 09:31:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF1C061764
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:31:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x4so9722617edd.2
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GyhyKuCGDerdGuoNjbX1b5UU6r+UUpK9bAjsPh002U=;
        b=Lfov4o0wSsKkgCwmT00i//X0LmRgtQNOPv8TcIHRS6o4BLlGXDQhMvCnHKCG/CjTBd
         BW8LTLNoXeP8+vqpdMVbT1G8NdUZH+jtJl72iIJvxosDxXOcP9XlaS38IIpPbbdicrsE
         uLUCJefWdsbKJTNGzp9Nd9UaWgHwxFrPP6QPTHyWVzW9WsqK8idBz2MYCtKwX5RpVLA8
         X04hrdlGGCEsyBzXUVmicD0Ikf2EE0l/94bG6pi1AD6N03jydxHrKhiyUtjOdGcYI53F
         6Fe+2l5V5Ngok686brxZ/kgw/FVS9a/A6Ij6mWNjMyGbe5ue/dosELf+WLub4XwRk6ao
         Op0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GyhyKuCGDerdGuoNjbX1b5UU6r+UUpK9bAjsPh002U=;
        b=cAadWSb+Yx864AZAJ0injWnxOZbJxU7GdCYkW+8ozJReW31JZCy0As8S/cfXOio5gb
         y6XtvlaMBkf8Mhxh+2wxlwu6exsiuF4tTZX80ObKk1hMPM7U2tNBleZn8pATXDU3gy+c
         cbBIfysFVqFWa1KhtRBTfpfoPjoyrysBvt+ElDrO5oQ+yTnvpm7p/XMR4KhUTOV5WWvc
         lZi9+YXiFhdytpYh0NpYG4+oicoVTDppOPhQSfIQnF06SSSt9bAqu5ep55HK0jvr98S3
         q3RCVz2nZp2DXXP7zDjTDoZo4mNRRFjr5wfSY3vNGUpt9JF3i+8SC/M7tX9yiIuzE0Kd
         RQNw==
X-Gm-Message-State: AOAM53125rYBeK8xt1R4smDnt25ttBEeEC00ZphkIvc81UgqyAgjyMux
        uaBqG5aflrcIbASRSDokO8dGbgM6h+8=
X-Google-Smtp-Source: ABdhPJxz5c34O3QoJqQn0esRVm8ihzJD7Cd135ks7yNNyKAfmhgFz6bQK9Ck63Ak+2bzlsa85/CYYQ==
X-Received: by 2002:a50:85cd:: with SMTP id q13mr22115272edh.114.1618061459901;
        Sat, 10 Apr 2021 06:30:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f96a:804d:4fe5:372f])
        by smtp.gmail.com with ESMTPSA id g26sm2594910ejz.70.2021.04.10.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:30:59 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/8] scheck: support pre-conditions via __assume()
Date:   Sat, 10 Apr 2021 15:30:45 +0200
Message-Id: <20210410133045.53189-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
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
index ff140aaa1e95..b8bc9bb28498 100644
--- a/scheck.c
+++ b/scheck.c
@@ -31,6 +31,7 @@
 
 #define dyntype incomplete_ctype
 static const struct builtin_fn builtins_scheck[] = {
+	{ "__assume", &void_ctype, 0, { &dyntype }, .op = &generic_int_op },
 	{ "__assert", &void_ctype, 0, { &bool_ctype }, .op = &generic_int_op },
 	{ "__assert_eq", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
 	{ "__assert_const", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
@@ -184,11 +185,22 @@ static void ternop(Btor *btor, struct instruction *insn)
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
@@ -207,20 +219,20 @@ static bool check_btor(Btor *btor, BoolectorNode *n, struct instruction *insn)
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
@@ -239,15 +251,17 @@ static bool check_const(Btor *ctxt, struct instruction *insn)
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
@@ -256,6 +270,7 @@ static bool check_call(Btor *btor, struct instruction *insn)
 static bool check_function(struct entrypoint *ep)
 {
 	Btor *btor = boolector_new();
+	BoolectorNode *pre = boolector_true(btor);
 	struct basic_block *bb;
 	int rc = 0;
 
@@ -281,7 +296,7 @@ static bool check_function(struct entrypoint *ep)
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

