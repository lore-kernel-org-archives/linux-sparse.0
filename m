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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2335FC433E9
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE09D207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgLaKME (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgLaKME (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:04 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6EC0617A2
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d13so19673871wrc.13
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyQF353lYq1izEYPKpY3ieFNMCf34amRJhpkdo3ktuA=;
        b=miLhgQnZ7pRHiE/vJQOZGXP87GIutYpE/Q4oIMjtY3i84D2Wpc7pXMV+j0TLpmYaGF
         U+4ho+qnf08K5gQRFlj4y6S0P2tg8eBbfobYx3s9O6PpXdvexOQIrdOdl3Hl2aTvbAX3
         uXMjyVkNxDJCkkeFAjcwoBQyPKDSvBrrDMH4ia4rzjWzdLhpDOlvMmdfKAAuissc8o5W
         AquoiQl+1yqrUI2vIJaOuovjNwH1o1kfA576+EX6D6Z+N2uakfGSGP3a1uh0dLS5NXA7
         3RVh7w1XEaT82vZcT3gBUWg9Ld9J+uCypevskYp0lFSn7aNbJo6v7yCbReyFq2LJAHvz
         RtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyQF353lYq1izEYPKpY3ieFNMCf34amRJhpkdo3ktuA=;
        b=i0Y7T3hYs/nxYCB8JIskAwyT8nrpluT/lZyLanXFLmesalf5YkYvt4entwsMI0Uz/y
         sRH2/auJfuGDaPGsdtkW7bvTdULFEpkb3/KBFYzdXEbbK0LnGqBVe10furd4/DV88I8F
         L49AvZkhPhmlL+baNkyGT6huUUt/NThEK6ZtOybmetorWGPTsKTgK27SR7CeTJZeqX2P
         PWwLc6kLToXy3QNsSVVTtaMnkHaIao3G4S3wZ2gCchpxPfb5yFM2Q3CzYrjKEIQZngEG
         7r7EEE2e/csn/D2BZFbqdHAWOacHIGqUpvdz38/rN1075fB6EqEm0CTaC9AXU/pj9NH0
         1kWg==
X-Gm-Message-State: AOAM530w80fNOqBVH5Lhk+niwWobTAxgyeIkj6jh4t2OVfqcvx5ThDXo
        tqV2MC+JO41FmrDnE1/cRA/YJIFbE2c=
X-Google-Smtp-Source: ABdhPJyXEII9h1yWpwazVpshcbWdq1+gP42l6jyOiNvLVjE9PJM4Ii2yF5XZz2xk/+kTUbWdBiOdKw==
X-Received: by 2002:adf:8185:: with SMTP id 5mr62134760wra.44.1609409447678;
        Thu, 31 Dec 2020 02:10:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:47 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 09/16] apply_ctype: move up its declaration
Date:   Thu, 31 Dec 2020 11:10:27 +0100
Message-Id: <20201231101034.59978-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

apply_ctype() will be needed earlier in the code.
So, move it's prototype up.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index f106444f75d8..d6343f0e48bf 100644
--- a/parse.c
+++ b/parse.c
@@ -669,6 +669,8 @@ struct statement *alloc_statement(struct position pos, int type)
 
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list);
 
+static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src);
+
 static void apply_modifiers(struct position pos, struct decl_state *ctx)
 {
 	struct symbol *ctype;
@@ -1043,8 +1045,6 @@ static struct token *enum_specifier(struct token *token, struct symbol *sym, str
 	return ret;
 }
 
-static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src);
-
 static struct token *typeof_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 
-- 
2.29.2

