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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CEEC54FB2
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6606222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atrCvdHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438672AbgJTVKk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438669AbgJTVKj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A2C0613D5
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id h24so4835337ejg.9
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/26ZOzWZHEHfyhnCi+3Azo4PYzP6utiyjC5XgbWCZL0=;
        b=atrCvdHf3rfMCUBq/mGXRJ04Gv3YH/FcJnTcr0igXQirvHJFR+l/88y1T8CnLkGLMB
         QNgH+rKyYAoTOhBmX2fHlXjsGEDfN05v0Ar/NgsH9XeA/oa+LTOuLNwURwfLxqkpDg6D
         H/tdMxwv1tLi4AJOssAHnt2iVgtO+bJUyih+0PsXZewKBl/7I4LpRQ8+fiP3qLR75kmb
         KKmLArEBnRm8OXxn9RX4Fw1NcdpvQxzU/FODUb1LHxESaxY1V7wrE9FrjVj3AmNGY/zp
         wwCalfzvXabTdqrlekt5NVLE6B1170IanEGDyLlAnCTUn/zdFL1fjLZkjZFmeoeAV8Sm
         p1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/26ZOzWZHEHfyhnCi+3Azo4PYzP6utiyjC5XgbWCZL0=;
        b=pZRotVnrPMmmvIgFek/JrflCWrBvO3mfaSrUzMJPSxkhcdT1xR1huvrxhYCuaJLid+
         QEPHXTJMCyCLAs6J2Yx8eaZaOhVWNVTEd5y+r+ffqtrInkstQwhcCwgZw8L+ozgYNb69
         DU1NdhtB84h2LYAsHNA/sd8gfPYAzdswXprwmMUcUL5bfLfO68e5DEorJnrj0Dmarad2
         jXsxgvHhczJBZxjh9/Y1vEMor+MGV+Xn/KGRrZfjpbqPfLG/9R9nqbDRI6iDopQsYTR3
         neBEO8qCC7CYer4Edj+18IglPbSW7C43NGM1tuNpo1hSd+p1ZdeMMPZm9KWjlqBkA0NE
         oGMA==
X-Gm-Message-State: AOAM532j5+/Us9Qb55nRENzDkcc/9BLWXq3FxoWcTDmEn8iyTIHO+VPI
        pLxCyIixOXIL8KpmCsg/bbeCA4f/v/g=
X-Google-Smtp-Source: ABdhPJw2HoVcYY70SAtyxKNjmUdZdEx3kcEOqneLcXoEixij1mE2ZZoFGUixwMlEvRt8lrU2HwPJvA==
X-Received: by 2002:a17:906:3cc:: with SMTP id c12mr118993eja.216.1603228237943;
        Tue, 20 Oct 2020 14:10:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:37 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 16/22] add: simplify (-x + y) --> (y - x)
Date:   Tue, 20 Oct 2020 23:10:15 +0200
Message-Id: <20201020211021.82394-17-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 8 ++++++++
 validation/optim/simplify-neg-add.c | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index f8a0ba726561..187d4fc0c9ab 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1360,9 +1360,17 @@ static int simplify_associative_binop(struct instruction *insn)
 
 static int simplify_add(struct instruction *insn)
 {
+	pseudo_t src1 = insn->src1;
 	pseudo_t src2 = insn->src2;
 	struct instruction *def;
 
+	switch (DEF_OPCODE(def, src1)) {
+	case OP_NEG:				// (-x + y) --> (y - x)
+		switch_pseudo(insn, &insn->src1, insn, &insn->src2);
+		insn->opcode = OP_SUB;
+		return replace_pseudo(insn, &insn->src2, def->src);
+	}
+
 	switch (DEF_OPCODE(def, src2)) {
 	case OP_NEG:				// (x + -y) --> (x - y)
 		insn->opcode = OP_SUB;
diff --git a/validation/optim/simplify-neg-add.c b/validation/optim/simplify-neg-add.c
index 66a820f28069..6223b4f98f3b 100644
--- a/validation/optim/simplify-neg-add.c
+++ b/validation/optim/simplify-neg-add.c
@@ -3,7 +3,6 @@ int neg_add(int x, int y) { return -x + y; }
 /*
  * check-name: simplify-neg-add
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: sub\\..*%arg2, %arg1
-- 
2.28.0

