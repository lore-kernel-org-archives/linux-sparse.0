Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6922BC4332D
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4571E217A0
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgLZRxW (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgLZRxV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:21 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27C8C06179C
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n16so5231964wmc.0
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bXVie8ybNT/p+UjZ1bhJZ/QIq8btroN1ur4QMsVIgo=;
        b=QbKAH0l4ZEF7zXfdoaXl8NV/Rpng9foXgTo5hWDOJRMoR++0td7UVQLs6viQeUofTu
         5M4Ys+huaCM0acTLlMEANIXKXB5BlwCI2OY6OBKa4J7H4Q4N+Xan+pAA6FhK9sbMsgzj
         VohEodHSpKXd7nNWGU482OX8H5pQDQfLn5YKmmHYt2iLLoGmyKvPBqVqfuiUUuf+hnpT
         Zb62EapW9s4e60zj8blkkeAsS/EBOJFTEmAdy4ZsU5fGcmz4XntO2/6TPOKrB5AyVczE
         4qZ7Lb4xwfeCToIxqshPeN5M5PVqCoOEXqiGRrCNtiPpjZmiTuvzyJEAGS/yUMpYQcAB
         LWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bXVie8ybNT/p+UjZ1bhJZ/QIq8btroN1ur4QMsVIgo=;
        b=NlwofB0ZXTNCKPNsUlHrMfINsek0i7tEdKHJJHwVNUzE+Q9e1OPRtzc3zugWMQE68r
         giHUkRQxxWEEXH8BwxqWM1SVaZeCzOq/fZ2gxkTxVC4NXe1izpRMRKYD5lj0GOY1L92k
         rsOpBTL97mliCON1xB6YySXnv9qhHnyZ5ocg4fcKmXmepzVPq/nzqu9SN4+knGo1Y8hL
         0IXndQ7k/adnIfKzm7WpHUzbVUXRV5S+C/31d/2mUD9fGTZpveuUon5ayBo47WpcTFOf
         KckcEWp4RPvh+C8QkD5P2zdoGZE3payylwRz5dt3/1XKloHLYxdNBnv2r5Qbme+W5g+a
         C3xQ==
X-Gm-Message-State: AOAM531o4yIDlX74dZalgSdgJp78NVD3Jh4BTGUi+E+79g2WeEXbm+U6
        s/eyszT37YF68SJmVSxszAzQ+dwMqNo=
X-Google-Smtp-Source: ABdhPJy0L7TM6kdPHwgdRZ70zglFSgChPwGohimQDPZ9WYSMgtHZCOIZsy4FS1z5BIRHstJsstj79g==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr13186333wmb.76.1609005127573;
        Sat, 26 Dec 2020 09:52:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:07 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 12/16] struct-attr: prepare to handle attributes at the end of struct definitions (3)
Date:   Sat, 26 Dec 2020 18:51:25 +0100
Message-Id: <20201226175129.9621-13-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Type attributes for struct can be placed either just after the
keyword 'struct' or after the '}' ending its definition but this
later case is currently ignored.

Prepare the handling of this by having the 3 following cases in sequence:
1) a tag is present
2) no tag present but is followed by an opening brace
3) neither of these, so it's an error.
---
 parse.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/parse.c b/parse.c
index a90dcf7f7e4a..a67d567145d0 100644
--- a/parse.c
+++ b/parse.c
@@ -747,18 +747,15 @@ static struct token *struct_union_enum_specifier(enum type type,
 		if (sym->symbol_list)
 			error_die(token->pos, "redefinition of %s", show_typename (sym));
 		sym->pos = *repos;
-		goto end;
-	}
-
-	// private struct/union/enum type
-	if (!match_op(token, '{')) {
+	} else if (match_op(token, '{')) {
+		// private struct/union/enum type
+		sym = alloc_symbol(token->pos, type);
+	} else {
 		sparse_error(token->pos, "expected declaration");
 		ctx->ctype.base_type = &bad_ctype;
 		return token;
 	}
 
-	sym = alloc_symbol(token->pos, type);
-end:
 	set_current_scope(sym);		// used by dissect
 	token = parse(token->next, sym);
 	ctx->ctype.base_type = sym;
-- 
2.29.2

