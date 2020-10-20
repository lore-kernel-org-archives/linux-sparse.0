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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B84DC54FB2
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0227D222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDt3JXNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438681AbgJTVKo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438680AbgJTVKo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A298C0613D3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:44 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id cq12so217685edb.2
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DyfCSukvkgBgS/0NnZtlzI8RhfeZrXwJ61em0Y0N9U=;
        b=eDt3JXNMiJL9RYaY8reFuqwIkblsHC4/v3ZfoKGkM1hPBk/DEVaZuSVtMA4SLu5vSx
         9OQSieKNIHjWOuiWq/9fQASBkxohx7WA0g8JXhv9hp4lz0/QI9TKu+7ZWSssgEYmHLHr
         bsto6dwenrwvkbbu2Ebnx412BH4JS1erU0ydFTAZCF6bkrbJPi7SpuBwtg+1+KeaBjmf
         B+qbvdl2f3q4Hqp3ggA7sk/g1VuDlYemN88fHbS4Tu36n5ncgwojNTDbR77zInASERId
         I9a4O8J9uZJ7B5Z3ozhz1Yk4l8hpbYaoPXjRUYT9BnVq7Ab4yVOgEIF6dc9URwi3Lb4v
         MOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DyfCSukvkgBgS/0NnZtlzI8RhfeZrXwJ61em0Y0N9U=;
        b=oiGncxQnYBt9k+i//NaWR25syQqc7Kc++YoOrzQUVo40hYHIiVHX18iEmoB3PcmN3S
         iec9OVQSISTeVLXv74ZRlml1tXbyXgR4rfw7qN+WAjZ+O06RzQcjvA+YRMp61lnqtg/Y
         wPvLZAeVksHo3Zpp/2OZK1tTFzgXRJYzBRamShy39YX1jTuRNohhRVZpRXdQVQ1ShZd9
         zYItV+3gMgVZtl3VcQmSQkkz9HTQx6EX4n/pvEF+hhzi8jn+HCpplVV/3pogOxItE4Tb
         WpEiYRRwoxctmvbusY9vZA65zp37t8Coe2ZYuSxwfszUK0I3yMAvsVvbadwV3cnCD3KY
         pdzg==
X-Gm-Message-State: AOAM531EnZu3Z8oq7t1h7SyW/cKkHp7lUQnX+/HSCL2xXI3pt/OiPedS
        IZSUrul5pxWPkYdazDUYGlXVIZuJquU=
X-Google-Smtp-Source: ABdhPJy2mhZ33PCmD94EkxgTcpYbiKD4sF2B/Om0NLEztIJjerLrKlJiM/1tAtw+tbcFX7K8KKr7Mw==
X-Received: by 2002:aa7:c2ca:: with SMTP id m10mr4601339edp.255.1603228242666;
        Tue, 20 Oct 2020 14:10:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 21/22] sub: simplify (x - y) + y --> x
Date:   Tue, 20 Oct 2020 23:10:20 +0200
Message-Id: <20201020211021.82394-22-luc.vanoostenryck@gmail.com>
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
 simplify.c                                | 5 +++++
 validation/optim/simplify-same-sub-addl.c | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 68ee6ed015c1..65fca35099a6 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1369,6 +1369,11 @@ static int simplify_add(struct instruction *insn)
 		switch_pseudo(insn, &insn->src1, insn, &insn->src2);
 		insn->opcode = OP_SUB;
 		return replace_pseudo(insn, &insn->src2, def->src);
+
+	case OP_SUB:
+		if (def->src2 == src2)		// (x - y) + y --> x
+			return replace_with_pseudo(insn, def->src1);
+		break;
 	}
 
 	switch (DEF_OPCODE(def, src2)) {
diff --git a/validation/optim/simplify-same-sub-addl.c b/validation/optim/simplify-same-sub-addl.c
index 78f217399e50..56b6fcc24e9d 100644
--- a/validation/optim/simplify-same-sub-addl.c
+++ b/validation/optim/simplify-same-sub-addl.c
@@ -3,7 +3,6 @@ int foo(int x, int y) { return (x - y) + y; }
 /*
  * check-name: simplify-same-sub-addl
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*%arg1
-- 
2.28.0

