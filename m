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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A273FC433ED
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A74360C3D
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 18:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhDRSq4 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 14:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRSq4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 14:46:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94813C06174A
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 11:46:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i3so12383939edt.1
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eggPLfzlmAtpF0vI6hKFvlaBJmklLZgyaofxWSp+Sy0=;
        b=I76Ncp8QPrWqBhCMZ6RhQxrVHwrkj8DtEKq9R/5WjEMCT3zsIhoDYUxuhOEWkdQsed
         2nnrJhp5si3BLB+5IR7WoK2HaBIBZWiuPYnqC3jVo01/QbxJKQKLy0rBKZw/8SGQ5ABb
         GbO0SZ2qI62seM6l+At1IM5On7zlLwZMfrm6eVLdsH7Lp62PjoP7V3xhvYpEA9V36ea5
         Nh7EIX0O/lNzJ2BVXFqYT4dOGTI8GZrHC2IBfiCRe3AXYfOrq8OFrNwaWevJ/FYfHi0V
         eNwOFfBJzM7+tvAo1xIrZaFAIlgKc8WD7lVY4E60CP93jNC7VCzolhPwT/7cNWOtEc1W
         IMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eggPLfzlmAtpF0vI6hKFvlaBJmklLZgyaofxWSp+Sy0=;
        b=IOhmzzK3EtqkmLaViIXa7Ji+t+gP/ozv64b7+Y163EIZxEHPpuQEW+ntyLY+jitCed
         Nsti1++BKs9ebe/0fS2zSAuIXIX9TKMe01CkoCNdWBYs0vIBWGEsZV+8BJ7k0jT2j3rI
         Y/OF6dIrdoOE+rdS4piVPdubGwsjkm990blGBGoO2CUNwPe8CkOEbU9S43k0AZkY8EQK
         eB5/t8AxvrfqndRhjIfspkMuxbXuIvVAtyb05eaTdUqT4BYZPyiqGy5AkfYSOhgn7ynN
         X+p2MhorW9aMMwwkLVCJMsBRnD8RfMjlSXowK8AhQfscHNsKLjJO6cNhAH8Ry0tdnAfT
         I21g==
X-Gm-Message-State: AOAM531by5cXm0eAr5M8dwPZ8BE2T9zAwM3suomywm6jcOBwZO2GcGnX
        oid+Ro6QxCNN3y94EnKoyIRFNGwQr/M=
X-Google-Smtp-Source: ABdhPJzRWnP+GwbPd0phP/G/QW02fRsAZtdDtMZkRzfSJ2psEGHOcp3WN2oa2a1It7wIaMsCdE7WfQ==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr2748091edd.258.1618771586118;
        Sun, 18 Apr 2021 11:46:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7ce8:97a5:cad6:876])
        by smtp.gmail.com with ESMTPSA id y11sm10987994eds.10.2021.04.18.11.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 11:46:25 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] canonicalize ((x & M) == M) --> ((x & M) != 0) when M is a power-of-2
Date:   Sun, 18 Apr 2021 20:46:22 +0200
Message-Id: <20210418184622.54994-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

and same for its dual: ((x & M) != M) --> ((x & M) == 0)

Beside the canonicalization itself, these simplifications are
useful because the compare against 0 can often be further
simplified (for example when it is used by OP_CBR or OP_SELECT).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                      |  4 ++++
 validation/optim/cmp-and-pow2.c | 12 ++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 validation/optim/cmp-and-pow2.c

diff --git a/simplify.c b/simplify.c
index 9e3514d838a9..99f1d0454633 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1266,10 +1266,14 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 		case OP_SET_EQ:
 			if ((value & bits) != value)
 				return replace_with_value(insn, 0);
+			if (value == bits && is_power_of_2(bits))
+				return replace_binop_value(insn, OP_SET_NE, 0);
 			break;
 		case OP_SET_NE:
 			if ((value & bits) != value)
 				return replace_with_value(insn, 1);
+			if (value == bits && is_power_of_2(bits))
+				return replace_binop_value(insn, OP_SET_EQ, 0);
 			break;
 		case OP_SET_LE:
 			value = sign_extend(value, def->size);
diff --git a/validation/optim/cmp-and-pow2.c b/validation/optim/cmp-and-pow2.c
new file mode 100644
index 000000000000..01ba2537521f
--- /dev/null
+++ b/validation/optim/cmp-and-pow2.c
@@ -0,0 +1,12 @@
+#define M 32
+
+_Bool eq(int a) { return ((a & M) != M) == ((a & M) == 0); }
+_Bool ne(int a) { return ((a & M) == M) == ((a & M) != 0); }
+
+/*
+ * check-name: cmp-and-pow2
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.31.1

