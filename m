Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4117EC3E8C5
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086EC21D46
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7e9dNBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgK0W3a (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731701AbgK0W1a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 17:27:30 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257D1C061A48
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:30 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id u10so2497029wmm.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZPOeT52Yy2HDZEE21W3er4FPZopoUAHQvnz+6jw6apU=;
        b=J7e9dNBg9ic9Qae9At2VX68O+AL3Jo52W6j8o3TknS0zPvgFyotkX1/Qljt/b72OX6
         eaz8XxetkgyEoMWxdHo5cFB2SyTGWdLD8C6EssyDQNUnMGIz6luoR2K2608Ds7ZSuqvR
         bNnCIG34kjE9W3SX0OmLQ1zvVdu5Q+Q+2Ps+X1sB5+ZCx/P0GMmjdKu84/mM52XcVzBo
         xC8Lmls5WOt4LJwoDmYxx+9MJOxSr1NE8rGLZ2zPQ03juCqCXew90VZOIabiQ9dg5PpM
         pXgeAEqis1Vg6Nf/XGMvRqofbFI/gkdSevfeWztm30zCMl5rO1wHMrXCakSKefA8+V2I
         RTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPOeT52Yy2HDZEE21W3er4FPZopoUAHQvnz+6jw6apU=;
        b=W5qGh6m1KQW9Idx5A7jvUG8WjTMgL7+7GtJPtdLFZ8CHg/Ob0urYaVbdIMJceJfyzT
         +T4WWVFt5xip874/lIdw+wDVc+ko/cezOMTefEBPICwygIqnMB5UQIlcyeFuYhKvFKnV
         iXDrpYiDslprkNN5DCB22l/tDqnSkfgZBhKuoDK85QJe3983g3vS4qd+xxfb2vnTqV2o
         LfzWMesrOxPsKTu5f5GKoGpsaVVSRgGS9TjtZuQVcaRteiq4o5UN4GaZ8ff45mFA56UD
         b/y41tjDtuzLUjOPyWABwfPNI1Xok7Xvgi5CtBdAJYv8XpNat/rkWioEZImc6aOkZhag
         PqbA==
X-Gm-Message-State: AOAM533ZMg4uGNNebkynpon46gpsboTxSvydWR9ruublelPRwAJh+nvR
        DpJfNGOHmHgSMKXFeVUH758hnk2pBl4=
X-Google-Smtp-Source: ABdhPJzjZ9bCy0D/GvkrTNC00Dvlo4yYzMrItxFy9LzCTLsQM7w83tGQJwZky6j/wLLeYrpR61CBYQ==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr11411474wma.105.1606516048617;
        Fri, 27 Nov 2020 14:27:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f469:b93b:e449:cc30])
        by smtp.gmail.com with ESMTPSA id q16sm17347050wrn.13.2020.11.27.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 14:27:28 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/6] convert SEL(x & BIT1, BIT2, 0) into SHIFT(x & BIT1, S)
Date:   Fri, 27 Nov 2020 23:25:15 +0100
Message-Id: <20201127222516.44915-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
 <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Convert an expression like:
	(x & (1 << A)) ? (1 << B) : 0
into:
	(x & (1 << A)) << (B - A)
or:
	(x & (1 << A)) >> (A - B)

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 15 +++++++++++++++
 validation/optim/select-and-shift.c |  1 -
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 0d9391e21a56..fc64e5b77adf 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2271,6 +2271,21 @@ static int simplify_select(struct instruction *insn)
 			// both values must be non-zero
 			return replace_with_pseudo(insn, src1);
 		}
+	case OP_AND:
+		if (is_pow2(def->src2) && is_pow2(src1) && is_zero(src2) && insn->size == def->size && one_use(cond)) {
+			unsigned s1 = log2_exact(def->src2->value);
+			unsigned s2 = log2_exact(insn->src2->value);
+			unsigned shift;
+
+			if (s1 == s2)
+				return replace_with_pseudo(insn, cond);
+
+			// SEL(x & A, B, 0) --> SHIFT(x & A, S)
+			insn->opcode = (s1 < s2) ? OP_SHL : OP_LSR;
+			shift = (s1 < s2) ? (s2 - s1) : (s1 - s2);
+			insn->src2 = value_pseudo(shift);
+			return REPEAT_CSE;
+		}
 		break;
 	}
 
diff --git a/validation/optim/select-and-shift.c b/validation/optim/select-and-shift.c
index fbe044c7cb44..5313fe4b1d86 100644
--- a/validation/optim/select-and-shift.c
+++ b/validation/optim/select-and-shift.c
@@ -11,7 +11,6 @@ int bar(int p) { return ((p & B) ? A : 0) == ((((unsigned)p) & B) >> S); }
 /*
  * check-name: select-and-shift
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

