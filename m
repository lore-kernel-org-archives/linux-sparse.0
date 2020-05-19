Return-Path: <SRS0=O/Ee=7B=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9BBC433DF
	for <linux-sparse@archiver.kernel.org>; Tue, 19 May 2020 00:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF2E20674
	for <linux-sparse@archiver.kernel.org>; Tue, 19 May 2020 00:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJNbWXQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgESA5n (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 18 May 2020 20:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESA5m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61183C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i16so5747232edv.1
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pB++fVfY03fTCT4OcxHp+ClN+k9CRnpgEhj7IaKfZQM=;
        b=CJNbWXQG2r+wxu5s2X6qR2Jnvq7hlY4iTuArXbTIdy+lbOBPl3v37cSQ5sosaZsoQY
         iXdofibzm0h/rD9P5x/tlQpbaaj/Ej6s6LrtUqgpNWnEBM5XxySJMK8PofqergPjNvxB
         g2Zmv37RflctBqBZKjk0MrCCAjuB0QxplFIbb5V/fuQS1CVAiAcz8BgW4Papp0vFOlYK
         SHZvpVh/sAnRpPjCeJIlFIqRS8PjgA5BlRrXGL7WCfauTMpSKyxLbs4wxyLMtSsJS04z
         uMNpXY/0+Gi/R6r5pHgK6Iq1u1ixhltdG5++y5HmW27EVkTGsFmMSamOjWcTIou2y1Eb
         jG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pB++fVfY03fTCT4OcxHp+ClN+k9CRnpgEhj7IaKfZQM=;
        b=mvhPRV1A2/71oxXeXtm+u2rWEVPOr1yRzn1Zo4uIYicNPCXGpmHK57yuwNnIJsRsth
         oOxnyZOeBfdMYk1SjVaAS8ejqCBkqrdspeTbhROZEOrt85URV7p0G4fdS79kb+Y76UwM
         eCo51CJ2zly70x3crwWGuL91ZTgv9jBzeY15nJ9YYYtbWhfQTdh+5Bro0pp3zp51xRHJ
         0y4TLTdEln0kTuUz1vFchapBAxyg2Mj9tWCIb1/85o+ULL9a4gqJEH8sBjHlCu0MVR/8
         KJK9XihK8e+8yvk2nJlQbviBAYbYQ+sYyc3UgUyrQOpAtQW5/fWDEqAh9qGmALV/zjB6
         ETpQ==
X-Gm-Message-State: AOAM532hHZvkdQ49mm2WcN6C1Bu/B3Jex06JM0KdGp3TpBbQnjEiC5e6
        bNTAez4tTa0xbfGVuaN7XnYU+O/m
X-Google-Smtp-Source: ABdhPJwT5KShBBL50WLjkMKuGV3crY3hrt5vA9LjIgzQYiIaEa79GFbfbUORp9DI8ybcMPoSuFB/Ag==
X-Received: by 2002:a05:6402:2032:: with SMTP id ay18mr15691712edb.281.1589849860883;
        Mon, 18 May 2020 17:57:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:98be:2081:4f7:29e4])
        by smtp.gmail.com with ESMTPSA id h25sm702737ejx.7.2020.05.18.17.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 17:57:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 08/28] bad-goto: reorg test in evaluate_goto_statement()
Date:   Tue, 19 May 2020 02:57:08 +0200
Message-ID: <20200519005728.84594-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200519005708.rNGF9vj8iMcRd-kIpGzVbpWE_ojfBn1LmqH7qTwnaXk@z>

No functional changes here, only changing the code structure
to prepare more incoming changes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index c18ae81df5ad..4bdd5ed05842 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3742,10 +3742,14 @@ static void evaluate_goto_statement(struct statement *stmt)
 {
 	struct symbol *label = stmt->goto_label;
 
-	if (label && !label->stmt && label->ident && !lookup_keyword(label->ident, NS_KEYWORD))
+	if (!label) {
+		// no label associated, may be a computed goto
+		evaluate_expression(stmt->goto_expression);
+		return;
+	}
+	if (!label->stmt && label->ident && !lookup_keyword(label->ident, NS_KEYWORD)) {
 		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
-
-	evaluate_expression(stmt->goto_expression);
+	}
 }
 
 struct symbol *evaluate_statement(struct statement *stmt)
-- 
2.26.2

