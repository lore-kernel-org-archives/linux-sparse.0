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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85311C388F2
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35AE7222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ8KliyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438655AbgJTVKd (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438663AbgJTVKc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290A1C0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:32 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o18so205158edq.4
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9BG0T0Fk+xf6mMz0v9TAptKI5wSrVz7JKXenYDly10=;
        b=iJ8KliyY+XiMXtIQfCecu0qU5v7p1fhaRJl+LqQv9oJqNfoMY3WNjtr15mdEMiFyl5
         HyK/wrnDdJhzIAv52xM/y6/DGGbf0tf+yoJ7DaQOhm7ZO1uLQakIsztY604URn276p1C
         j6kE+BD5f7mkAVy/9BUtL1cg1EhUQJW4KYX7NT50mLSwcDHuO3ULnP8G1D22k+se8xrP
         OgPpCpsi+S0MtUeY6Nt8PX07Cpqnj5uGpvwaZCfIS1lVeec0RXqaCd0rL9Zq+O7wDIkV
         9FDyy9npUTN8aQdThbS897W6UhIOeguxstkde2vN6Ao/ij55MoMDoSIwtd0RuvDB5bgC
         kPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9BG0T0Fk+xf6mMz0v9TAptKI5wSrVz7JKXenYDly10=;
        b=qlYrKYkU+2fxqiCoed/YmX+ivEsBlh5tXQNUzBzXNWOxqDoG5VmqEtRsVtZgojG671
         huSJ/P5f4rlvifJduD8oB17fA5bISrTcySUg4yhtoymdspDVkXTsoJFf22gNrI43sbaT
         fejPARbGJy6AkXS1CefphFOf0qn8zl2xumOheLlZ1PdWrZ22I+XtjREGF63H6KR2kG+Z
         kkSSHTHItaDwdATUsA3S7l3OTq8f7FaElDjV51M6QCRXJhBJeqbeBbVZ3VYCShpinmV7
         MNdysCB9CrHseZ+mVTvrGA0849AgHs4bccmWFe2RQGoF34nM5hVREdrznhPShL5mrJdU
         Zwyg==
X-Gm-Message-State: AOAM530POOvWw1CZCkXlC60gEyUR9uBjK4nWX6HzAS3mue3Gqjt5fdNe
        uyXYdbYHXfVpSLRmEqTVRldYpDl+mK0=
X-Google-Smtp-Source: ABdhPJzUs4hFlOuZQX9n+LfKLHC4+tDAhqeLUcX5c3U7MxPylNT116CFww77cixLvS7zWJI9Aka4Tg==
X-Received: by 2002:aa7:cb82:: with SMTP id r2mr4822440edt.306.1603228230683;
        Tue, 20 Oct 2020 14:10:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:30 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/22] constants must be truncated to the operation's size
Date:   Tue, 20 Oct 2020 23:10:06 +0200
Message-Id: <20201020211021.82394-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

At expansion phase, when simplified, all constants are truncated
to the size of the operations that generate them.

This should be done during simplification too because:
*) if some constants are sometimes truncated and sometimes
   sign-extended, CSE will miss some opportunities.
*) it's not possible to sign-extend them because it's not
   always known if the constant is used in a signed context or not.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                           | 2 +-
 validation/optim/canonical-sub-cte.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index db7a1e47ff0a..3935552bd6fa 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1118,7 +1118,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_SUB:
 		if (value) {
 			insn->opcode = OP_ADD;
-			insn->src2 = value_pseudo(-value);
+			insn->src2 = eval_unop(OP_NEG, insn->size, insn->src2);
 			return REPEAT_CSE;
 		}
 	/* Fall through */
diff --git a/validation/optim/canonical-sub-cte.c b/validation/optim/canonical-sub-cte.c
index 223be96fa5a5..c0072884b1e6 100644
--- a/validation/optim/canonical-sub-cte.c
+++ b/validation/optim/canonical-sub-cte.c
@@ -3,7 +3,6 @@ int sub_cte(int x) { return (x - 1) != (x + -1); }
 /*
  * check-name: canonical-sub-cte
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$0
-- 
2.28.0

