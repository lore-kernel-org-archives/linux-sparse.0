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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA7C4363A
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 16:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FAB2098B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 16:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRPC2ycE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394790AbgJTQoU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394778AbgJTQoU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 12:44:20 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E7C0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 09:44:19 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t20so2537176edr.11
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ey58EFbSJyUnkQNcQjheIKWp6EyDxzdkJNM4rV9ySmw=;
        b=jRPC2ycEhtmNcHid4eSIugptbXrDxe+zPZFgmzKwK2qY5GDQMYkTCcKVkzsWcd77E+
         /kGHX49R11gbIUvH3FHqo0w2pqZGaX3OefK4cPckdD72MkEIKybq93NV+/9lezz6KfBY
         3P7pnYRDH0XDsHx/vXcpty7kdfYQNQSlOIAr6YfHzSl2gdTRltwtAI4BSs2Esk72cLQ0
         07+P/uVjaDtv4RSIbJ51ezrxxVIJmZ3P5Gd00h8Tp2uxYds7l+NHdvh2FR6ggLJFHq9h
         JoO/7L7WfQeTALGtKGjqv94HeUJrIczLcvhjy3hYw1nfb57DoE50PLflzJqCR3g8K0d8
         tdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ey58EFbSJyUnkQNcQjheIKWp6EyDxzdkJNM4rV9ySmw=;
        b=GzCkNasUeUBfc8WoNVLmkZw6eG330Wh8Xvng3c/QQZ1iB8WOwn31Zr3tX/NxUlbRCU
         WysRQh4CUEEnpHpC4zqhNsy/3N3hEyuX8L+24twzWWBei6lA95CIqdea521l+mVwUI0k
         yK+F1mJZQUdB6nt/50T51pArPYUGnHHFFmZ9eip8OaxcFpCGr5U/4mCb6YAeLeE/SFm8
         AP2S3FtDDk7Kx1yCfr0pS31ckTyBGyA2SIB4PtJdieWnnnSEbOuDIlkn3+QuLLBMv1lf
         Wd2KcLtFa+EQ54/8Q6lvYYonrvqRksG5aW5fz3uqh+1a04p67EbQpawh74nWAOkBVMfK
         XS1A==
X-Gm-Message-State: AOAM5330cymsCIk0lmt48jGEeLBnnPRcSDwGZAMMCvb0oBn3FvYvXy+2
        u07d+xkr3hHkxKNSv/lTmFHXT7gCQF0=
X-Google-Smtp-Source: ABdhPJyqOAscw5xfMf+lLm8FIQa/x2Bx72Oy+ICGSChl9LudJs85Vn5YeMZhCQlSs1ca1lcqCIBktQ==
X-Received: by 2002:aa7:c7cf:: with SMTP id o15mr3522350eds.15.1603212258170;
        Tue, 20 Oct 2020 09:44:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:65e3:2697:198a:c08e])
        by smtp.gmail.com with ESMTPSA id v6sm3179969ejx.101.2020.10.20.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 09:44:17 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] memops need long offsets
Date:   Tue, 20 Oct 2020 18:44:14 +0200
Message-Id: <20201020164414.79521-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These days, declaring arrays bigger than 2GB or doing pointer
arithmetic with an offset larger than 2^31 is maybe not usual but
certainly not outrageous.

However, currently Sparse silently truncates 32 bits the offsets
of memory accesses.

So, fix this by using 64-bit offsets for memory accesses.
Also, use a signed type since these offsets can be negative.

Note: I had a really nice (real) example for this but the margin
      of this patch is too small for it (but now I've lost it).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 6 +++---
 linearize.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/linearize.c b/linearize.c
index 1081bda86425..b7da35fa0ede 100644
--- a/linearize.c
+++ b/linearize.c
@@ -426,10 +426,10 @@ const char *show_instruction(struct instruction *insn)
 		break;
 	}	
 	case OP_LOAD:
-		buf += sprintf(buf, "%s <- %d[%s]", show_pseudo(insn->target), insn->offset, show_pseudo(insn->src));
+		buf += sprintf(buf, "%s <- %lld[%s]", show_pseudo(insn->target), insn->offset, show_pseudo(insn->src));
 		break;
 	case OP_STORE:
-		buf += sprintf(buf, "%s -> %d[%s]", show_pseudo(insn->target), insn->offset, show_pseudo(insn->src));
+		buf += sprintf(buf, "%s -> %lld[%s]", show_pseudo(insn->target), insn->offset, show_pseudo(insn->src));
 		break;
 	case OP_INLINED_CALL:
 	case OP_CALL: {
@@ -925,7 +925,7 @@ struct access_data {
 	struct symbol *type;		// ctype
 	struct symbol *btype;		// base type of bitfields
 	pseudo_t address;		// pseudo containing address ..
-	unsigned int offset;		// byte offset
+	long long offset;		// byte offset
 };
 
 static int linearize_simple_address(struct entrypoint *ep,
diff --git a/linearize.h b/linearize.h
index 76efd0b47ffa..d8cbc3f339b4 100644
--- a/linearize.h
+++ b/linearize.h
@@ -117,7 +117,7 @@ struct instruction {
 		};
 		struct /* memops */ {
 			pseudo_t addr;			/* alias .src */
-			unsigned int offset;
+			long long offset;
 			unsigned int is_volatile:1;
 		};
 		struct /* binops and sel */ {
-- 
2.28.0

