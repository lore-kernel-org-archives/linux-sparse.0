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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C6C64E90
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BEB20795
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ82w8cJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbgK0QwJ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbgK0QwJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 11:52:09 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20453C0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:09 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so6232920wrx.5
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96qxitp+mIBbRdtkL3noBukHAsCzdBuvulBjmwV/Mdk=;
        b=kQ82w8cJGzYR4BOO/TUy2nPfcphMBwHRNfNnMObDYdnw1qUteLBALkoyUqU0L0zLnN
         TwrSNdB/Pr92Cp10sI7G3NuuzWL0r02QJtCNnNE7XioH6VVrlLe4qK9lGQ6YIN5e/jG3
         UrALrElfdCmFYsCaEYwb75agda3LoLx7XblbTcY4D/CWV7Lf5piKYKfLnNuRodSDu0UR
         HI7+c4crVHqmomo9uN8HqEmYPzHK/lKm67WEW+6wL/U+pKmOh/8REz1DsKOiWqP7enQy
         T3AAap7+qFOkoQ3FQP9QZZOS+YMk98RMMnyDXxrwH+op1KHIUdrgw1s8lJEUZ5+FDX/4
         kkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96qxitp+mIBbRdtkL3noBukHAsCzdBuvulBjmwV/Mdk=;
        b=o5667zcv/s3R2OGA+xzGQicNIUyRAARiiVLB9HZUbLSEK5xlxrz3kOc15hbC+LruHK
         KWDUTw28//sVVLxgoE//IToIUAT1d9eVUOVFq4zUvLbW47BMYU08h/lfZIpJUxRRfzxi
         w1aYnujtmTAdnR+iiqByrYrnMyctzWRkpcvEuS8oE8/CnulIjp4YBGwyVGntiLqMq5Fh
         7QL0YI1j1vPLPC2HD8Mj9l6rpAePBz0hM8+uM4WVgLoeCQj5XLoy7By7rUzA6XtWMtHy
         vJ7S/LpGZ42kOFJBB23tf1AAvWj70TjFWT2aUIT3sVDBmeI3zOdn9fh9BUgZDRNq9fUA
         JgJA==
X-Gm-Message-State: AOAM531cVLgUFrUUU5vum0D1vljmeZYe1dDsjhNa28s60rSPUICzVg3Y
        9JZMlRaqPemNlv4JMFdcWgFs8tvHkeU=
X-Google-Smtp-Source: ABdhPJwv5UssDcv1qqHbIYqwdgzKNlyBi9e0vUyxMdN54eosDiKAUSinlK7P5GXanBf6lLe+igDmIg==
X-Received: by 2002:adf:de05:: with SMTP id b5mr11819695wrm.131.1606495927593;
        Fri, 27 Nov 2020 08:52:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e9bd:38ae:745f:40ea])
        by smtp.gmail.com with ESMTPSA id y2sm15895539wrn.31.2020.11.27.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:52:07 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/8] factorize (x OP1 z) OP2 (y OP1 z) into (x OP2 y) OP1 z
Date:   Fri, 27 Nov 2020 17:49:49 +0100
Message-Id: <20201127164950.41517-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
References: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Factorize common distributive operations:
	(x * z) + (y * z) --> (x + y) * z
	(x | z) & (y | z) --> (x & y) | z
	(x & z) | (y & z) --> (x | y) & z
	(x & z) ^ (y & z) --> (x ^ y) & z

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                      | 78 +++++++++++++++++++++++++++++++++
 validation/optim/fact-add-mul.c |  1 -
 validation/optim/fact-and-ior.c |  1 -
 validation/optim/fact-ior-and.c |  1 -
 validation/optim/fact-xor-and.c |  1 -
 5 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/simplify.c b/simplify.c
index 5174a903dfd6..319112a90b7b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1622,11 +1622,32 @@ static int simplify_associative_binop(struct instruction *insn)
 
 static int simplify_add_one_side(struct instruction *insn, pseudo_t *p1, pseudo_t *p2)
 {
+	struct instruction *defr = NULL;
 	struct instruction *def;
 	pseudo_t src1 = *p1;
 	pseudo_t src2 = *p2;
 
 	switch (DEF_OPCODE(def, src1)) {
+	case OP_MUL:
+		if (DEF_OPCODE(defr, *p2) == OP_MUL) {
+			if (defr->src2 == def->src2 && can_move_to(def->src2, defr)) {
+				// ((x * z) + (y * z)) into ((x + y) * z)
+				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
+				return REPEAT_CSE;
+			}
+			if (defr->src1 == def->src1 && can_move_to(def->src1, defr)) {
+				// ((z * x) + (z * y)) into ((x + y) * z)
+				swap_insn(insn, defr, def->src2, defr->src2, def->src1);
+				return REPEAT_CSE;
+			}
+			if (defr->src1 == def->src2 && can_move_to(def->src1, defr)) {
+				// ((x * z) + (z * y)) into ((x + y) * z)
+				swap_insn(insn, defr, def->src1, defr->src2, def->src2);
+				return REPEAT_CSE;
+			}
+		}
+		break;
+
 	case OP_NEG:				// (-x + y) --> (y - x)
 		return replace_binop(insn, OP_SUB, &insn->src1, src2, &insn->src2, def->src);
 
@@ -1714,6 +1735,25 @@ static int simplify_and_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 				return replace_with_value(insn, 0);
 		}
 		break;
+	case OP_OR:
+		if (DEF_OPCODE(defr, *p2) == OP_OR) {
+			if (defr->src2 == def->src2 && can_move_to(def->src2, defr)) {
+				// ((x | z) & (y | z)) into ((x & y) | z)
+				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
+				return REPEAT_CSE;
+			}
+			if (defr->src1 == def->src1 && can_move_to(def->src1, defr)) {
+				// ((z | x) & (z | y)) into ((x & y) | z)
+				swap_insn(insn, defr, def->src2, defr->src2, def->src1);
+				return REPEAT_CSE;
+			}
+			if (defr->src1 == def->src2 && can_move_to(def->src1, defr)) {
+				// ((x | z) & (z | y)) into ((x & y) | z)
+				swap_insn(insn, defr, def->src1, defr->src2, def->src2);
+				return REPEAT_CSE;
+			}
+		}
+		break;
 	}
 	return 0;
 }
