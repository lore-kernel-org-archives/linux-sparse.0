Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FBDC433DB
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE23206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhA0DpX (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbhAZWFV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:21 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD6AC061786
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h9so7855413wrr.9
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dSeTy0FpRyAvUeb4DXxdtoKChR3B565ZqYajK810Tw=;
        b=MjRiF5hsUvC6EpG9WNSkxB1Xv4Fnp/tOqy8vc5ECvJekPu+c0KLL8EOHNKeE+GCY83
         gffA7X/c7qv4DpmFdlsIOw2FSdh/EBo1rf4HD1RsXp2fKiTPxRw4X6nEldengZJ8JTMU
         e9PzyG7p5fUxDKt/XCCipy7f3JkTBMQARXYOY4lb5zSowYa7eXh83Ilg8pHO+mJcWE2V
         knqL4UIP0vtmwHfooHmh/q3paM2APRKsbjuFkrnRg2wuLSvKGSQ60kQU36Qxcb6/LNsg
         Dz0Kt1UF1Mn6YnCWA7mM1k8HFcMOE80RUdpmHY/IHtEauMHiRto/VoQV0neLCpwSkDXF
         GLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dSeTy0FpRyAvUeb4DXxdtoKChR3B565ZqYajK810Tw=;
        b=jxJNrYH5FArl48IRR3Kap2BvYvh9Ly/VJtS83jVy66iMsmOGHu7T+lh7StYNfFba3v
         UwAPpAjOpajKaKbIOUysaFlXkvqq5M8NpVjCAMSOgbOuhv7MDNtncH5ST0CARAPSq/Q0
         iPb+roT5FQ19vPcbHa/h1UXt00zxdz7J3DLQBfaOHiGatZBzmZ57vixtyJY9lNFKwhta
         8dXb3Yb+y2fSGgyyctauO7Lc3T2yEFecstQI9iUZEJ0xYd6ohjscLgfsBaR7c78zlDmR
         ICTfk2JER/1B/thphwBM+FUt4vP7yDZPo35JRo2sbXEoSAQQOtLV/kG3+zjj8YOjdHi5
         Civg==
X-Gm-Message-State: AOAM532Q+xbdsWGAAlt4fZgh4ta1xKR2BXURqXDKuqNmr+/LefSRYcU+
        F6JZccxulV/3fFx2nxqHEMd4QrCThuw=
X-Google-Smtp-Source: ABdhPJyFmfj7tnR57HsqiGnn2wtM7Uq2xkIw1r7hahV+Rrtu8nWONtZ9+ZoEkVgAnCtdsBkfc5h3qQ==
X-Received: by 2002:adf:814f:: with SMTP id 73mr8249739wrm.368.1611698678940;
        Tue, 26 Jan 2021 14:04:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:38 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/10] cmps: fix simplification of sext(x) + signed compare of {SMAX,SMIN}
Date:   Tue, 26 Jan 2021 23:04:24 +0100
Message-Id: <20210126220432.58265-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Commit a1c1b9236d5d ("cmp: simplify sext(x) cmps {SMAX,SMIN}")
had a double error (wrong size and wrong compare direction) which
was hidden because of too narrow testcases.

So, fix the simplification and extend the testcases.

Fixes: a1c1b9236d5d4af1681a45ced26f8350bd7721c2
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       |  4 +--
 validation/optim/cmp-sext-simm.c | 46 ++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/simplify.c b/simplify.c
index 2f6f41c249dc..9a24058f6e55 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1239,13 +1239,13 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			}
 			break;
 		case OP_SET_LT: case OP_SET_LE:
-			if (value >= sign_bit(osize))
+			if (value < sign_bit(size))
 				return replace_with_value(insn, 1);
 			else
 				return replace_with_value(insn, 0);
 			break;
 		case OP_SET_GE: case OP_SET_GT:
-			if (value >= sign_bit(osize))
+			if (value < sign_bit(size))
 				return replace_with_value(insn, 0);
 			else
 				return replace_with_value(insn, 1);
diff --git a/validation/optim/cmp-sext-simm.c b/validation/optim/cmp-sext-simm.c
index a8b2a8f9feff..57a4df1d57b1 100644
--- a/validation/optim/cmp-sext-simm.c
+++ b/validation/optim/cmp-sext-simm.c
@@ -4,21 +4,45 @@
 
 static int lt_ge0(int x) { return (sext(x) <  (POS + 0)) == 1; }
 static int lt_ge1(int x) { return (sext(x) <  (POS + 1)) == 1; }
