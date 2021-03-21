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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105DFC433E2
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBFD61939
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCUQSZ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCUQSP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 12:18:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FE3C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t18so17352246ejc.13
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfzNAIQKTocxOKBw2AQcH96LuSXXG5QoeqiTaPup7WA=;
        b=Im9IPBFIIOjEiRK55BQ+nYCuXsQcZebfs6jIKLZY2Soaj6DSdGB/t/6JlqLbARnzhD
         s8yFPFeV0ncGHeyeC+2KIQRKic80CS8arcEeGXao2NKsnlmOCM1N5SxkYildAMIstG+l
         B7g3ZCruwFEzQJG6OI0t0Cvw/WE/1xEYHFFRrf/v73GCqtUxFzCg1OAId22EllcYwVKA
         mUvIw/dOkRCLvIlDmyb8t+6KE2jO1BA7E+VdROv223WRfUTU/kFyURE0kpQhfXfX+ooh
         yXdeKOS6S0+fprNOk0WefDzi9cSUVshEgHRj6SiPhk33pyKoazkuw91onDg2T0/iK3g+
         JRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfzNAIQKTocxOKBw2AQcH96LuSXXG5QoeqiTaPup7WA=;
        b=md3ptIfoRL1reJhC3UGjQUY1afBbAvLnq3CoGmqtMyfJ05KUEp/IlKHOw6Q9YZjDIv
         3+rq333cp5KY3k/dZcYwKW6xDGG/guBGI+ChwYxBiDzQp/WeNYDo2Qk0ZGN2OG2blEcg
         QLvRkmab2QqcHwHgww4jcRrgHcoIzyf3fKKua59hc62HqZk7pWxgyPwPKxipleLUSPZl
         V+Hv5LpIvOSJlA5Lsq8rV/65Q2IushsCiPNn61aHUj4UkzJrQgxyyavorizRxC7+ZkDy
         lUSlizyed6ivWfs9oLuhpA2giq0FASrqVytNJHBhQp+hX7b4YvSjItbUOrYP22AwF1K1
         Co2A==
X-Gm-Message-State: AOAM532RXAgrQEUJdYPN4orPvjONRSj6j8UwOlaQy8ODipXvQK+M3/Zx
        Lyf9Vo6kYQs9M4Rp60t79oFQadB3dGg=
X-Google-Smtp-Source: ABdhPJyzTP/jGvp8cVku+1ymLOJUx3rWn5xEyvOrlrMGLzNwXa5TLp9pMYYWFPWdZqSQuhuCl1prVg==
X-Received: by 2002:a17:907:3ea0:: with SMTP id hs32mr14783344ejc.411.1616343493497;
        Sun, 21 Mar 2021 09:18:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id c20sm7390295eja.22.2021.03.21.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:18:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] replace add_instruction_to_end() by insert_last_instruction()
Date:   Sun, 21 Mar 2021 17:16:05 +0100
Message-Id: <20210321161609.45905-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321161609.45905-1-luc.vanoostenryck@gmail.com>
References: <20210321161609.45905-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

add_instruction_to_end() and insert_last_instruction() do exactly
the same thing but with the arguments in the opposite order.

So, replace add_instruction_to_end() by insert_last_instruction().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/cse.c b/cse.c
index 1e58a973ecf6..b59581814ab7 100644
--- a/cse.c
+++ b/cse.c
@@ -298,14 +298,6 @@ static inline void remove_instruction(struct instruction_list **list, struct ins
 	delete_ptr_list_entry((struct ptr_list **)list, insn, count);
 }
 
-static void add_instruction_to_end(struct instruction *insn, struct basic_block *bb)
-{
-	struct instruction *br = delete_last_instruction(&bb->insns);
-	insn->bb = bb;
-	add_instruction(&bb->insns, insn);
-	add_instruction(&bb->insns, br);
-}
-
 static struct instruction * try_to_cse(struct entrypoint *ep, struct instruction *i1, struct instruction *i2)
 {
 	struct basic_block *b1, *b2, *common;
@@ -343,7 +335,7 @@ static struct instruction * try_to_cse(struct entrypoint *ep, struct instruction
 	if (common) {
 		i1 = cse_one_instruction(i2, i1);
 		remove_instruction(&b1->insns, i1, 1);
-		add_instruction_to_end(i1, common);
+		insert_last_instruction(common, i1);
 	} else {
 		i1 = i2;
 	}
-- 
2.31.0

