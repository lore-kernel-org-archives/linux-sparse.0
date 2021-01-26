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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737FAC433DB
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A60E206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhA0DqF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbhAZWF3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FFDC0617A7
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:48 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v15so18086287wrx.4
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Tf4QCvFpyAobhU0JFMAJACQeSxWnQofabURU0HmY5I=;
        b=VC2pGgUtWd4hsm1jHOaWSEr+PiNcwjaka1x5WSfbOTGLs7+4os7ySxK+noeVcaRA8m
         SYDNA83fzfXWc5j7kbRNiMekFx+Mgmk4AsPMVWH0XLUQ/9PmzmAbWgBdAbqnjwPS+H0Q
         TNitmErltuUIhP6jVtOvVOkNaVWo1HSyv4E5SuU5JtbhZo52yKzR9r2uEKzFu6qeITVi
         6mxTJxJCtLXrE6AQRZXYpq++qvw34OdRyaPfz21H5SAvT8jmzZITcL1QBwUJWZmKSH0/
         OsMh/9yCrB9BHPLz60BBhBOqGB5zgINZje7k48iK1NyiBUkTFeRQxNDaWlJ8I92+Vv/k
         JBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Tf4QCvFpyAobhU0JFMAJACQeSxWnQofabURU0HmY5I=;
        b=Y5H5mOrII5UuZrpMMcuSQ+Dh3Mv7uNGOCSvN+luAcisWtU3tMvF0Dx29rG/iCa/pVl
         GDdtOIs+zxLvwKeCYS1JB5wXNStA0UoJRQVvpHVZV3BPaB1TOZ/OgF/d0U8iVzCXTjG6
         AjGyUdVktVTtr85+8IgDxKj0tvfYQyebiWDqYMd9S5NMkvrCjVYnsGBZImJMuIVu/M3X
         4qar1xLQfZeTHH0hVxXL6gA6E5FnRsLoF4YtoXRYk+RN6+aI0nwP+od64wgm+RXPcmcI
         IHChT7GJZR5TbBpVzBK37ueMklC7BnHwbNlalM7exaLaEaqKYuA55eUg7IPJmpd/eIJv
         WhdQ==
X-Gm-Message-State: AOAM533PUzpZ6FljP8JYiYAAB6VZFWRBqKZkEOhFwgeOK9pRpMnW/ME2
        g9/8bPK3koKGypW8qt1ODoTKKyjLx3Y=
X-Google-Smtp-Source: ABdhPJxraAXlk0iG5esLm7vrLzAHdXXgXOpf7+D9qjGcifMVJf+uQ+dQDMiLUK35OEzhLQun5mWv6w==
X-Received: by 2002:a05:6000:254:: with SMTP id m20mr8268234wrz.300.1611698687292;
        Tue, 26 Jan 2021 14:04:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:46 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/10] cmps: canonicalize SEL(x > 0, a, -a) --> SEL(x >= 0, a, -a)
Date:   Tue, 26 Jan 2021 23:04:32 +0100
Message-Id: <20210126220432.58265-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When computing the absolute value using an expression like:
	(a > 0) ? a : -a
it's irrelevant to use '>' or '>=', both will give the same
result since 0 is its own negation.

Canonicalize these equivalent expressions, such that OP_GE
is always used.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 14 ++++++++++++++
 validation/optim/canonical-abs.c |  1 -
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 10cdf50dcbf1..584078ddca89 100644
--- a/simplify.c
+++ b/simplify.c
@@ -454,6 +454,13 @@ static inline pseudo_t is_same_op(pseudo_t src, int op, unsigned osize)
 	return def->src;
 }
 
+static bool is_negate_of(pseudo_t p, pseudo_t ref)
+{
+	struct instruction *def;
+
+	return (DEF_OPCODE(def, p) == OP_NEG) && (def->src == ref);
+}
+
 ///
 // replace the operand of an instruction
 // @insn: the instruction
@@ -2308,6 +2315,13 @@ static int simplify_select(struct instruction *insn)
 		// SEL(x {<,<=} y, a, b) --> SEL(x {>=,>} y, b, a)
 		def->opcode = opcode_negate(def->opcode);
 		return switch_pseudo(insn, &insn->src2, insn, &insn->src3);
+	case OP_SET_GT:
+		if (one_use(cond) && is_zero(def->src2)) {
+			if (is_negate_of(src2, src1))
+				// SEL(x > 0, a, -a) --> SEL(x >= 0, a, -a)
+				return replace_opcode(def, OP_SET_GE);
+		}
+		break;
 	case OP_SEL:
 		if (constant(def->src2) && constant(def->src3)) {
 			// Is the def of the conditional another select?
diff --git a/validation/optim/canonical-abs.c b/validation/optim/canonical-abs.c
index 0809a52d445b..1bd6d89a3ad5 100644
--- a/validation/optim/canonical-abs.c
+++ b/validation/optim/canonical-abs.c
@@ -5,7 +5,6 @@ _Bool abs2(int a) { return (a < 0 ? -a : a) == (a <= 0 ? -a : a); }
 /*
  * check-name: canonical-abs1
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

