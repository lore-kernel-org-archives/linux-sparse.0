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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D469FC433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F78964EBE
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhBUWgU (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhBUWgS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:36:18 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C08C061793
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:35:00 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u20so25515747ejb.7
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9nMWVEoxwtXF283A8tddKxyHk0BWKf9Ft8bmoloBW4=;
        b=LLSQKlBlbq2536UjQAIMDXX7bRKsQlEiCYEbVorLr131hnoQN7BbxIuCJKDl/KjMk8
         HC+LYvwh9m4f+h1OdhOUgUNYVbkhfcpHk58Rb2H5ZzKRoVJTgYiQGt8Zpn3sm8AJEBJD
         Kz0aFI6NYW1/v79PWT0n9IK6LvJunkctPr+piNbinc1P+Oyx6uDpoNzwnVD+Z/r7Q3Ya
         bxYyfee9aCxjklR4zhQwtffT89jbrDscKxS1Hq4azoWWA6c5B61Ob2JAMMs4EHPjGP1b
         4RtIqAbsANWhWHi4YDA0ey9pp820x2te+xdjKNcq4oVGFwdEypmloaasA+ozKzpiQ8Tb
         H4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9nMWVEoxwtXF283A8tddKxyHk0BWKf9Ft8bmoloBW4=;
        b=Z64hYO/RMoxOpzuxaCcz+j4ePb3kObJPehxs6rz0wSGcMjnbtfJI6FBzIs9Lu1Kq9k
         gzUIiZ1bYiiRhXTX0G3bUW1ubmiNYgsUETwphoocG/ygT70ij8PjGt3s4BR7Ldq0zKzP
         YcGMt/K+7LrRjmQgUGKxjGHayAnIMOAaE2KYX4Sm5a0ZMsBawAzDjPaEnGfNPe/aw2mN
         mkBHI60eX+s/V1hFD93USbhrzsI2kHZq4p+cR5/Xf/Z4YVRXjv+2nvpjJPjRAQUdF/c4
         dGeadVigjowa1ZSehcZ6zwthlRHuU3D/syz4I1mW0ryaDCblOTUZu/pYMEYs3ebGen5w
         Jijg==
X-Gm-Message-State: AOAM5325FK1A88OMhXu8AiXa6Xqk6yeDTu7bgljtaAEKDq4JBB2FtSc4
        3ER6qlyFIW3gF8r+11YLmqYuO3yvqb4=
X-Google-Smtp-Source: ABdhPJzWPLwo+phI9cdlcfc2krmuPqAMRLFt+8uRXBpwPsUJERPGbsJS3o4fVoBGgGFtwFQFrwLdGw==
X-Received: by 2002:a17:906:b24c:: with SMTP id ce12mr16894666ejb.278.1613946899590;
        Sun, 21 Feb 2021 14:34:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id p2sm10433622edm.94.2021.02.21.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:34:59 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] asm-mem: teach dominates() about OP_ASM
Date:   Sun, 21 Feb 2021 23:34:52 +0100
Message-Id: <20210221223452.8075-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
References: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The function dominates() needs to know if an OP_ASM instruction
may modify.

Use the information now available in the instruction to return
the answer.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                           | 6 ++++++
 validation/mem2reg/asm-reload0.c | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/flow.c b/flow.c
index 5751ce756518..5d63018798d6 100644
--- a/flow.c
+++ b/flow.c
@@ -495,6 +495,12 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 		return local ? 0 : -1;
 	case OP_LOAD: case OP_STORE:
 		break;
+	case OP_ASM:
+		if (dom->clobber_memory)
+			return -1;
+		if (dom->output_memory)
+			return -1;
+		return 0;
 	default:
 		return 0;
 	}
diff --git a/validation/mem2reg/asm-reload0.c b/validation/mem2reg/asm-reload0.c
index c9e297dde428..ce1829e02724 100644
--- a/validation/mem2reg/asm-reload0.c
+++ b/validation/mem2reg/asm-reload0.c
@@ -8,7 +8,6 @@ static int asm_reload(void)
 /*
  * check-name: asm-reload0
  * check-command: test-linearize $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: load\\.
-- 
2.30.0

