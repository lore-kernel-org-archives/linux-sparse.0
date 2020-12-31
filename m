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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E10BC433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA182158C
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgLaKME (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgLaKME (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157BC0617A3
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q75so6899009wme.2
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+epDQOkwFtZusIzEyGRmFVIO1WJ7cBVcLRDq+IwgRA=;
        b=DLZEkKOmeX5P/xBtuOI9Hq0knWZMInfEuh6d/ZydsSXjsHjW9Y9Ud4iUQ2+DhhOIYN
         FIbjItMKQM1n37mE7TddmHVj9+K2fAuNp2q7Ygx9B0NULj4YtqhNQdo8ibJTJkrflQXJ
         gvkSiO9MEh1WU00fIfzXPDJ5nwig4l4O2YNaVPr+u7SdCrU72h6mzLHhvIeGa0g6JqQu
         /UCw2Y8RkHOg6XXOBRf5yNHlw+JHsN+wSoxHUs1pYxE/APxS0boKTJtuXAWZK2Suf/XT
         4I7c1T+caB07hYtWr/EIPtubYclH1UeEBvwuZVpks9/F1xLSKZffHnzpn27g/Rebt7+B
         h4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+epDQOkwFtZusIzEyGRmFVIO1WJ7cBVcLRDq+IwgRA=;
        b=qYDSnfhwKD+WT0ZPhYS+9ftC9PbAhObTetg7ax9jTwmzHgpgXr5rI9rCP72NMMU285
         kk6KJTNxYBA/e51e9qBjEeCCwVB2AY72vnFoCYpnSm8Zeti3Ah2PGsNFL/57+SZLNRzS
         aPkso98AulieRAy+lI4hJVcpOZaKS7UYhgihUyP/i8L5F58U9Qk4LPYGKzcGpLxJiRvC
         jaVAWa4WDZiXlwEVHhxI5Ega3h5lPydfQXkkCHFeb7D5c3PsVeCRPcDlY0cFM/2lTzcU
         Ym9o7we2BcqRx+Pr+frMyhGkpgQ3bJTiLa48koqo4SADD3JIxA7taTNaTg4cTS0yS2Pa
         vGLg==
X-Gm-Message-State: AOAM530fvbhftmtHLqqv2LG+RWx4CwgHuZK3hcTGkMzjUZ76ymZSMfrw
        UmT/BFDv50q/XGDKvSf3OR6oOH+nzIw=
X-Google-Smtp-Source: ABdhPJw9vbxyKOFdH6o4zkU0KNRG6iJN/wrOUG53a1l3V9qWg/RC8g2sF5AGJ7fRhJY98iw+VILZ3A==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr11085660wma.141.1609409448525;
        Thu, 31 Dec 2020 02:10:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:48 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 10/16] struct-attr: prepare to handle attributes at the end of struct definitions (1)
Date:   Thu, 31 Dec 2020 11:10:28 +0100
Message-Id: <20201231101034.59978-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Type attributes for struct can be placed either just after the
keyword 'struct' or after the '}' ending its definition but this
later case is currently ignored.

Prepare the handling of this by factoring the code common to both
cases in a single place.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                        | 10 +++++-----
 validation/parsing/enum-attr.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/parse.c b/parse.c
index d6343f0e48bf..41d3eb1ff4f8 100644
--- a/parse.c
+++ b/parse.c
@@ -745,12 +745,10 @@ static struct token *struct_union_enum_specifier(enum type type,
 			if (sym->symbol_list)
 				error_die(token->pos, "redefinition of %s", show_typename (sym));
 			sym->pos = *repos;
-			token = parse(token->next, sym);
-			token = expect(token, '}', "at end of struct-union-enum-specifier");
 
 			// Mark the structure as needing re-examination
 			sym->examined = 0;
-			sym->endpos = token->pos;
+			goto end;
 		}
 		return token;
 	}
@@ -764,9 +762,11 @@ static struct token *struct_union_enum_specifier(enum type type,
 
 	sym = alloc_symbol(token->pos, type);
 	set_current_scope(sym);		// used by dissect
-	token = parse(token->next, sym);
 	ctx->ctype.base_type = sym;
-	token =  expect(token, '}', "at end of specifier");
+end:
+	token = parse(token->next, sym);
+	token = expect(token, '}', "at end of specifier");
+
 	sym->endpos = token->pos;
 
 	return token;
diff --git a/validation/parsing/enum-attr.c b/validation/parsing/enum-attr.c
index a962d8b417af..8d851a162135 100644
--- a/validation/parsing/enum-attr.c
+++ b/validation/parsing/enum-attr.c
@@ -21,9 +21,9 @@ enum bad {
 parsing/enum-attr.c:10:15: error: typename in expression
 parsing/enum-attr.c:10:15: error: undefined identifier '__attribute__'
 parsing/enum-attr.c:10:15: error: bad constant expression type
-parsing/enum-attr.c:10:22: error: Expected } at end of struct-union-enum-specifier
+parsing/enum-attr.c:10:22: error: Expected } at end of specifier
 parsing/enum-attr.c:10:22: error: got 33
-parsing/enum-attr.c:14:18: error: Expected } at end of struct-union-enum-specifier
+parsing/enum-attr.c:14:18: error: Expected } at end of specifier
 parsing/enum-attr.c:14:18: error: got __attribute__
  * check-error-end
  */
-- 
2.29.2

