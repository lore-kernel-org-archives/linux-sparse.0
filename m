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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C755C433E3
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AA46194D
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCUMf0 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCUMfR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DCC061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e7so16015528edu.10
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1o4/AAviTzjOvQEMVjDCIR9CpsSISzmi4LdFcuk+Zm4=;
        b=Y+eOpMH9SjhpJzAQeyKiU4A3d4n00HTehbUalNCkRnYca4rzKAjYTm6YudGOGS2nso
         HxWpeOG3XFPftywjTUx02TaBmpUB7cpEkNINlU1lW6QS8tU/k8PoWLzoeSk62EXB5HXw
         JxodhXMIzou3QO2xMoUyFlOGy8agQGu5QJfIuOPnAKV5Wn0U58JLfswghA2TGESIIICy
         Um2feQdH5TRsy21FayhSo2tjm4s0ctrZZEyUrW/pNQvKoREf7zJMOAv4bfAUbO1P9ZXC
         RItU1KKk9AU7/ufcugp0mZSGF9oap6IQ1eLWZLhPVB29zV4tFI4muisNnpoYEXaKCcNc
         qdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1o4/AAviTzjOvQEMVjDCIR9CpsSISzmi4LdFcuk+Zm4=;
        b=qBYJY8dbHcsXMGTbJYzjbbaWe/xOfXRWiF1oB6deGqhzDIOHkctDN6XdwPa1WTZrJV
         CWy01S5rXpVkZVa8ZoseFCKp0aPWyerfokVMBM+KKSfHEu+ar1IK/XS0cy9qo6mBkDTS
         6Av4MCCYkHF9WX2GtQx1l7v2xoLo9rqQJWBR/Wxyc4zYWG4bWLHLLns9zDlOwUmLf/9H
         HpXVNMlCzpFrRGNqCDxNt0PmdTsf5CHD+gBAiUCxbYAv9VOKZnlwO0E9J2Bc1XCQ+1Re
         0nc2fVXRUzlmyc19vz0Aq6AOralZloX3Zf4zYIXqB1RITMJGiLKDWk4wTOTiMUxqBBHp
         tr7w==
X-Gm-Message-State: AOAM531gFRS2QhPnYMC0YcqqP6FAc1kz/kNlnuiTgLxUxtoX8KZGGTvL
        rwqZKeB513FF5Zrg2ja9oVqNVWmhTUA=
X-Google-Smtp-Source: ABdhPJz7XIB9jOhfDpKPBZ08SZuSZLBDN9db02Ll1GiqWdM7AvDDdwZiLZKXVORqlsYQIwuo+RKTFg==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr20193659edr.263.1616330115300;
        Sun, 21 Mar 2021 05:35:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/13] fold remove_parent() into insert_branch()
Date:   Sun, 21 Mar 2021 13:34:57 +0100
Message-Id: <20210321123505.27993-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Fold remove_parent() into its only user, insert_branch(), since it's
now just a wrapper around remove_bb_from_list().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/linearize.c b/linearize.c
index 6bb1287efcb0..2268b0951376 100644
--- a/linearize.c
+++ b/linearize.c
@@ -692,11 +692,6 @@ static void set_activeblock(struct entrypoint *ep, struct basic_block *bb)
 		add_bb(&ep->bbs, bb);
 }
 
-static void remove_parent(struct basic_block *child, struct basic_block *parent)
-{
-	remove_bb_from_list(&child->parents, parent, 1);
-}
-
 /* Change a "switch" or a conditional branch into a branch */
 void insert_branch(struct instruction *jmp, struct basic_block *target)
 {
@@ -720,7 +715,7 @@ void insert_branch(struct instruction *jmp, struct basic_block *target)
 			continue;
 		}
 		DELETE_CURRENT_PTR(child);
-		remove_parent(child, bb);
+		remove_bb_from_list(&child->parents, bb, 1);
 	} END_FOR_EACH_PTR(child);
 	PACK_PTR_LIST(&bb->children);
 	repeat_phase |= REPEAT_CFG_CLEANUP;
-- 
2.31.0

