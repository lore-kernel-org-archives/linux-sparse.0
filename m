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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA024C4363A
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60567222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIykSK0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438661AbgJTVKb (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438655AbgJTVKa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37EC0613D3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:30 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x1so220498eds.1
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhsbTb2B2UkeTJ+THBEHNNlvCZXBHrRKAKzi5oHMMoU=;
        b=XIykSK0en++at4r1p/oMh7hotykFLnvSSI9aPWgcgo9HwuGa1Dhnw80vL0PLxxvuXy
         5EsVJ5hflPJSDZqR23hceJw3AGyfQlSVbDLoUH59h1cZ9NulQUph0JAPQ/p8IzeAazSQ
         cKbnbVVFx9kdCmZh3Gs6xUlkSiUBqhHc7hT+vjE141s8G71lrhbN74TyFlJMCoB11KrJ
         +gZvLn4EV3XWK/W/VKAFa6RJ4SCPwKPKq26g0mJBOx3F9dQRsPWnWFbi/PCaXhJFRGVY
         noqWdwnaOgYsSIpFnpS1SakW8dxVNq70vaw80L81uAOMaYeW81LltbYA9VBonwxdGHM9
         kOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhsbTb2B2UkeTJ+THBEHNNlvCZXBHrRKAKzi5oHMMoU=;
        b=es95pRhrIP7J++RtAty6W8UXISC/yFiYREgjGlnc73hacOjwuf2Z8pNp42eIYz6NdB
         6aUJnDZCKbXDuLMt9r0yTKxM64n0Z24GGLkDipRA3bYvZNjOzS+p/Oycg9WP7fgfmLlu
         svStivDArdQhOYNivnorPv+Tdt4Vw5/AhjT84R6T5TeSRnbjZac2Zn0r8flFZQe/5Co3
         NcelL3XywQoDDM1b/jSuskw8UwtKQT+uF27IugabTW9MsCvInvr5pKwyTOQ9i5aC9pyy
         JCKNfvfrLnTQ38q3KEjPNmuDtpbNWEM+MWSGxaG31qSXrZdrOiES0hQR2MGzbhdkTvuK
         0uag==
X-Gm-Message-State: AOAM531O48TqHbONa/IuDgU56MHq6boIugy5WgH9h7sKnHqqvWlHzVZ+
        aIQyK5Oon6g/kjsYOZ7KtHzSgkTB8gE=
X-Google-Smtp-Source: ABdhPJyOfvMwZgycBzxdm7uftNsnMxzkJT+hmdsejgQHyjZvtLKD7SClUJeggHMilFCqK1IQVTTEAQ==
X-Received: by 2002:a50:9b14:: with SMTP id o20mr4620800edi.328.1603228228823;
        Tue, 20 Oct 2020 14:10:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:28 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/22] unop: add helper replace_with_unop()
Date:   Tue, 20 Oct 2020 23:10:04 +0200
Message-Id: <20201020211021.82394-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Some simplifications reduce to transforming a binop into an unop.
Add an helper for making this change easier and more readable.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/simplify.c b/simplify.c
index 4c6569eba036..3cac124f7d9f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -470,6 +470,20 @@ static inline int replace_with_value(struct instruction *insn, long long val)
 	return replace_with_pseudo(insn, value_pseudo(val));
 }
 
+///
+// replace a binop with an unop
+// @insn: the instruction to be replaced
+// @op: the instruction's new opcode
+// @src: the instruction's new operand
+// @return: REPEAT_CSE
+static inline int replace_with_unop(struct instruction *insn, int op, pseudo_t src)
+{
+	insn->opcode = op;
+	replace_pseudo(insn, &insn->src1, src);
+	remove_usage(insn->src2, &insn->src2);
+	return REPEAT_CSE;
+}
+
 static inline int def_opcode(pseudo_t p)
 {
 	if (p->type != PSEUDO_REG)
-- 
2.28.0

