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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F1BC433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34BA261864
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCUQSZ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCUQSO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 12:18:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D8FC061762
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b16so16481833eds.7
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wah0v4FjWHZbJaov8QIevKHi9R8Q9SEewwcmnNESkh8=;
        b=ctOaDbn/ug1qvoTGVy1xqGPrEYhQhGvewTuOlSjab61fbm60A9SRcFA5ZRUAS9H59I
         +o05TSnM0lN5CEsK5umDJah36j9q1AcukhrGmLuetXyK3cXjtMt9DH9s5pRiX4TnzARu
         uwx5U86b1wVzlGP0vemLu0UT+j6F4HnKiOgJO6Bl0vng+1I3Jq8YeJb/kcoX8hwNGzCi
         71KLO/S5gHIETfBv0ZXc78bq8bpXR2Uy946O24UBxCqJp3QMfxiN2MWgza4CpsjJ6y1m
         pVrT44W2RqKTrqXS/RzFzRwlEjpIlaDld+fUNrBUM/7xd+dUpqpB/YoD0D6/ZlGfNPAY
         x5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wah0v4FjWHZbJaov8QIevKHi9R8Q9SEewwcmnNESkh8=;
        b=MG1+fNcj6vZMuB9TBh0GbWhZqRU24X8yNKk0o8aDsQd4amfmbtUvNjItungrkrJbP2
         j2nb5T4pmDsTxjf5BJ64PwOw5milm2XwW7GVa8uCRUELkd1LYFuGMLt6Ah4jrN70QEUU
         31OT9EInZygNDytEQDxM4sDtMLkvlVIIsqFjXoj6WNMzfPd0l6vprAeN/+V/YsPAP5Lv
         JsogO9dMBJnkS5SlH0hMWzGjzlFKOkPb9e1Emlwzsw9xselOq89j8G+7QTRws9Wsu/Uy
         0dHmMZi939KVWJ8WyqCQZnhkBA4kst9Vqc41P8TILnW+nhNgEewrzt7WBFFrN8NZj3y2
         +BxA==
X-Gm-Message-State: AOAM5331WFiOa0TcolCHJlqKMEWbdPOvSDcljSjTOSP1a+jWk4nzQjUW
        3iKrnMD9a0CPmXKAPfKItLM7iYGcOUA=
X-Google-Smtp-Source: ABdhPJwIFLFMqny6hm5t45KsdEzPj+UUrQ/gK3l+pbea/7zLAdMewltP/Uy3Vfn1dbYTMsef3IFyzA==
X-Received: by 2002:aa7:d385:: with SMTP id x5mr21405147edq.289.1616343492632;
        Sun, 21 Mar 2021 09:18:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id c20sm7390295eja.22.2021.03.21.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:18:12 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] add insert_last_instruction()
Date:   Sun, 21 Mar 2021 17:16:04 +0100
Message-Id: <20210321161609.45905-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321161609.45905-1-luc.vanoostenryck@gmail.com>
References: <20210321161609.45905-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

It's relatively common to have to add an instruction at the end of a BB.
More exactly, at the end but just before the terminator instruction.
What is done for this is:
1) remove the terminator
2) add the new instruction
3) add the terminator back

This is a bit tedious, need to declare a temporary variable for the
terminator and, more generally, it's low-level details.

So, add an helper for doing this: insert_last_instruction().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linearize.h b/linearize.h
index b6c8bf134065..493f6be1074c 100644
--- a/linearize.h
+++ b/linearize.h
@@ -195,6 +195,14 @@ static inline void add_instruction(struct instruction_list **list, struct instru
 	add_ptr_list(list, insn);
 }
 
+static inline void insert_last_instruction(struct basic_block *bb, struct instruction *insn)
+{
+	struct instruction *last = delete_last_instruction(&bb->insns);
+	add_instruction(&bb->insns, insn);
+	add_instruction(&bb->insns, last);
+	insn->bb = bb;
+}
+
 static inline void add_multijmp(struct multijmp_list **list, struct multijmp *multijmp)
 {
 	add_ptr_list(list, multijmp);
-- 
2.31.0

