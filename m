Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D37C63798
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02B924682
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 01:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXJJK2jT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbgKQBLF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbgKQBLF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 20:11:05 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79C7C0613D2
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 17:11:03 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t11so20658626edj.13
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 17:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PogOt/5eU18LdI5Pzj7kakebc0wE7AlSqgelu/GyHR8=;
        b=BXJJK2jTrba5Z+VAE6u35MbFUZiNaaHZ0m1dYw2IT+mZCAWykCC6X8Nic8aMX86uDO
         JnDZczEbTS/N8B6lfyJ75WRbZuqsqqwIVtc/Plktlhr7Spg/AWSly2CfLozMBNmvU2qu
         l2ZHDm62zDTiK0pBvZC5bcc1Ufk6LoDUN+sKf1ywHMn6KRO6tJv5AORdrD7Z9HnCUP7b
         aQ2/kk+hgp6DL4czw21+TjRV6fC3G0LzDALdoy8UWgETAmFWtz/4HRgtSbLE7lJy1Eod
         NRZYS3WH8gWjNyVIdkx1fs3ROudSxTQBpjY0QInSt1o8wrDJuD9sto7LxpcoD+6tGxAw
         LVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PogOt/5eU18LdI5Pzj7kakebc0wE7AlSqgelu/GyHR8=;
        b=pwm8Yy4wXSgSR86rWehyesezEmY9DeGUcESdgiGIqpl3qYU+se2cgNljF9bxac+xlJ
         jLR+vHB+6l1P60Hz2vPit2qLQwd2Y4Gj+HKmWvsZy5eRKxB2YlOdWwVwu2QscdfssO8K
         WJjb0QNi+6pWqxJhBj0bTBS36JikKMNK2Ws2mbDxofL0BVDWb9L8m9Egb7A9y+yqd/PX
         493x4TTJSz/hl61L/S3Qrzl56hqRnUhavejUrHlZas4ggxIOFWmnR+1yUd5sBd9LseKg
         dN/CVOHy16z04ZQRDBiqQDWc/pwQE8tR+rPAZN7r9YVwQ5/tQzTPn9x0oazDXFdF+6cb
         iMzA==
X-Gm-Message-State: AOAM533JsjxAcaVZOAJgmWzUIWXUu4tNJ50VJyh5XsXUAoIQ6kV/UHin
        WbLAIzPBmaiXszIHiU8JfQTR/KKgUBk=
X-Google-Smtp-Source: ABdhPJw/Ikxa/Sxu2RHKeo2Zh3g14WMjl0gXy+Fm+zaseRCDXnUW6r6FjQ7zaPyD6aZKduelDWhfxg==
X-Received: by 2002:a50:c40d:: with SMTP id v13mr18697196edf.1.1605575462356;
        Mon, 16 Nov 2020 17:11:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id e9sm11231812edn.30.2020.11.16.17.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 17:11:01 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] rebuild dominance tree during CFG cleanup
Date:   Tue, 17 Nov 2020 02:10:57 +0100
Message-Id: <20201117011058.53995-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117011058.53995-1-luc.vanoostenryck@gmail.com>
References: <20201117011058.53995-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, the dominance tree is build once, just before the
SSA conversion.

However, changes in the CFG potentially changes the dominance
relationships.

So, rebuild the dominance tree after changes to the CFG.

Note: This doesn't seems to significantly affect the performance
      (at least when used on the kernel):
	before			after
	real	 4m15.854s	real	 4m16.95&s
	user	71m11.390s	user	71m29.180s
	sys	28m45.222s	sys	28m46.145s

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 optimize.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/optimize.c b/optimize.c
index 338714c78e68..c047495f26cf 100644
--- a/optimize.c
+++ b/optimize.c
@@ -45,6 +45,12 @@ static void clean_up_insns(struct entrypoint *ep)
 	} END_FOR_EACH_PTR(bb);
 }
 
+static void cleanup_cfg(struct entrypoint *ep)
+{
+	kill_unreachable_bbs(ep);
+	domtree_build(ep);
+}
+
 void optimize(struct entrypoint *ep)
 {
 	if (fdump_ir & PASS_LINEARIZE)
@@ -93,7 +99,7 @@ repeat:
 		} while (repeat_phase);
 		pack_basic_blocks(ep);
 		if (repeat_phase & REPEAT_CFG_CLEANUP)
-			kill_unreachable_bbs(ep);
+			cleanup_cfg(ep);
 	} while (repeat_phase);
 
 	vrfy_flow(ep);
@@ -113,7 +119,7 @@ repeat:
 	if (simplify_flow(ep)) {
 		clear_liveness(ep);
 		if (repeat_phase & REPEAT_CFG_CLEANUP)
-			kill_unreachable_bbs(ep);
+			cleanup_cfg(ep);
 		goto repeat;
 	}
 
-- 
2.29.2

