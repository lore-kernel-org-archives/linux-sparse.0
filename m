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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868FFC4361A
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527BF22B40
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgLDRT3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbgLDRT1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Dec 2020 12:19:27 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA91C08E861
        for <linux-sparse@vger.kernel.org>; Fri,  4 Dec 2020 09:18:35 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id jx16so9730936ejb.10
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+tyHWiWXb7O5BhQLKgPqvaOMA9Oey7aHPdrxpKhN10=;
        b=e4UOHlHQxol+kodqdpOvCnhr3r2MFGcPfFRKNvgW1AtQEM2aLFPkGkjI/JfbS+HtRu
         fgTq3ZTNpcQTZB/du5yNOXjjep6Ugza3Gty/rUfUyhZlHTu5dXDalpjD27GkKq7TB3kk
         ZrGLWiIa5UBmKRUNCvB9sZY6+sYiKncnK5JNdmBUJTaoyLSLnrivCcKs8QK6ogQu47a4
         Pv2JiSuyOd9Ehzmy4PzqBIuf83Qs+YjGQcmrexOBAtXBpmP6E3A7o5KLS/uhw76PIi5R
         GQmXp/T45Pxjv90BCTyjcCCjybfhMwGzAqyo4EFa0r+SbP+bVJ9s2BTlxWa6aeX54QhQ
         LpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+tyHWiWXb7O5BhQLKgPqvaOMA9Oey7aHPdrxpKhN10=;
        b=VgGFdv3+5LuVzTkSar3ErfH93ZVngBkWM6tQXh3H2fp6j4HjjYQHL6XTWsr0cgaurz
         JI1YCbdGzewnPS6cNwQyNYHtDCLYtHy1XYMzvfBQNwEgFErw6E5oyyw26gB+fzoP0W0h
         iyh89Fo40lcfEz/BOhp3K4cYv11mhRYvCVzKjMM5QE6fqoCOHR1wz+r4lTKT0okCxzMN
         lnYZMGhEw2/YTUnveJxrvdN+NSTWSMqkK3XjIxZ08FxfJ0HuxqSXs3fB3HFqsP9bdKpm
         yvxWsmvHpvu3MTJPsh1ErLClb0P5hd9JAMuQG2Xo1aPv6H4ykl2SCHqk8GMXE+jTlSOF
         WfoQ==
X-Gm-Message-State: AOAM5303Y/9Yvbdnbo81tFNIXscdzlF436QTWYB+x7PDMEafldaKSN2b
        Ue4os2Z9NxvFiaVKldesSb5QlrR5buA=
X-Google-Smtp-Source: ABdhPJwgg2ixd5Ulc7bI+VtFYwaAATGgIei9Mg+o8JjZ9GxaoNS7w/utuu2oyk/LKxukANtdh1e2uA==
X-Received: by 2002:a17:906:7d91:: with SMTP id v17mr8233948ejo.522.1607102313574;
        Fri, 04 Dec 2020 09:18:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:8183:34c1:3ce4:9984])
        by smtp.gmail.com with ESMTPSA id p35sm4024188edd.58.2020.12.04.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:18:32 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] cse: place common expressions in the Lowest Common Dominator
Date:   Fri,  4 Dec 2020 18:16:04 +0100
Message-Id: <20201204171604.69635-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204171604.69635-1-luc.vanoostenryck@gmail.com>
References: <20201204171604.69635-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, during CSE, common expressions are eliminated if either:
1) they belong to the same Basic Block;
2) one of the expressions dominates the other (so, one of the BB they
   belong dominates the other);
3) they have a single parent which is the same for both.

The third case can be extended to another suitable ancestor:
any common dominator would be OK, which is exactly what is done in
this patch.

Note: This patch is interesting because it allows significantly more
      common expressions to be eliminated. However, it has the annoying
      disadvantage of making the 'context imbalance' problem slightly
      worse. So, it's not intended to be merged as-is.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/cse.c b/cse.c
index 1e58a973ecf6..c33babf2c6c8 100644
--- a/cse.c
+++ b/cse.c
@@ -279,20 +279,6 @@ static struct instruction * cse_one_instruction(struct instruction *insn, struct
 	return def;
 }
 
-static struct basic_block *trivial_common_parent(struct basic_block *bb1, struct basic_block *bb2)
-{
-	struct basic_block *parent;
-
-	if (bb_list_size(bb1->parents) != 1)
-		return NULL;
-	parent = first_basic_block(bb1->parents);
-	if (bb_list_size(bb2->parents) != 1)
-		return NULL;
-	if (first_basic_block(bb2->parents) != parent)
-		return NULL;
-	return parent;
-}
-
 static inline void remove_instruction(struct instruction_list **list, struct instruction *insn, int count)
 {
 	delete_ptr_list_entry((struct ptr_list **)list, insn, count);
@@ -318,7 +304,7 @@ static struct instruction * try_to_cse(struct entrypoint *ep, struct instruction
 	b2 = i2->bb;
 
 	/*
-	 * Currently we only handle the uninteresting degenerate case where
+	 * First try the uninteresting degenerate case where
 	 * the CSE is inside one basic-block.
 	 */
 	if (b1 == b2) {
@@ -332,22 +318,18 @@ static struct instruction * try_to_cse(struct entrypoint *ep, struct instruction
 		warning(b1->pos, "Whaa? unable to find CSE instructions");
 		return i1;
 	}
-	if (domtree_dominates(b1, b2))
-		return cse_one_instruction(i2, i1);
 
-	if (domtree_dominates(b2, b1))
+	/* Then try the case where one of the BB already dominate the other. */
+	common = bb_common_dominator(b1, b2);
+	if (common == b1)
+		return cse_one_instruction(i2, i1);
+	if (common == b2)
 		return cse_one_instruction(i1, i2);
 
-	/* No direct dominance - but we could try to find a common ancestor.. */
-	common = trivial_common_parent(b1, b2);
-	if (common) {
-		i1 = cse_one_instruction(i2, i1);
-		remove_instruction(&b1->insns, i1, 1);
-		add_instruction_to_end(i1, common);
-	} else {
-		i1 = i2;
-	}
-
+	/* No direct dominance - use the common dominator. */
+	cse_one_instruction(i2, i1);
+	remove_instruction(&b1->insns, i1, 1);
+	add_instruction_to_end(i1, common);
 	return i1;
 }
 
-- 
2.29.2

