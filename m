Return-Path: <SRS0=443P=BQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705F8C433E4
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880EA2177B
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+4V5bGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHFTaV (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgHFTaT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Aug 2020 15:30:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75865C061575
        for <linux-sparse@vger.kernel.org>; Thu,  6 Aug 2020 12:30:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so36764289ejb.4
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2020 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3toaiAXWSRg1V40XEAMY9VoV+SxBbxF4Ent4O1/qEE=;
        b=k+4V5bGOT9HV+FUhzk4Ldi9Z7lS/T51lOO7qbwrwStU1PzT7z0pb/P0XOZtfGUHiza
         vEl85U1JgtgPGNzHHbrjUIT8MMEHZZgUQhOmecu79943qVE97GWfteGwKPI4Ev0uoH16
         DAUtJeC5S9hYI6u4ppcANk7JMjsk5jVgUva1jV/mZtKHczMPy3Q450aIAtO+GJouoUxM
         j8C0Dfx8qDpSP+ATTUhpaVitNCqdcECHS4Pnas5+0ifmn4s3jRUy8VbVNto29ROqlgIk
         y6i3aGkhFiymTyVy3qsyIgzAZCFh8sSxITgw2YU3QDT0d5NfwRvYQJb9C9EC/e3ZXkGi
         7Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3toaiAXWSRg1V40XEAMY9VoV+SxBbxF4Ent4O1/qEE=;
        b=L+pyVUmyZ0I9grfQcUCkddCm3dsGWuCnBBP1xWkInJnioW6PRZ5JvYdxppLCxOp7xO
         43E2vbkeJqWG0zg1IWKgPoyVFzGQcnKKGP17SIcr4XaJCKm+1xnrvoFuIni+AtNhG9CW
         rdW958NilyXjO6ZGb8Mlx7r9J7GESjD5hMG8Z8KrKy6bVrVqaALrUGLvCkpyLsao5NPx
         fpA4V844S26CAyPAAOvRdHOTZxcK8mS5BNgcicnJ6rqUrApx2XFGsszWxlcQwZ5blCwI
         R2LIsUGdlNJnPIIdSGh+X7oRg9d9CsMofkfIKB1Znjx8Q5j0ryY63X++wIy6KTJCtyaI
         5d3w==
X-Gm-Message-State: AOAM5315/P7IAiuT1OnWDfLdTZtqNV5LSF1TzlJE6wh46QRRbhYTxPF4
        BqF+XPNDZfABfjPLTGCnk+w1+Dkh
X-Google-Smtp-Source: ABdhPJxQ2YqfQEgxtzbjOA2hgMhQuZhtodti/U1LkSUUfRTrMpajTPaJXFpOPD/HiI1yRhjV9dmo6g==
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr5508484eje.431.1596742216588;
        Thu, 06 Aug 2020 12:30:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:d567:ec52:e0a5:f485])
        by smtp.gmail.com with ESMTPSA id t19sm4055972edw.63.2020.08.06.12.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:30:16 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] bad-shift: wait dead code elimination to warn about bad shifts
Date:   Thu,  6 Aug 2020 21:30:03 +0200
Message-Id: <20200806193003.10144-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
References: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse complains when a shift amount is too big for the size
of its operand or if it's negative.