@@ -1730,6 +1770,25 @@ static int simplify_ior_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 	pseudo_t src1 = *p1;
 
 	switch (DEF_OPCODE(def, src1)) {
+	case OP_AND:
+		if (DEF_OPCODE(defr, *p2) == OP_AND) {
+			if (defr->src2 == def->src2 && can_move_to(def->src2, defr)) {
+				// ((x & z) | (y & z)) into ((x | y) & z)
+				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
+				return REPEAT_CSE;
+			}
+			if (defr->src1 == def->src1 && can_move_to(def->src1, defr)) {
+				// ((z & x) | (z & y)) into ((x | y) & z)
+				swap_insn(insn, defr, def->src2, defr->src2, def->src1);
+				return REPEAT_CSE;
+			}
+			if (defr->src1 == def->src2 && can_move_to(def->src1, defr)) {
+				// ((x & z) | (z & y)) into ((x | y) & z)
+				swap_insn(insn, defr, def->src1, defr->src2, def->src2);
+				return REPEAT_CSE;
+			}
+		}
+		break;
 	case OP_NOT:
 		if (def->src == *p2)
 			return replace_with_value(insn, bits_mask(insn->size));
@@ -1756,6 +1815,25 @@ static int simplify_xor_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 	pseudo_t src1 = *p1;
 
 	switch (DEF_OPCODE(def, src1)) {
+	case OP_AND:
+		if (DEF_OPCODE(defr, *p2) == OP_AND) {
+			if (defr->src2 == def->src2 && can_move_to(def->src2, defr)) {
+				// ((x & z) ^ (y & z)) into ((x ^ y) & z)
+				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
+				return REPEAT_CSE;
+			}
+			if (defr->src1 == def->src1 && can_move_to(def->src1, defr)) {
+				// ((z & x) ^ (z & y)) into ((x ^ y) & z)
+				swap_insn(insn, defr, def->src2, defr->src2, def->src1);
+				return REPEAT_CSE;
+			}
+			if (defr->src1 == def->src2 && can_move_to(def->src1, defr)) {
+				// ((x & z) ^ (z & y)) into ((x ^ y) & z)
+				swap_insn(insn, defr, def->src1, defr->src2, def->src2);
+				return REPEAT_CSE;
+			}
+		}
+		break;
 	case OP_NOT:
 		if (def->src == *p2)
 			return replace_with_value(insn, bits_mask(insn->size));
diff --git a/validation/optim/fact-add-mul.c b/validation/optim/fact-add-mul.c
index 48c3d656accc..9da6d71c9a7d 100644
--- a/validation/optim/fact-add-mul.c
+++ b/validation/optim/fact-add-mul.c
@@ -21,7 +21,6 @@ int fn_bxa(int b, int x, int a) { return ((x * b) + (a * x)) == ((b + a) * x); }
 /*
  * check-name: fact-add-mul
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/optim/fact-and-ior.c b/validation/optim/fact-and-ior.c
index f2a78eddf41d..96466616d877 100644
--- a/validation/optim/fact-and-ior.c
+++ b/validation/optim/fact-and-ior.c
@@ -21,7 +21,6 @@ int fn_bxa(int b, int x, int a) { return ((x | b) & (a | x)) == ((b & a) | x); }
 /*
  * check-name: fact-and-ior
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/optim/fact-ior-and.c b/validation/optim/fact-ior-and.c
index 7af89df1e1f0..a6ad3c45515d 100644
--- a/validation/optim/fact-ior-and.c
+++ b/validation/optim/fact-ior-and.c
@@ -21,7 +21,6 @@ int fn_bxa(int b, int x, int a) { return ((x & b) | (a & x)) == ((b | a) & x); }
 /*
  * check-name: fact-ior-and
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/optim/fact-xor-and.c b/validation/optim/fact-xor-and.c
index 905cbf4ab659..62232b29da40 100644
--- a/validation/optim/fact-xor-and.c
+++ b/validation/optim/fact-xor-and.c
@@ -21,7 +21,6 @@ int fn_bxa(int b, int x, int a) { return ((x & b) ^ (a & x)) == ((b ^ a) & x); }
 /*
  * check-name: fact-xor-and
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

