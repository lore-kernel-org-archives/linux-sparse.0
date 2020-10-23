Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD72C55179
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B06321D47
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLJYJHCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464733AbgJWP6k (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464730AbgJWP6k (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 11:58:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F75FC0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 08:58:40 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o26so3069536ejc.8
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2aP4NVIHsMYrVhS/phSq0OGPW+RvY1TxeOdWkx+XQ4=;
        b=GLJYJHCLuYoyzu5n7y9O1vhNr4enblZiqVg3YM9mtSYUIykG/QOETBsac3SmT+OITN
         D7G/e4mW0e9q6tUgb3zoE8bjey2W+JdmbGX3s1Gr5+bMl4V9z/IuoRLwMDLar2binSt8
         iE+dgKggtS0iTsO/nRIdUGypy17JJT8PEKKAxa53rZ+WJm0pb342a3ayKNs+c/39ETpm
         sTmUCdKCMSYB+DAmwgOsnrbV//alZKF8Rc226gjmU5r9D7T+YzgSC0M2rjBg8EL6aNHj
         KuPMYjXskVdGFiNQ8eDjqkALKYAS8ukYsXMnDAWQcf3tBILOGv42v4O81wjwrROy02o2
         ViIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2aP4NVIHsMYrVhS/phSq0OGPW+RvY1TxeOdWkx+XQ4=;
        b=CRJRb7Zn9m5+4ny/mqAm0swKv3JdtvK+zYlgQnbunIPgDkdPiLEHgpr7oJHseqUDIg
         TSh67dTtPXix63OSHEC0gtOc9RmeR3so41GSkAvKJddPfB8GVZa0nMqixfLkKFQ440Ge
         OuFtd7MFPvd0JWKoMzJcq7kVMHMMalNyAnSEvTRIahgkwXVRl3qiyLt2w7fkFHvxTQmd
         zKenqGSpB+dqTCiiunmTNTKdMPUEdffDx1oYFF1AD9wFt7vqLjw5JvloTcvCOIFeB2KY
         jYXjfOkb+saC7D+bI5aTPJtdvGw3UhHAh7exKQTdPWagy5SgxCvy90UQ75sUlP8En++Z
         oyug==
X-Gm-Message-State: AOAM530D3tdkKr2kGIsqqbCfmQCWaqCiLGioDZVvxJlKhzYqvww5KVXf
        5cgVYywhFvLxKEUiQjPTjs1xLdJfQ4U=
X-Google-Smtp-Source: ABdhPJx/IFl4jQ+ZXFNI0ujBRBU47VCGEiS9USgrdAqcIYA1Vx3ydA3t0VmyPpg2uHPxSRIaaXqd1w==
X-Received: by 2002:a17:906:1150:: with SMTP id i16mr2772558eja.90.1603468718898;
        Fri, 23 Oct 2020 08:58:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id y3sm1062569ejk.92.2020.10.23.08.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 08:58:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] simplify unsigned compares against 0
Date:   Fri, 23 Oct 2020 17:58:31 +0200
Message-Id: <20201023155832.57237-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023155832.57237-1-luc.vanoostenryck@gmail.com>
References: <20201023155832.57237-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Some unsigned compares against 0 are always true or always false
(x < 0 or x >= 0). Simplify them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 10 ++++++++++
 validation/optim/set-uimm0.c | 10 ++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 validation/optim/set-uimm0.c

diff --git a/simplify.c b/simplify.c
index 6caf6cbcf918..4441b27c7546 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1173,6 +1173,16 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_SET_NE:
 	case OP_SET_EQ:
 		return simplify_seteq_setne(insn, value);
+	case OP_SET_B:
+		if (!value) {			// (x < 0) --> 0
+			return replace_with_pseudo(insn, value_pseudo(0));
+		}
+		break;
+	case OP_SET_AE:
+		if (!value) {			// (x >= 0) --> 1
+			return replace_with_pseudo(insn, value_pseudo(1));
+		}
+		break;
 	}
 	return 0;
 }
diff --git a/validation/optim/set-uimm0.c b/validation/optim/set-uimm0.c
new file mode 100644
index 000000000000..1f62358ff0fb
--- /dev/null
+++ b/validation/optim/set-uimm0.c
@@ -0,0 +1,10 @@
+static _Bool setlt0(unsigned int a) { return (a <   0u) == 0; }
+static _Bool setge0(unsigned int a) { return (a >=  0u) == 1; }
+
+/*
+ * check-name: set-uimm0
+ * check-command: test-linearize $file
+ *
+ * check-output-ignore
+ * check-output-pattern(2): ret\\.1 *\\$1
+ */
-- 
2.28.0