However, it does this even for expressions that are never evaluated.
It's especially annoying in the kernel for type generic macros,
for example the ones in arch/*/include/asm/cmpxchg.h

So, remove all warnings done at expansion time and avoid any
simplifications of such expressions. Same, at linearization
and optimization time but in this case mark the instructions as
'tainted' to inhibit any further simplifications. Finally, at the
end of the optimization phase, warn for the tainted instructions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c                      | 18 -------------
 linearize.c                   | 44 ++++++++++++++++++++++++++++++++
 simplify.c                    | 20 ++++-----------
 validation/expand/bad-shift.c |  8 +++---
 validation/optim/shift-big.c  | 12 ++++++---
 validation/shift-negative.c   |  4 +--
 validation/shift-undef-long.c |  7 +++--
 validation/shift-undef.c      | 48 +++++++++--------------------------
 8 files changed, 78 insertions(+), 83 deletions(-)

diff --git a/expand.c b/expand.c
index b07893318382..623b180025ad 100644
--- a/expand.c
+++ b/expand.c
@@ -170,22 +170,6 @@ Float:
 	expr->type = EXPR_FVALUE;
 }
 
-static void warn_shift_count(struct expression *expr, struct symbol *ctype, long long count)
-{
-	if (count < 0) {
-		if (!Wshift_count_negative)
-			return;
-		warning(expr->pos, "shift count is negative (%lld)", count);
-		return;
-	}
-	if (ctype->type == SYM_NODE)
-		ctype = ctype->ctype.base_type;
-
-	if (!Wshift_count_overflow)
-		return;
-	warning(expr->pos, "shift too big (%llu) for type %s", count, show_typename(ctype));
-}
-
 /* Return true if constant shift size is valid */
 static bool check_shift_count(struct expression *expr, struct expression *right)
 {
@@ -194,8 +178,6 @@ static bool check_shift_count(struct expression *expr, struct expression *right)
 
 	if (count >= 0 && count < ctype->bit_size)
 		return true;
-	if (!conservative)
-		warn_shift_count(expr, ctype, count);
 	return false;
 }
 
diff --git a/linearize.c b/linearize.c
index 4927468183b0..5a8e74970d98 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2468,6 +2468,49 @@ static pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stm
 	return VOID;
 }
 
+static void check_tainted_insn(struct instruction *insn)
+{
+	unsigned long long uval;
+	long long sval;
+	pseudo_t src2;
+
+	switch (insn->opcode) {
+	case OP_DIVU: case OP_DIVS:
+	case OP_MODU: case OP_MODS:
+		if (insn->src2 == value_pseudo(0))
+			warning(insn->pos, "divide by zero");
+		break;
+	case OP_SHL: case OP_LSR: case OP_ASR:
+		src2 = insn->src2;
+		if (src2->type != PSEUDO_VAL)
+			break;
+		uval = src2->value;
+		if (uval < insn->size)
+			break;
+		sval = sign_extend(uval, insn->size);
+		if (Wshift_count_negative && sval < 0)
+			warning(insn->pos, "shift count is negative (%lld)", sval);
+		else if (Wshift_count_overflow)
+			warning(insn->pos, "shift too big (%llu) for type %s", uval, show_typename(insn->type));
+	}
+}
+
+///
+// issue warnings after all possible DCE
+static void late_warnings(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+	FOR_EACH_PTR(ep->bbs, bb) {
+		struct instruction *insn;
+		FOR_EACH_PTR(bb->insns, insn) {
+			if (!insn->bb)
+				continue;
+			if (insn->tainted)
+				check_tainted_insn(insn);
+		} END_FOR_EACH_PTR(insn);
+	} END_FOR_EACH_PTR(bb);
+}
+
 static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_type)
 {
 	struct statement *stmt = base_type->stmt;
@@ -2514,6 +2557,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	add_one_insn(ep, ret);
 
 	optimize(ep);
+	late_warnings(ep);
 	return ep;
 }
 
diff --git a/simplify.c b/simplify.c
index 7850bcdc6069..f6b79685f439 100644
--- a/simplify.c
+++ b/simplify.c
@@ -754,28 +754,18 @@ static long long check_shift_count(struct instruction *insn, unsigned long long
 	unsigned int size = insn->size;
 	long long sval = uval;
 
+	if (insn->tainted)
+		return -1;
+
 	if (uval < size)
 		return uval;
 
+	insn->tainted = 1;
 	sval = sign_extend_safe(sval, size);
 	sval = sign_extend_safe(sval, bits_in_int);
 	if (sval < 0)
 		insn->src2 = value_pseudo(sval);
-	if (insn->tainted)
-		return sval;
-
-	if (sval < 0 && Wshift_count_negative)
-		warning(insn->pos, "shift count is negative (%lld)", sval);
-	if (sval > 0 && Wshift_count_overflow) {
-		struct symbol *ctype = insn->type;
-		const char *tname;
-		if (ctype->type == SYM_NODE)
-			ctype = ctype->ctype.base_type;
-		tname = show_typename(ctype);
-		warning(insn->pos, "shift too big (%llu) for type %s", sval, tname);
-	}
-	insn->tainted = 1;
-	return sval;
+	return -1;
 }
 
 static int simplify_shift(struct instruction *insn, pseudo_t pseudo, long long value)
