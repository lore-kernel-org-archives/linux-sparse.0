Return-Path: <SRS0=pmk5=BI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A84C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 14:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1716208A9
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 14:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFZlr3Rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2Oxm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Oxm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Jul 2020 10:53:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCFBC061794
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jul 2020 07:53:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l4so24588622ejd.13
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jul 2020 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6w9SxCDW+RGlf8a9ios5W7u6vNV4PBlYVUDLWiwJNvU=;
        b=oFZlr3RmFTh8rGXPZRJNvWa8p+ew4Zc8w9mjaFNW7iRSk0zNYYWmzwFs8tPr5nFdOu
         3sFBvYztauhVz8z61PHbSQub5ImU3rfM0dj4Hb2+9xkCjdsbQTp/8aHpLGtlB5DYozvd
         3JeYMw/4rubKtsJcExIE781lhwrWkPFAnDWu0dMCI2Fs+JUpYoUeAQsXxuSccVPs2bPm
         BRiQg4iKQ6U5Sy2X1K4mXY8Mdbld+qNA2xU+r33H125sfQ39gkN7rquJWevmXsJ6pk0F
         RU0CznlYyMDUzapBPGp4oFVKQ4ktF+8FAXyG6yqIFeV36c72UH6vrX+V+42K8BP5LjQH
         DfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6w9SxCDW+RGlf8a9ios5W7u6vNV4PBlYVUDLWiwJNvU=;
        b=Nd8HmHff2h5EHl7+mpnWexo67mM9FqRNWJL3NciKb7VP7NqqIwnyizkOWYz8lHuAYU
         Dnjfzzq1SLncqwmRXio+wUHg25HdrN99T6xWz3bL2L8FzczG1alxB4+18fTOBPBKQgLA
         V84mDaoMQI9KbemnMYXB4P15mi8w2/unO3B1mNQWjiGU3xgialdk/1QujkqMzYyTTXPG
         4D7c9kfPmI2jOmxTOuVn6RafBeN8FZReUxDKXqKXb4EF+Xdb7xTNC683PaX8vuEiQKLz
         OmIi0h2EdS8+g/3aSlcXaYG/eJr+NPhiDCnPy02VU/KQfqPclZAtRBe7yuVbbl70cmVL
         LpRg==
X-Gm-Message-State: AOAM5311zICfTpj8qpw5F97AWaTCjUTravnXAtIIsAX6feFtANggOUpK
        GgUPy73sxnxtt4AaGdazkMCXWuAt
X-Google-Smtp-Source: ABdhPJy/tlcsaTV84Fai0TTp9ZFCSzAhkwDcK+zkINGzpccOeaTKmD6+OIhxSS5qQJojvl7nyXBGtA==
X-Received: by 2002:a17:906:d7b1:: with SMTP id pk17mr24305184ejb.554.1596034420098;
        Wed, 29 Jul 2020 07:53:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:98d9:cf3a:3f6c:265a])
        by smtp.gmail.com with ESMTPSA id j5sm1893061ejk.87.2020.07.29.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 07:53:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] dissect: use struct symbol::visited/inspected instead of ::examined/evaluated
Date:   Wed, 29 Jul 2020 16:51:32 +0200
Message-Id: <20200729145132.81479-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The dissect client uses struct symbol's fields 'examined' & 'evaluated'
to avoid reprocessing the same symbols. But these fields are used
internally by sparse for type examination & evaluation and despite
dissect not doing these operations explicitly, they can be done
implicitly (for example to handle static assertions or when the
value of a constant expression is needed).

So, add a new field to struct symbol: 'inspected' and use it, as
well as the existing 'visited', instead of 'evaluated' & 'examined'.

Note: when used on the kernel, this patch avoids a lot of warnings:
	"warning: r_member bad sym type=7 kind=0"
	"warning: r_member bad mem->kind = 0"
      and creates substantially more normal output.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 dissect.c | 8 ++++----
 symbol.h  | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/dissect.c b/dissect.c
index fd09707dbf67..582e8fc32e46 100644
--- a/dissect.c
+++ b/dissect.c
@@ -204,9 +204,9 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 	struct ident *name = node->ident;
 	struct symbol *base, *dctx;
 
-	if (node->examined)
+	if (node->visited)
 		return;
-	node->examined = 1;
+	node->visited = 1;
 	node->kind = 'v';
 
 	while ((base = node->ctype.base_type) != NULL)
@@ -228,9 +228,9 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 			break;
 
 		case SYM_STRUCT: case SYM_UNION: //case SYM_ENUM:
-			if (base->evaluated)
+			if (base->inspected)
 				return;
-			base->evaluated = 1;
+			base->inspected = 1;
 			base->kind = 's';
 
 			if (!base->symbol_list)
diff --git a/symbol.h b/symbol.h
index c2b60ce91c27..08d1134a7d82 100644
--- a/symbol.h
+++ b/symbol.h
@@ -209,6 +209,7 @@ struct symbol {
 		struct {			/* sparse ctags */
 			char kind;
 			unsigned char visited:1;
+			unsigned char inspected:1;
 		};
 	};
 	pseudo_t pseudo;
-- 
2.28.0

