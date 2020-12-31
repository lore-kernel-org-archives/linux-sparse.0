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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E204CC433E6
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FE9207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgLaKMG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLaKME (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:04 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3194C0617A4
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g25so3653067wmh.1
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEYr+yB+gBcqyoBI7qwL7888Chcih5LwZx7EcfBOhzo=;
        b=IEg392W53SYNfN/BJBehWRT5Gx9ijQNtfAgzR4Du+yaKmo8e41PnFTBFTCWa0qGJSd
         uHTztu1TsFjtPYYKI68p+XFq3CwkyAeQTsvcUDkQ4qTKxaX/TbVZsUzSDq4g/xrnsQrE
         tSEJU1N3QUD6bts8Eva31gOjSRwvi2iOsfZ+cI5gn0iY86JC8Q79xsfc5Kx8s+NZuHLV
         wi6tPANqHKpi/Az952kafC9AWKqpxx5b8G4h0ff8t3yskx2BvPTE0TxBxR6uWpVpJ3Dp
         2vZswz8T07sXtHAdBspQqfg6cEUW0qjh1QMarS2k42NoE6nFuRsbhYrh7Qa4yk2MYWrQ
         Y1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEYr+yB+gBcqyoBI7qwL7888Chcih5LwZx7EcfBOhzo=;
        b=hZZWsd937rojvb6UETtDH1y56jarriivSqqHmnszGYcq04B0jqdNfc981ae06vU3IF
         DbHyRUUgA/RvD2ketWdFQ43xKezw6F9zxqIA5Mb88zusVvRdUXLF4rqMAoO00/hZIa0i
         TwuUTJ8E0QuWq4a9pf659cs8D4JnNYxWbOVu7FQajOsUMj2nGw2rbxw4HfHUz4rYoEuQ
         /NPRGhHDAD9sgInDmPya1giuYRi1SwNhPJxmj/W5Djsjseebd8+4AMM+3NxMyXAENGg0
         81FCGIvtwC2rIr2DF6Up7FigDUrFLUgyGPlSg93o50J6QPHv4mI9IH3baZPhMoBbsH82
         oCaw==
X-Gm-Message-State: AOAM531wXwSZ0zaiFuWQPFQCABr9k41pXRnHKnSMdSU7zE+eYm2dy8KP
        BARxm+PbAGSnhff/iyET5aAI3qhHaJY=
X-Google-Smtp-Source: ABdhPJwaRsUMYYztj+F0RzZvVnN4rnIiZkdeVOC++TeNKdzDppRy+RaRXF+Q28IfVLic/2yGjfLPzg==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr11051661wme.76.1609409449751;
        Thu, 31 Dec 2020 02:10:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:49 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 11/16] struct-attr: prepare to handle attributes at the end of struct definitions (2)
Date:   Thu, 31 Dec 2020 11:10:29 +0100
Message-Id: <20201231101034.59978-12-luc.vanoostenryck@gmail.com>
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

Prepare the handling of this by restructuring the code handling
struct specifiers, namely inverting the condition so that the
function can return early to make next patch's job easier.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/parse.c b/parse.c
index 41d3eb1ff4f8..663f2141dbf4 100644
--- a/parse.c
+++ b/parse.c
@@ -738,19 +738,19 @@ static struct token *struct_union_enum_specifier(enum type type,
 		ctx->ctype.base_type = sym;
 		repos = &token->pos;
 		token = token->next;
-		if (match_op(token, '{')) {
-			// The following test is actually wrong for empty
-			// structs, but (1) they are not C99, (2) gcc does
-			// the same thing, and (3) it's easier.
-			if (sym->symbol_list)
-				error_die(token->pos, "redefinition of %s", show_typename (sym));
-			sym->pos = *repos;
-
-			// Mark the structure as needing re-examination
-			sym->examined = 0;
-			goto end;
-		}
-		return token;
+		if (!match_op(token, '{'))
+			return token;
+
+		// The following test is actually wrong for empty
+		// structs, but (1) they are not C99, (2) gcc does
+		// the same thing, and (3) it's easier.
+		if (sym->symbol_list)
+			error_die(token->pos, "redefinition of %s", show_typename (sym));
+		sym->pos = *repos;
+
+		// Mark the structure as needing re-examination
+		sym->examined = 0;
+		goto end;
 	}
 
 	// private struct/union/enum type
-- 
2.29.2

