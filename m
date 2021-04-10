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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6853BC43462
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4947C61028
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhDJNbO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhDJNbN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 09:31:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CAEC061764
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w23so9685681edx.7
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HY2EdAJWzfL+nIACLIGy1wBD3wzDe0ETwULS8QDsTl4=;
        b=X/FCLJNHoDw8Nked6JYEoBO9Aug/z1Z6GiruU+JDkuWllKTrtST6eeld5b96mjpbDr
         jB9ZCdyqYYNDYdd1DSvc8qMKDSTmMSklbGJA/imxRx4Qfe3+Zm4cKRAcD/cJfNGi0exZ
         jEo19icF+3e/9PzaqsQoTRP9W5tbCgcujnbXBpIqPVKb8RVqVv85HvkFQI+m7k6psmBW
         70eiXCjpYV1HgNopRz4xyj1YT76oY759EW+FsGsygoYBoPhiV7d+ZTEFT+DsxU9EYw35
         4xOWdJZMxscHsuOIfRjwgA23e7WakAovuD5YTFak7rFbNYi2O8vDqUojBIrDcakZT/pn
         PeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HY2EdAJWzfL+nIACLIGy1wBD3wzDe0ETwULS8QDsTl4=;
        b=UHefssHz96eV4aWQbpM7Hqm+JpoZyqxmOIlJsiGtBjkyvMfZL6EPKRfPuMx2MvDcBo
         IwkHplPnU/whqHK/OhWhu1Ju+NTThcu5zszNW9fCaUF7Lb6gXJDZRtOi5j0oj+yYZbUW
         XqGf7OlJDXErg0Peo0dLTR7S1YuZOTiAboZT288Ufq9dkyQ0YMFAigXNSjZbJePVGX+F
         U1SVPt2Y1FzMR227GKrupew34hQlGlLy3VUcAkxX4dJJCJHnWfstisoqkJcbJSF9TK4O
         g2yk4hi8Rok1WO6OrjlyzvVbqWWDZbYesNr5OZx6PxzFrUDAF5XGdgurfNUuVcVZSQW6
         z0xw==
X-Gm-Message-State: AOAM532xvCf/seGRQlqD+7vcRM+9eXEfrwQxHwJZPu/X9eSKCCMvN3ww
        OtHch/Mksu7tl5jC+PfK06pjADq8/wc=
X-Google-Smtp-Source: ABdhPJwk2TKKTwA3G343YNHe13nKilYArXuFbSzofemMFCBpYDEdIqK+e4V4FB7WRkEXlghObEQZPQ==
X-Received: by 2002:aa7:df13:: with SMTP id c19mr21754954edy.370.1618061457206;
        Sat, 10 Apr 2021 06:30:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f96a:804d:4fe5:372f])
        by smtp.gmail.com with ESMTPSA id g26sm2594910ejz.70.2021.04.10.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:30:56 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/8] scheck: assert_eq()
Date:   Sat, 10 Apr 2021 15:30:42 +0200
Message-Id: <20210410133045.53189-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
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
index 719aeea84e7c..ff91328f681a 100644
--- a/scheck.c
+++ b/scheck.c
@@ -32,6 +32,7 @@
 #define dyntype incomplete_ctype
 static const struct builtin_fn builtins_scheck[] = {
 	{ "__assert", &void_ctype, 0, { &bool_ctype }, .op = &generic_int_op },
+	{ "__assert_eq", &void_ctype, 0, { &dyntype, &dyntype }, .op = &generic_int_op },
 	{}
 };
 
@@ -213,6 +214,14 @@ static bool check_assert(Btor *btor, struct instruction *insn)
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
@@ -220,6 +229,8 @@ static bool check_call(Btor *btor, struct instruction *insn)
 
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

