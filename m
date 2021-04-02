Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C27C43461
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63B461151
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhDBU0K (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 2 Apr 2021 16:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBU0J (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Apr 2021 16:26:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C8FC06178C
        for <linux-sparse@vger.kernel.org>; Fri,  2 Apr 2021 13:26:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a7so8809149ejs.3
        for <linux-sparse@vger.kernel.org>; Fri, 02 Apr 2021 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nq13yPjfN4vCKLSP2CDNT7+S8Wf3x7YNuUU5VD4vPQE=;
        b=Uxts5WTv+DstNeVbo909mOcXlbypnezxSdeuV9jAjajf95hbUSTB9oEdYUOfUFxy9Y
         zPlJzn7lNoKIdlehikkQ3UoZ5UrfBxPltm7S4T8VLs8at+aOTgojpuj/5X2NufVOl0fC
         LExMSaCEGMjhkQ9Wmrto/kOXD/xdGqbfoOeIv3B/6arFSmUYqnb+zOK2cpU9TuUM4xq6
         o1OooqvheKg6WaSzRj6GEZm4qsJCyEBGxE7uz7lM3C5J+R3rsvBdxN0HEQiKHFweRTU2
         VtpZn78bxl+dcfiQc5g5Iakl1x6bIF7ePTF86otH1LufXATIrRqpgkxl60crzE0nM9GM
         Xfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nq13yPjfN4vCKLSP2CDNT7+S8Wf3x7YNuUU5VD4vPQE=;
        b=MM+mkF8mc1L/WmwQHbxXdPcPIjihGf6AIzkKjpICk+nAF9mqkr3hzjm6f6vzl/LJ1K
         F9BB4pl19uZqqQmAAGsvss9nFpa2I6n4P2JFcPrwmgIAkMreesptvI/8xVqutPVNtFm6
         9T2OHmPxjNRhp5bhMnifXe3YnVWPVEiy46S4xVJO6jfO6BJHcQHfYZB7vvBhqNCwN4WK
         GDjrXVLMBfUnW7cJ8zqjkunHHjGRRNWDPMfIpBlJcfC6DZ4IJORt3FmjUy2AjdtZz/VF
         Bc6MTvRRIR7yVAgcNHLC5V5Z4l2ldCPJ7B4i/M4KkkWPtxl4Nw5navKKcDISwkxjz5oe
         VfNw==
X-Gm-Message-State: AOAM530jM+oMYMGAIyJbhCifZE17EiGxXgKhphF5AlldxHy/dnsIvuiq
        18vPikWwWs488wDykljqk0RVtdkmGF4=
X-Google-Smtp-Source: ABdhPJxMdYGqMpFreRuibpeRGk/3qd0ILBl6/tG1zl/z2YSCTs5rFP+Hq+CpUsYM7hwljIOCzb+OYQ==
X-Received: by 2002:a17:906:f247:: with SMTP id gy7mr16122309ejb.183.1617395166217;
        Fri, 02 Apr 2021 13:26:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8a3:6a32:4891:b7b])
        by smtp.gmail.com with ESMTPSA id p24sm6011890edt.5.2021.04.02.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:26:05 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] better check validity of phi-sources
Date:   Fri,  2 Apr 2021 22:25:57 +0200
Message-Id: <20210402202558.54504-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402202558.54504-1-luc.vanoostenryck@gmail.com>
References: <20210402202558.54504-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Transformations made by try_to_simplify_bb() are invalid if
there isn't a one-to-one correspondence between the BB's parents
and the phi-sources of the phi-node(s) in the BB.

This correspondence is currently checked by checking if the number
of phi-sources and the number of parent are equal, but this is
only an approximation.

Change this check into an exact one, using the fact that BBs in
the parent list and phi-sources in the phi_list are in the same order.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/flow.c b/flow.c
index 58807432b3aa..c866dec80480 100644
--- a/flow.c
+++ b/flow.c
@@ -190,19 +190,24 @@ out:
 }
 
 ///
-// count the true number of argument of a phi-node
-// VOID arguments must be ignored, so pseudo_list_size() can't be used for this.
-static int phi_count(struct instruction *node)
+// check if the sources of a phi-node match with the parent BBs
+static bool phi_check(struct instruction *node)
 {
+	struct basic_block *bb;
 	pseudo_t phi;
-	int n = 0;
 
+	PREPARE_PTR_LIST(node->bb->parents, bb);
 	FOR_EACH_PTR(node->phi_list, phi) {
-		if (phi == VOID)
+		if (phi == VOID || !phi->def)
 			continue;
-		n++;
+		if (phi->def->bb != bb)
+			return false;
+		NEXT_PTR_LIST(bb);
 	} END_FOR_EACH_PTR(phi);
-	return n;
+	if (bb)
+		return false;
+	FINISH_PTR_LIST(bb);
+	return true;
 }
 
 /*
@@ -227,7 +232,7 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 	 * simplify_symbol_usage()/conversion to SSA form.
 	 * No sane simplification can be done when we have this.
 	 */
-	bogus = bb_list_size(bb->parents) != phi_count(first);
+	bogus = !phi_check(first);
 
 	FOR_EACH_PTR(first->phi_list, phi) {
 		struct instruction *def = phi->def;
-- 
2.31.1