+static int lt_ge2(int x) { return (sext(x) <  (POS + 2)) == 1; }
+static int lt_gex(int x) { return (sext(x) <  (POS<< 1)) == 1; }
+static int lt_gey(int x) { return (sext(x) <  (POS<< 3)) == 1; }
 static int le_ge0(int x) { return (sext(x) <= (POS + 0)) == 1; }
 static int le_ge1(int x) { return (sext(x) <= (POS + 1)) == 1; }
-static int lt_lt0(int x) { return (sext(x) <  (NEG - 0)) == 1; }
-static int lt_lt1(int x) { return (sext(x) <  (NEG - 1)) == 1; }
-static int le_lt0(int x) { return (sext(x) <= (NEG - 0)) == 1; }
-static int le_lt1(int x) { return (sext(x) <= (NEG - 1)) == 1; }
-
-static int gt_ge0(int x) { return (sext(x) >  (POS + 0)) == 0; }
-static int gt_ge1(int x) { return (sext(x) >  (POS + 1)) == 0; }
+static int le_ge2(int x) { return (sext(x) <= (POS + 2)) == 1; }
+static int le_gex(int x) { return (sext(x) <= (POS<< 1)) == 1; }
+static int le_gey(int x) { return (sext(x) <= (POS<< 3)) == 1; }
 static int ge_ge0(int x) { return (sext(x) >= (POS + 0)) == 0; }
 static int ge_ge1(int x) { return (sext(x) >= (POS + 1)) == 0; }
-static int gt_lt0(int x) { return (sext(x) >  (NEG - 0)) == 0; }
-static int gt_lt1(int x) { return (sext(x) >  (NEG - 1)) == 0; }
-static int ge_lt0(int x) { return (sext(x) >= (NEG - 0)) == 0; }
-static int ge_lt1(int x) { return (sext(x) >= (NEG - 1)) == 0; }
+static int ge_ge2(int x) { return (sext(x) >= (POS + 2)) == 0; }
+static int ge_gex(int x) { return (sext(x) >= (POS<< 1)) == 0; }
+static int ge_gey(int x) { return (sext(x) >= (POS<< 3)) == 0; }
+static int gt_ge0(int x) { return (sext(x) >  (POS + 0)) == 0; }
+static int gt_ge1(int x) { return (sext(x) >  (POS + 1)) == 0; }
+static int gt_ge2(int x) { return (sext(x) >  (POS + 2)) == 0; }
+static int gt_gex(int x) { return (sext(x) >  (POS<< 1)) == 0; }
+static int gt_gey(int x) { return (sext(x) >  (POS<< 3)) == 0; }
+
+static int lt_lt0(int x) { return (sext(x) <  (NEG - 0)) == 0; }
+static int lt_lt1(int x) { return (sext(x) <  (NEG - 1)) == 0; }
+static int lt_lt2(int x) { return (sext(x) <  (NEG - 2)) == 0; }
+static int lt_ltx(int x) { return (sext(x) <  (NEG<< 1)) == 0; }
+static int lt_lty(int x) { return (sext(x) <  (NEG<< 3)) == 0; }
+static int le_lt0(int x) { return (sext(x) <= (NEG - 0)) == 0; }
+static int le_lt1(int x) { return (sext(x) <= (NEG - 1)) == 0; }
+static int le_lt2(int x) { return (sext(x) <= (NEG - 2)) == 0; }
+static int le_ltx(int x) { return (sext(x) <= (NEG<< 1)) == 0; }
+static int le_lty(int x) { return (sext(x) <= (NEG<< 3)) == 0; }
+static int ge_lt0(int x) { return (sext(x) >= (NEG - 0)) == 1; }
+static int ge_lt1(int x) { return (sext(x) >= (NEG - 1)) == 1; }
+static int ge_lt2(int x) { return (sext(x) >= (NEG - 2)) == 1; }
+static int ge_ltx(int x) { return (sext(x) >= (NEG<< 1)) == 1; }
+static int ge_lty(int x) { return (sext(x) >= (NEG<< 3)) == 1; }
+static int gt_lt0(int x) { return (sext(x) >  (NEG - 0)) == 1; }
+static int gt_lt1(int x) { return (sext(x) >  (NEG - 1)) == 1; }
+static int gt_lt2(int x) { return (sext(x) >  (NEG - 2)) == 1; }
+static int gt_ltx(int x) { return (sext(x) >  (NEG<< 1)) == 1; }
+static int gt_lty(int x) { return (sext(x) >  (NEG<< 3)) == 1; }
 
 /*
  * check-name: cmp-sext-simm
-- 
2.30.0

