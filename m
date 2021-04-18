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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C2C433B4
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 19:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CE760BD3
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 19:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhDRTmJ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhDRTmI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 15:42:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F99C06174A
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 12:41:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e14so49613936ejz.11
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eemDrj/BkBWydy+djvyY2tbLfFTDrXWPMcDpsSVpyBs=;
        b=hd74LNMvv+KhyYqyH4l79D6vhU2BrjUyHWw5fIU+FvVeRA6yKrKK0vvPDFw6JL1bQE
         nlOIdJLHDS7VchnlcSFcyekbBb6G4ik76H2qNvUj6lsfHjwAP4abdRt68rBATFVO5Hwk
         vidAA++fipGw1iU/NDELKceY2c/DJ15KP8tFSeXRXJVtM1xOUdCcV0NYe37Mr1EzEQyQ
         Y0U5H0RX/rHl3+SyjYgpmpGPI4q2NTHvEZ94C3Pk7dEbCJ8K9GgkkuWeVRjCswHODBKN
         0g+75/eFLxOUR2HghfZjU7mWanuh75p8Txyw+nGYBivtzuyjBJaWQwctw98TRfN39ril
         RMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eemDrj/BkBWydy+djvyY2tbLfFTDrXWPMcDpsSVpyBs=;
        b=qVSlsieFSJwGrOiH3rP4YD6SSll6J8QGCFI+n2tJ8oIZj1XX+W7sNoSSh0c/VXsaK1
         spFoUvXzPblRNM9B0gxlZldKwzj2RQ/+EAQ83Tp1biHh6Teu4ewjyBMElI4nk8ncJC7G
         QEL0hQO5jB9AxL1S13kd6M5QWScXHfetCPDEhZcRmpV2EsPh/ylfOYf7qnDm7VgZ+fvY
         uGtGZDpWUcT4dV/ODTXL7P3s8NVaNKF0MEZeOlj9szoBxRJmu5s973QgFlhJpiKJ8s3n
         b4QaC+0aquW6rzNeoehXjcJZVn9qErVCVZJ86KQ9xLpHM7Ki/JKseATF22AdGsuPstAN
         7rCw==
X-Gm-Message-State: AOAM530EWbOz4jV36Z531AemE7mIsJgdFJ9M1b7nHbsRLtLFAi6TDxNY
        8OmeRcA3dUE2ctsvucUhamDV5bpcZuc=
X-Google-Smtp-Source: ABdhPJzpYg7OX0P0BN9rs8MXUiW8gbaqjCjoCqdTRKBm3+DBOr+OgGuUIWUfrR9WSgbBGsO0sI+sLA==
X-Received: by 2002:a17:906:85c1:: with SMTP id i1mr18794081ejy.216.1618774899079;
        Sun, 18 Apr 2021 12:41:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7ce8:97a5:cad6:876])
        by smtp.gmail.com with ESMTPSA id nc39sm8342893ejc.41.2021.04.18.12.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 12:41:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] TRUNC(x) {==,!=} C --> AND(x,M) {==,!=} C
Date:   Sun, 18 Apr 2021 21:41:35 +0200
Message-Id: <20210418194135.56287-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

It's not 100% clear than this is indeed a simplification but:
1) from a pure instruction count point of view, it doesn't make
   things worst
2) in most place where it applies, the masking is made redundant
   and is thus eliminated

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/simplify.c b/simplify.c
index 9e3514d838a9..faf769b2f3cf 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1392,6 +1392,19 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			break;
 		}
 		break;
+	case OP_TRUNC:
+		osize = def->orig_type->bit_size;
+		switch (insn->opcode) {
+		case OP_SET_EQ: case OP_SET_NE:
+			if (one_use(def->target)) {
+				def->type = def->orig_type;
+				def->size = osize;
+				def->src2 = value_pseudo(bits);
+				return replace_opcode(def, OP_AND);
+			}
+			break;
+		}
+		break;
 	case OP_ZEXT:
 		osize = def->orig_type->bit_size;
 		bits = bits_mask(osize);
-- 
2.31.1

