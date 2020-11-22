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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D2AC63798
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E7D20773
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVDA5BtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgKVP1k (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKVP1j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 10:27:39 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C79AC0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so15517727wmd.4
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47ZLYZ+qbCUuft6A6B4WnAnhMeO/AyT4HtLyQ+HmHkw=;
        b=EVDA5BtIKaAYDN/JUyntLShZ5lqUThJqQXHNXmIXEYWGE4KXEA99wbnh6SHSZziaEg
         3aEbpPaolYbomet2rlfJpVNM+1Si5XvY7v05YKfmo11JyyoDHUVyVmrMUaUPnXRyBVmZ
         aRcNfuVwj81ZkTnDjlJ+pyiiZ8sRQnUnpA8bd/ujLytvA2J5jBlpaK0CTyMIocDiJTjI
         1HVpZiMb23czK2AhDslBk586Hkwdg7nO2Abm97MXTiVgyOppccJ2aNN4PTVbFLnpIpR4
         7IBD+ppXWVQPoXD+BH+25HpqNAD/9n8+hVmaWn93PRUOoUdn+j/oSV2w3Buu/U7fR/SP
         yHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47ZLYZ+qbCUuft6A6B4WnAnhMeO/AyT4HtLyQ+HmHkw=;
        b=uoWIxpFXwXYWonrqBJ7Xuh8WscXGU8/Ub2NN417ww97a9cemqhw5E7nOUNMFHuGibo
         66U99Xv1nW9T7cmzdI02Q6uPGG+fBdC7NYnhbNZRR+CJqhXBDYazhHsYMcPXDBJMeXAe
         iLT0/zJgU8HYar4Qx0TNRiOhNqHUTDOafagjxqF63UqCyvXBmS32Db9Y57e7092Ts9xX
         Zdp5yOod0ZkJzETF82DphzoZ6SJ92z/wfD940pCmmFT6xaVdzx0fkoqhsxCAgfOmadZA
         RxiZzPc1nkGiS0092ARIf2bAxIZ5eEPSctRfjf08/Enw+Gbm2wUTPRIFCxg5xUXme558
         ejBA==
X-Gm-Message-State: AOAM532/KykprsU7wPUILtE1MSFPnNgci6Za6swbeIoMTJ8WTWa/UNfV
        za3OG8KJmrgCBZH6tDToB2EIq5f5XH0=
X-Google-Smtp-Source: ABdhPJxmCz6mxzEJ1Y0VU1/tX4/A7w35SkDoSnWNXb3R8Uh0383fUO0N+tGdu/APFMjwtAPUhq79EQ==
X-Received: by 2002:a1c:a706:: with SMTP id q6mr19228997wme.2.1606058857737;
        Sun, 22 Nov 2020 07:27:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b0e1:b041:18e2:46cf])
        by smtp.gmail.com with ESMTPSA id k1sm13712265wrp.23.2020.11.22.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:27:37 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/7] canon: simplify calculation of canonical order
Date:   Sun, 22 Nov 2020 16:27:28 +0100
Message-Id: <20201122152731.10994-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The calculation of the canonical order is currently somehow
complicated.

Fix this by reordering the definition of the different type of
pseudos so that they are already in canonical order and just
comparing the types to determine the order.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h |  4 ++--
 simplify.c  | 40 +++++++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/linearize.h b/linearize.h
index 31c754e200c2..2c548d43526f 100644
--- a/linearize.h
+++ b/linearize.h
@@ -24,11 +24,11 @@ DECLARE_PTRMAP(phi_map, struct symbol *, pseudo_t);
 enum pseudo_type {
 	PSEUDO_VOID,
 	PSEUDO_UNDEF,
+	PSEUDO_PHI,
 	PSEUDO_REG,
+	PSEUDO_ARG,
 	PSEUDO_SYM,
 	PSEUDO_VAL,
-	PSEUDO_ARG,
-	PSEUDO_PHI,
 };
 
 struct pseudo {
diff --git a/simplify.c b/simplify.c
index ee485798148b..203472972bca 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1462,22 +1462,36 @@ static int switch_pseudo(struct instruction *insn1, pseudo_t *pp1, struct instru
 	return REPEAT_CSE;
 }
 
+///
+// check if the given pseudos are in canonical order
+//
+// The canonical order is VOID < UNDEF < PHI < REG < ARG < SYM < VAL
+// The rationale is:
+//	* VALs at right (they don't need a definition)
+//	* REGs at left (they need a defining instruction)
+//	* SYMs & ARGs between REGs & VALs
+//	* REGs & ARGs are ordered between themselves by their internal number
+//	* SYMs are ordered between themselves by address
+//	* VOID, UNDEF and PHI are uninteresting (but VOID should have type 0)
 static int canonical_order(pseudo_t p1, pseudo_t p2)
 {
-	/* symbol/constants on the right */
-	if (p1->type == PSEUDO_VAL)
-		return p2->type == PSEUDO_VAL;
-
-	if (p1->type == PSEUDO_SYM)
-		return p2->type == PSEUDO_SYM || p2->type == PSEUDO_VAL;
-
-	if (p1->type == PSEUDO_ARG)
-		return (p2->type == PSEUDO_ARG && p1->nr <= p2->nr) || p2->type == PSEUDO_VAL || p2->type == PSEUDO_SYM;
+	int t1 = p1->type;
+	int t2 = p2->type;
 
-	if (p1->type == PSEUDO_REG)
-		return (p2->type == PSEUDO_REG && p1->nr <= p2->nr) || p2->type == PSEUDO_VAL || p2->type == PSEUDO_SYM || p2->type == PSEUDO_ARG;
-
-	return 1;
+	/* symbol/constants on the right */
+	if (t1 < t2)
+		return 1;
+	if (t1 > t2)
+		return 0;
+	switch (t1) {
+	case PSEUDO_SYM:
+		return p1->sym <= p2->sym;
+	case PSEUDO_REG:
+	case PSEUDO_ARG:
+		return p1->nr <= p2->nr;
+	default:
+		return 1;
+	}
 }
 
 static int canonicalize_commutative(struct instruction *insn)
-- 
2.29.2

