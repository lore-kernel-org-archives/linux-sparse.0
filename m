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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECBFC55179
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589A920885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R705aTou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgKHBTt (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKHBTt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:49 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B148AC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:48 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id dk16so7208835ejb.12
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zaMUEJV+xExPoaM1Wirnt/50amExEEGOj2vjGlf6nU=;
        b=R705aTouU1RIG5H/MATPF5C0lhHPMd32ikw8dmSHjBx1IVhvDCzF24uRfA26/ymX7Y
         2mWkSMNAqMOG6hWJUtEcf2grsMVIWSU5hz8DnKWFX19fC3NiPKkXbBIagxuEGyyT2+wc
         LYI9PHogEvyPRN/yV5qQZYu6DoSfjDdLmVN1gf5nHDn9l9m01rueYm220kDGQXgzMAc+
         5dXVsAJfQ6SWUPxldDZXOdrem+fZda3264aOoZ3LBF9RRRI3IsKeZl2EnSeVE0OQJMyF
         0qiPYa6wN2ZUfShxPQEq230G2Qyy/Q+nv7C8CaaOuJvuvyahyFdQPuCYaXTYFGuCvfju
         Ka7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zaMUEJV+xExPoaM1Wirnt/50amExEEGOj2vjGlf6nU=;
        b=fMrwZI5QDL2sg1zh1gxPSmkT99PRVDxaNPvPeq+DDic34pRGvh+Bls0V3sRiWbdt31
         Q7Oj7cdkyI+fQFchwgYI8htwNUoVS/FyM6WEotTixAylMwxV4GOBDTojtodRH626uwGA
         twWkMZHbQzC3dlZo+biH7g3nyzzM/ukM3OD90YdAIpUqSGvFaqJHHwvg9WBXCEh921uC
         aJKFVF1yGIfOdXcImTPB8fXV1xF+DhYy1AwKhGbsKIsoopNPXJGTXBiHmtCXDRNlw9zN
         dkqMwsbz84geEURZQ0X+yWZ0ePZHZiMpbyUi+wEilMxINRpObxuh+BkbxGjJLetI5t14
         n2fQ==
X-Gm-Message-State: AOAM5336wyI1Q4Ik3MvinoEON8PqtMO5WnbdybHcBgIbnqxEubfB9oyB
        /Igutuu0drK7oJHkrHxpT3MnEZr/z14=
X-Google-Smtp-Source: ABdhPJzcsr9YgAKKf+D8daReCjqNhGlR7KC3D7LUckVS8OyqqdfPsR5IFFqqOYA+9YP/W24HEbehVg==
X-Received: by 2002:a17:906:6949:: with SMTP id c9mr8879413ejs.482.1604798387244;
        Sat, 07 Nov 2020 17:19:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:46 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/16] cmp: move some code in a separate function: simplify_compare_constant()
Date:   Sun,  8 Nov 2020 02:19:34 +0100
Message-Id: <20201108011939.94252-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

simplify_constant_rightside() contains a few simplification
regarding unsigned compares but much more can be done for
unsigned and signed ones.

So, move the current simplification in a separate function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 74 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/simplify.c b/simplify.c
index f2aaa52de84b..3338b72e6845 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1057,6 +1057,43 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 	return 0;
 }
 
+static int simplify_compare_constant(struct instruction *insn, long long value)
+{
+	switch (insn->opcode) {
+	case OP_SET_B:
+		if (!value) {			// (x < 0) --> 0
+			return replace_with_pseudo(insn, value_pseudo(0));
+		} else if (value == 1) {	// (x < 1) --> (x == 0)
+			insn->src2 = value_pseudo(0);
+			insn->opcode = OP_SET_EQ;
+			return REPEAT_CSE;
+		}
+		break;
+	case OP_SET_AE:
+		if (!value) {			// (x >= 0) --> 1
+			return replace_with_pseudo(insn, value_pseudo(1));
+		} else if (value == 1) {	// (x >= 1) --> (x != 0)
+			insn->src2 = value_pseudo(0);
+			insn->opcode = OP_SET_NE;
+			return REPEAT_CSE;
+		}
+		break;
+	case OP_SET_BE:
+		if (!value) {			// (x <= 0) --> (x == 0)
+			insn->opcode = OP_SET_EQ;
+			return REPEAT_CSE;
+		}
+		break;
+	case OP_SET_A:
+		if (!value) {			// (x > 0) --> (x != 0)
+			insn->opcode = OP_SET_NE;
+			return REPEAT_CSE;
+		}
+		break;
+	}
+	return 0;
+}
+
 static int simplify_constant_mask(struct instruction *insn, unsigned long long mask)
 {
 	pseudo_t old = insn->src1;
@@ -1169,37 +1206,12 @@ static int simplify_constant_rightside(struct instruction *insn)
 
 	case OP_SET_NE:
 	case OP_SET_EQ:
-		return simplify_seteq_setne(insn, value);
-	case OP_SET_B:
-		if (!value) {			// (x < 0) --> 0
-			return replace_with_pseudo(insn, value_pseudo(0));
-		} else if (value == 1) {	// (x < 1) --> (x == 0)
-			insn->src2 = value_pseudo(0);
-			insn->opcode = OP_SET_EQ;
-			return REPEAT_CSE;
-		}
-		break;
-	case OP_SET_AE:
-		if (!value) {			// (x >= 0) --> 1
-			return replace_with_pseudo(insn, value_pseudo(1));
-		} else if (value == 1) {	// (x >= 1) --> (x != 0)
-			insn->src2 = value_pseudo(0);
-			insn->opcode = OP_SET_NE;
-			return REPEAT_CSE;
-		}
-		break;
-	case OP_SET_BE:
-		if (!value) {			// (x <= 0) --> (x == 0)
-			insn->opcode = OP_SET_EQ;
-			return REPEAT_CSE;
-		}
-		break;
-	case OP_SET_A:
-		if (!value) {			// (x > 0) --> (x != 0)
-			insn->opcode = OP_SET_NE;
-			return REPEAT_CSE;
-		}
-		break;
+		if ((changed = simplify_seteq_setne(insn, value)))
+			return changed;
+		/* fallthrough */
+	case OP_SET_LT: case OP_SET_LE: case OP_SET_GE: case OP_SET_GT:
+	case OP_SET_B:  case OP_SET_BE: case OP_SET_AE: case OP_SET_A:
+		return simplify_compare_constant(insn, value);
 	}
 	return 0;
 }
-- 
2.29.2

