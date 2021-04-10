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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B09C433B4
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946FE61028
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhDJNbQ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJNbP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 09:31:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8CC061762
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:31:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hq27so12888596ejc.9
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGPFV+OYP7ikzGx0Wa0qXJJq6+m5hh+0ZKKsoGUXT48=;
        b=R+hCm/RtuSoyUFjCj01kbdDCzPWkfrDue3l3Zj/o+oTHfj/QgdCSZp5XgLi9fbRlYe
         keFH9rmNbW7yVIT5Kip4jWT9Qe5xzNGWHsDO0FoNfLRwiQn5tW/AX3G3OBRy+GKpUQsX
         JgKq7vnMHMW7N0mCnIADP2BOpESctzitwOPtCWn6N3IN7UoZpSXLq/7OD9v+X1rzLdIC
         UqK5ocyQBsLgqW+N9UgOtmXA3Celdjd3C354Rt69H5CzYz5tuMTNgRQfAaAeRbLLkk4O
         gpF00KkTgFeOUhGT/93G1J8LNJHHoHVRN7DPpSu0fEtuIkmF7SFKvg+XInR0Pera3obu
         s0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGPFV+OYP7ikzGx0Wa0qXJJq6+m5hh+0ZKKsoGUXT48=;
        b=bHxsYHLLEpQz78Uh3U+NFfXrATfMy3UoLm62g8ghyqexdEOuGXYWKVJBZYmVaJOaG6
         s3+c8CFlPbQupC4Ns4uKkiqw7TrOSGH8INFeP3eU6klSOaVMHKOREWg1Lk71W6qRqEZn
         K9U68rkritL1fsmPEmxjO4ignQa7zFV+v2Kv3qkZNp/mEqSdeKxYHGLpY+RHVCNKoOgc
         XHGwBWjQCk+ijycQTdhYzt/so15B/b48dkDvTASVyTM2PKz4MNuui3OjCpVc8//axC6s
         +78/9SAHo3v/wicWX9d/17wOsWEEHPsrMINqj96DlMiZwTS22LEbHVDtVg2p/ctLM6vX
         xe0g==
X-Gm-Message-State: AOAM533qlj9TEyM8yqh9MmGRJygMyS0WlDsqclLovRWxQLpS81wBqzBC
        vsCxD9avOgMtA9z9WJ+5y/kTYpNtnm8=
X-Google-Smtp-Source: ABdhPJx2N/divIMkb99/YYKWFMi1nzbG/tW/oOsirLK6zfff9g3pptUUUxAt3pcKn5ECov0kOERP9A==
X-Received: by 2002:a17:907:16a8:: with SMTP id hc40mr19915401ejc.40.1618061459095;
        Sat, 10 Apr 2021 06:30:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f96a:804d:4fe5:372f])
        by smtp.gmail.com with ESMTPSA id g26sm2594910ejz.70.2021.04.10.06.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:30:58 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/8] scheck: assert_const()
Date:   Sat, 10 Apr 2021 15:30:44 +0200
Message-Id: <20210410133045.53189-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
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
index 26f88a4a028e..ff140aaa1e95 100644
--- a/scheck.c
+++ b/scheck.c
@@ -33,6 +33,7 @@
 static const struct builtin_fn builtins_scheck[] = {
 	{ "__assert", &void_ctype, 0, { &bool_ctype }, .op = &generic_int_op },
 	{ "__assert_eq", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
+	{ "__assert_const", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
 	{}
 };
 
@@ -222,6 +223,22 @@ static bool check_equal(Btor *btor, struct instruction *insn)
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
@@ -231,6 +248,8 @@ static bool check_call(Btor *btor, struct instruction *insn)
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

