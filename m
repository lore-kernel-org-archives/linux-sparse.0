Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A465C388F2
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A5E222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PicKUt09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438660AbgJTVK3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438655AbgJTVK3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C615AC0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l16so209762eds.3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjEYSyEHP/cCAYgYjJuRqsmYdgzPPhAhF/vF7dRrgiE=;
        b=PicKUt09RWEe/y1JQnt2NQ/5+typVBlinVH1yW6eiVJ4Kw52chCGAtdum1AenFRfzq
         hvsSu2KkwDWKsV/iHRhtipZZIepXUIb6KrZ/cgdSCkQct6HaUbEBmLXkdiYeuUEco3DY
         ryz+pm2LTjvZQ10nXVZAbDt3EaN8Z5CA6198AtbiowIrJHL+TeMYfZR6DXEqAQJuDuwc
         UwkxoCzUJxQeOAAqLVwCDFVJT0sW/eZU0t3vZMNIkCIeMpZSQAbJiYP/gv+VBURMN3pc
         OMTVivGQ276FBmjA4wrZ8TuMsEwveMayT1mEtcWjXAsPrHGvUdZZSKB7wf3RnSlKbZ85
         rStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjEYSyEHP/cCAYgYjJuRqsmYdgzPPhAhF/vF7dRrgiE=;
        b=Nu3uWBiHj3EEx6hRdOPuPqW2O/+vYAkUWKKeU9mcQStx2oQEM9sIUOpPExMZYn/+UY
         O8MYNzPTxrMckF6wVSJ6uzMfZG09VRe/IjDlxK7Go4QDWNe276eivkMzSS5n6OzLrjU/
         yw4hTc52RC2oiOZcuhtdB4M/Jworux06xyIswl3dU0CUitPTjkNbvLn8oCS/9tnh4Zyo
         joZlJafdMz6Ps1e5T9eeNWvpYt0YMoQoQgH8uWLYPVKdlMrZlbq8cNYtZBAOhzGfvP8N
         7P5VqdgofzTmb+BWe7I4QYu4QVVDwOjJSVGsOgbrQ1fc9/gWzpuU3yfIPtvWDtEWxtTW
         tD0g==
X-Gm-Message-State: AOAM532P3zr/DdkZF4EzyhdQ6w6wXePDnyCJ8eE9DhPcRt0357DwntLz
        u35zVPI4ux4bhSoTWjsZR8m6cPEQia8=
X-Google-Smtp-Source: ABdhPJyCSMRanzq68Awbsa+tdXSknbuHzl6+nLu1W17cPm6Muezj9cLc9wcez1yZ3u9kpu/C6kzvJQ==
X-Received: by 2002:a50:8ad4:: with SMTP id k20mr4909149edk.385.1603228227233;
        Tue, 20 Oct 2020 14:10:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:26 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/22] extract eval_op() from eval_insn()
Date:   Tue, 20 Oct 2020 23:10:02 +0200
Message-Id: <20201020211021.82394-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

eval_insn() can be handy when there is an existing instruction
to evaluate but it can happen that there isn't one, only pseudos.

Allow to reuse the evaluation code by using a new API: eval_op()
extracted from eval_insn() and taking all its input as arguments
(opcode, size, src1 & src2).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/simplify.c b/simplify.c
index edef3a7e5c1e..ac27debfcefb 100644
--- a/simplify.c
+++ b/simplify.c
@@ -516,12 +516,11 @@ static unsigned int operand_size(struct instruction *insn, pseudo_t pseudo)
 	return size;
 }
 
-static pseudo_t eval_insn(struct instruction *insn)
+static pseudo_t eval_op(int op, unsigned size, pseudo_t src1, pseudo_t src2)
 {
 	/* FIXME! Verify signs and sizes!! */
-	unsigned int size = insn->size;
-	long long left = insn->src1->value;
-	long long right = insn->src2->value;
+	long long left = src1->value;
+	long long right = src2->value;
 	unsigned long long ul, ur;
 	long long res, mask, bits;
 
@@ -535,7 +534,7 @@ static pseudo_t eval_insn(struct instruction *insn)
 	ul = left & bits;
 	ur = right & bits;
 
-	switch (insn->opcode) {
+	switch (op) {
 	case OP_ADD:
 		res = left + right;
 		break;
@@ -754,6 +753,11 @@ static int simplify_mask_shift(struct instruction *sh, unsigned long long mask)
 	return 0;
 }
 
+static pseudo_t eval_insn(struct instruction *insn)
+{
+	return eval_op(insn->opcode, insn->size, insn->src1, insn->src2);
+}
+
 static long long check_shift_count(struct instruction *insn, unsigned long long uval)
 {
 	unsigned int size = insn->size;
-- 
2.28.0

