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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBABC43462
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C63C61106
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhDJWbP (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 18:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhDJWbP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 18:31:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE6C06138A
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g17so9879896edm.6
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNjbWbULEADIj5i8KD6Ye7x71IlUG+wu/DFWWrEALHE=;
        b=MU5PmpVbMptQ98SDMtn4tFwA/2Gx+8mlvumx+HR1keobAQEAoyxSAHkJa0TKsjwRIG
         vmbEMwJ27GTVG6F+whDbtH2WQNI74woZgQE3lTiOXf61PlWscJg4LeNlvVczdVwb9uOy
         1CP6SdtZcTGwqfvxq25+NjA+VzoAbgH9fPobTj3upwjt/N0jNNq1qzpD24goG67Eg7RW
         wY4Xu3rRsYGN0T7ouA+Rjw1u27DgwldRWUoDQODkYQj5ViO0BLY4IuGFLM1GbQfxpTLt
         SMNTCuspzJ5a4dYn6Ek2aWcsuXnJ/XveQBegsARCdyazRg72ijHqnHowIaWoAJb7NYGD
         FCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNjbWbULEADIj5i8KD6Ye7x71IlUG+wu/DFWWrEALHE=;
        b=GBA1E1mXjIhwWiVsnw/r6QJKOdI37+wE1wHnZaGt9DR68H4akTMBjBhLRAHJI1h9RB
         9znRc0oTDChdQBUKfL4efW3FBu0Eb9ucAZrwadTVf5gRyF2uH44k0iYLODSy8M9aOg5B
         eRndsk4RIkkFsMKR0YiPx7+dzJZ9Wj+5BlUrgW8L67Ji0UgwiYn94aan2++yWHDF9GMf
         Hrxa2aSMFKGDBiFqRdLdEtRC9WJf8p+Jx3A07Nyi8ucQhY3GEn1bCwEES2XDPIA45AEf
         y2/EKtq3P5LnVVvkQwNELLebxgMlu/KywFtMTNZP20STCuCamkaZCJbhKKPVDKKTOFtb
         JCQQ==
X-Gm-Message-State: AOAM530JazEsqx0VIo8CR32ZbK7AYUpcrJgoJHubk8idOeQx2eUZvua3
        JO1ktP9R3B7zIxWe3HI9Nz2fRZD/dv0=
X-Google-Smtp-Source: ABdhPJw6lO2F0dlMxq8NVR6FNsksA3RD5fjtQperoIT6rOajfFMBiVrWRE+oSKPi8JEtFAvp4P0t/g==
X-Received: by 2002:aa7:d2cc:: with SMTP id k12mr22734610edr.374.1618093857456;
        Sat, 10 Apr 2021 15:30:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9597:4a1:b5b6:4666])
        by smtp.gmail.com with ESMTPSA id q18sm3701372edr.26.2021.04.10.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 15:30:57 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] extract try_to_kill_store() from kill_dominated_stores()
Date:   Sun, 11 Apr 2021 00:30:41 +0200
Message-Id: <20210410223044.86100-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
References: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Move the test/replace part of the store simplification in a
separate function so that it can be reused.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/memops.c b/memops.c
index ff54208e2d54..31fd2d3eaffc 100644
--- a/memops.c
+++ b/memops.c
@@ -204,6 +204,23 @@ next_load:
 	} END_FOR_EACH_PTR_REVERSE(insn);
 }
 
+static bool try_to_kill_store(pseudo_t pseudo, struct instruction *insn,
+			     struct instruction *dom, int local)
+{
+	int dominance = dominates(pseudo, insn, dom, local);
+
+	if (dominance) {
+		/* possible partial dominance? */
+		if (dominance < 0)
+			return false;
+		if (dom->opcode == OP_LOAD)
+			return false;
+		/* Yeehaa! Found one! */
+		kill_instruction_force(dom);
+	}
+	return true;
+}
+
 static void kill_dominated_stores(struct basic_block *bb)
 {
 	struct instruction *insn;
@@ -223,19 +240,10 @@ static void kill_dominated_stores(struct basic_block *bb)
 
 			local = local_pseudo(pseudo);
 			RECURSE_PTR_REVERSE(insn, dom) {
-				int dominance;
 				if (!dom->bb)
 					continue;
-				dominance = dominates(pseudo, insn, dom, local);
-				if (dominance) {
-					/* possible partial dominance? */
-					if (dominance < 0)
-						goto next_store;
-					if (dom->opcode == OP_LOAD)
-						goto next_store;
-					/* Yeehaa! Found one! */
-					kill_instruction_force(dom);
-				}
+				if (!try_to_kill_store(pseudo, insn, dom, local))
+					goto next_store;
 			} END_FOR_EACH_PTR_REVERSE(dom);
 
 			/* OK, we should check the parents now */
-- 
2.31.1