diff --git a/validation/expand/bad-shift.c b/validation/expand/bad-shift.c
index 22c4341f1680..b68866c2b048 100644
--- a/validation/expand/bad-shift.c
+++ b/validation/expand/bad-shift.c
@@ -56,9 +56,9 @@ rneg:
  * check-output-end
  *
  * check-error-start
-expand/bad-shift.c:5:18: warning: shift too big (32) for type int
-expand/bad-shift.c:10:18: warning: shift count is negative (-1)
-expand/bad-shift.c:15:18: warning: shift too big (32) for type int
-expand/bad-shift.c:20:18: warning: shift count is negative (-1)
+expand/bad-shift.c:5:21: warning: shift too big (32) for type int
+expand/bad-shift.c:10:21: warning: shift count is negative (-1)
+expand/bad-shift.c:15:21: warning: shift too big (32) for type int
+expand/bad-shift.c:20:21: warning: shift count is negative (-1)
  * check-error-end
  */
diff --git a/validation/optim/shift-big.c b/validation/optim/shift-big.c
index 84bcd2ce01a3..e7bf22fe36ff 100644
--- a/validation/optim/shift-big.c
+++ b/validation/optim/shift-big.c
@@ -50,13 +50,15 @@ lsr31:
 lsr32:
 .L8:
 	<entry-point>
-	ret.32      $0
+	lsr.32      %r14 <- %arg1, $32
+	ret.32      %r14
 
 
 lsr33:
 .L10:
 	<entry-point>
-	ret.32      $0
+	lsr.32      %r17 <- %arg1, $33
+	ret.32      %r17
 
 
 shl31:
@@ -69,13 +71,15 @@ shl31:
 shl32:
 .L14:
 	<entry-point>
-	ret.32      $0
+	shl.32      %r23 <- %arg1, $32
+	ret.32      %r23
 
 
 shl33:
 .L16:
 	<entry-point>
-	ret.32      $0
+	shl.32      %r26 <- %arg1, $33
+	ret.32      %r26
 
 
  * check-output-end
diff --git a/validation/shift-negative.c b/validation/shift-negative.c
index fff5cf123dd6..6df02b18468f 100644
--- a/validation/shift-negative.c
+++ b/validation/shift-negative.c
@@ -9,8 +9,8 @@ unsigned int fo2(unsigned int a) { return a >> ((a & 0) ^ ~0); }
  * check-command: sparse -Wno-decl $file
  *
  * check-error-start
-shift-negative.c:1:45: warning: shift count is negative (-1)
-shift-negative.c:2:45: warning: shift count is negative (-1)
+shift-negative.c:1:48: warning: shift count is negative (-1)
+shift-negative.c:2:48: warning: shift count is negative (-1)
 shift-negative.c:4:59: warning: shift count is negative (-1)
 shift-negative.c:5:59: warning: shift count is negative (-1)
  * check-error-end
diff --git a/validation/shift-undef-long.c b/validation/shift-undef-long.c
index 326267436ec7..985fe4c4c595 100644
--- a/validation/shift-undef-long.c
+++ b/validation/shift-undef-long.c
@@ -13,9 +13,8 @@ static unsigned very_big_shift(unsigned int a)
  * check-command: sparse -m64 $file
  *
  * check-error-start
-shift-undef-long.c:4:16: warning: shift too big (4294967295) for type unsigned int
-shift-undef-long.c:5:16: warning: shift too big (4294967296) for type unsigned int
-shift-undef-long.c:6:16: warning: shift too big (4294967296) for type unsigned int
-shift-undef-long.c:7:16: warning: shift count is negative (-4294967296)
+shift-undef-long.c:4:25: warning: shift count is negative (-1)
+shift-undef-long.c:5:47: warning: shift too big (4294967296) for type unsigned int
+shift-undef-long.c:7:20: warning: shift count is negative (-4294967296)
  * check-error-end
  */
diff --git a/validation/shift-undef.c b/validation/shift-undef.c
index 613c6b95b113..0c7541e9ffd9 100644
--- a/validation/shift-undef.c
+++ b/validation/shift-undef.c
@@ -112,48 +112,24 @@ void hw_write(u32 val)
  * check-command: sparse -Wno-decl $file
  *
  * check-error-start
