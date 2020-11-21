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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C1C388F9
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 17:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E9122206
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 17:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9Sy1ioA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgKURQg (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 12:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgKURQg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 12:16:36 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC97C0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 09:16:36 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id gj5so17368518ejb.8
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 09:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STTeWayqg2smjImjQRXLuCeHzV8iKmQxv4cqcXjG/2U=;
        b=r9Sy1ioAWxyRLSPAie3np9t507M5vZy/Ibkd6UF7QDxJpmCO1AW6fN61rLUEcFDUmf
         HyNiHdxi+MmD1WuSjFwojgV8mhIDdSAZ5pRo4P19bnimQfH8pXzq6ii9fzYuyzjnslbP
         yvsNKLfCYPQyXZO8u5G2vqitjbmcSfmaM4Cnw+RumEXSUsAxyAiQqlNYPatWw7R1gS3H
         HBiptqE822pkSKfob0VGaLbpTsQCQTRW/xJxI5EWo4bap6vIv/QitOgnKTmgV1LMZpDo
         +ZaZVxB3SdVO81Gq6ECyvukn3CUcN2luoxlHEoMuvHitvY3po0q6aNfgi6aCpnPAnz5b
         43rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STTeWayqg2smjImjQRXLuCeHzV8iKmQxv4cqcXjG/2U=;
        b=n8ADEHo0Drgjaan50kvKINT9yxAVa0k39H9Z0KLRCuqUfC7XIUQAkzXnfHEWl9psq+
         G4WhzrIhCaH/snWOP2OFRXKQaFJUolvuyYplfhWYhoJmMHX/XydUZRNoNC/jWPEN/lmm
         p0UbIOFqnYnHMczMbLidf9oOxC5dLpjTz+wWX8Uuqyu+DBiwGvWhCL2ZT7+CM2ACg/Mo
         088SaT1WXWgD48vldCc4GYGhaH3zFvwx5MQISew+VCYQ8dTiIEYy5sIhoVp+b8PoaXXJ
         8O026fxMO/biAfV4kooxJdtWevHCp5KemABLlWY9Bj9A1SPMlxe3rAYabd6yoFp4MgLN
         ItCQ==
X-Gm-Message-State: AOAM531oyfAgen/xT5bqU62u9IqzH/B6JZUagcLC+XBgk3pXvLLrY/mG
        5HYUXlwOYyyLWiElcPZsLD+YMzppNw8=
X-Google-Smtp-Source: ABdhPJx5WRp++N+OCCJzf7UFgkObDDKfGXiavumZ5q4pHW/e8QbqOrqJkYjWwgfSZOZp4yFYuzjpOg==
X-Received: by 2002:a17:906:4547:: with SMTP id s7mr6621292ejq.279.1605978994598;
        Sat, 21 Nov 2020 09:16:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:cd53:c7a2:f8a6:a700])
        by smtp.gmail.com with ESMTPSA id b21sm2682845ejg.93.2020.11.21.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 09:16:33 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix kill_insn(OP_SETVAL)
Date:   Sat, 21 Nov 2020 18:16:29 +0100
Message-Id: <20201121171629.93454-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When killing OP_SETVAL's, kill_use(&insn->src1) is called to
remove the usage of its first operand but OP_SETVAL has no
such operand.

Fix this by moving the corresponding entry with OP_SETFVAL and
others instruction without operands.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index a0e23d6de01f..4d0adf444e17 100644
--- a/simplify.c
+++ b/simplify.c
@@ -325,7 +325,6 @@ int kill_insn(struct instruction *insn, int force)
 		/* fall through */
 
 	case OP_UNOP ... OP_UNOP_END:
-	case OP_SETVAL:
 	case OP_SLICE:
 		kill_use(&insn->src1);
 		break;
@@ -380,6 +379,7 @@ int kill_insn(struct instruction *insn, int force)
 
 	case OP_BR:
 	case OP_SETFVAL:
+	case OP_SETVAL:
 	default:
 		break;
 	}
-- 
2.29.2