-shift-undef.c:3:15: warning: shift too big (100) for type int
-shift-undef.c:4:15: warning: shift too big (101) for type unsigned int
-shift-undef.c:5:15: warning: shift too big (102) for type unsigned int
-shift-undef.c:6:15: warning: shift count is negative (-1)
-shift-undef.c:7:15: warning: shift count is negative (-2)
-shift-undef.c:8:15: warning: shift count is negative (-3)
-shift-undef.c:9:25: warning: shift too big (103) for type int
-shift-undef.c:10:25: warning: shift too big (104) for type unsigned int
-shift-undef.c:11:25: warning: shift too big (105) for type unsigned int
-shift-undef.c:12:25: warning: shift count is negative (-4)
-shift-undef.c:13:25: warning: shift count is negative (-5)
-shift-undef.c:14:25: warning: shift count is negative (-6)
-shift-undef.c:15:30: warning: shift too big (106) for type int
-shift-undef.c:16:30: warning: shift too big (107) for type unsigned int
-shift-undef.c:17:30: warning: shift too big (108) for type unsigned int
-shift-undef.c:18:30: warning: shift count is negative (-7)
-shift-undef.c:19:30: warning: shift count is negative (-8)
-shift-undef.c:20:30: warning: shift count is negative (-9)
+shift-undef.c:3:18: warning: shift too big (100) for type int
+shift-undef.c:4:18: warning: shift too big (101) for type unsigned int
+shift-undef.c:5:18: warning: shift too big (102) for type unsigned int
+shift-undef.c:6:19: warning: shift count is negative (-1)
+shift-undef.c:7:19: warning: shift count is negative (-2)
+shift-undef.c:8:19: warning: shift count is negative (-3)
 shift-undef.c:21:29: warning: shift too big (109) for type int
 shift-undef.c:22:29: warning: shift too big (110) for type unsigned int
 shift-undef.c:23:29: warning: shift too big (111) for type unsigned int
 shift-undef.c:24:29: warning: shift count is negative (-10)
 shift-undef.c:25:29: warning: shift count is negative (-11)
 shift-undef.c:26:29: warning: shift count is negative (-12)
-shift-undef.c:32:11: warning: shift too big (100) for type int
-shift-undef.c:33:11: warning: shift too big (101) for type unsigned int
-shift-undef.c:34:11: warning: shift too big (102) for type unsigned int
-shift-undef.c:35:11: warning: shift count is negative (-1)
-shift-undef.c:36:11: warning: shift too big (4294967294) for type unsigned int
-shift-undef.c:37:11: warning: shift too big (4294967293) for type unsigned int
-shift-undef.c:38:25: warning: shift too big (103) for type int
-shift-undef.c:39:25: warning: shift too big (104) for type unsigned int
-shift-undef.c:40:25: warning: shift too big (105) for type unsigned int
-shift-undef.c:41:25: warning: shift count is negative (-4)
-shift-undef.c:42:25: warning: shift too big (4294967291) for type unsigned int
-shift-undef.c:43:25: warning: shift too big (4294967290) for type unsigned int
-shift-undef.c:44:30: warning: shift too big (106) for type int
-shift-undef.c:45:30: warning: shift too big (107) for type unsigned int
-shift-undef.c:46:30: warning: shift too big (108) for type unsigned int
-shift-undef.c:47:30: warning: shift count is negative (-7)
-shift-undef.c:48:30: warning: shift too big (4294967288) for type unsigned int
-shift-undef.c:49:30: warning: shift too big (4294967287) for type unsigned int
+shift-undef.c:32:15: warning: shift too big (100) for type int
+shift-undef.c:33:15: warning: shift too big (101) for type unsigned int
+shift-undef.c:34:15: warning: shift too big (102) for type unsigned int
+shift-undef.c:35:16: warning: shift count is negative (-1)
+shift-undef.c:36:16: warning: shift count is negative (-2)
+shift-undef.c:37:16: warning: shift count is negative (-3)
 shift-undef.c:50:26: warning: shift too big (109) for type int
 shift-undef.c:51:26: warning: shift too big (110) for type unsigned int
 shift-undef.c:52:26: warning: shift too big (111) for type unsigned int
-- 
2.28.0

