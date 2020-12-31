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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C454C433DB
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF5D2158C
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgLaKMG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgLaKME (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA88BC0617A5
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w5so19682512wrm.11
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lbx6ALZgE4iV9qDOFG81hFqrC8lHYFit6Y2RR8bYoL0=;
        b=DBvxmlveUwllrJ8V+Wou/JgN1tizk5OYlSgJYGPBTnOqRFDM6fd1QeF/TOn3HXM4J7
         uyDDoUW4Dsw7q9XCLHPSqN5UjPp3QgAZ4l58nWxhZ9NGX7E0ypQfq9eSzR1CU9r2CJIH
         xIsX7/Sjp5hu4TO4geR5IivzUCrJqswmSopdPo4SY67WrD1HSbrdmRHbAWSWC/uV47IX
         r6712UYAuY4yZGBS1qgJhhoWo4WPduNwBOowHInipPIsjFtyz6FIDcvUug2pSwpMCN0z
         t2mSZgiMBeMS19AfeBES9tPYlJDv53yZGrs52ycN+ZY1wrm1eWmv6i7UgKhca+XNW9cn
         k/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbx6ALZgE4iV9qDOFG81hFqrC8lHYFit6Y2RR8bYoL0=;
        b=XQNcwiM87ycpxXsTd2ElAA+daqyp6dKHAz9KHFvk6hBqFexSPg9Ir1OsX7KoKnD8ef
         p3Xc2bxjJxaGBMob+HnQIQZBsxyCYJn6BsR3OAHm9UphNFIuLKUr0uiRLGR5/41fhpxU
         /wCL3jwYca3Qwz9K24sCC4ARcVNQwhC0ZGNvSoLvkg0so1yuOQuOD6Ia6F4HZ/uQOVM2
         b9R+Su1xx1qUE3uaoq4mWWDahPWBmFMvMqy2j68igNMcH6oNpb5L1PISTcpWhhDSRsd+
         JfXPX5TERu427HHDaIYy97UnNd1Hr9HjPtimIz3LcSVl2ZLA0bcteT/4uOJ3+eziM+RV
         DffQ==
X-Gm-Message-State: AOAM533TxNzBBgskZa/8iXat4bJn7zvFF/kH9xAulqfYuIZBVtKyADRv
        cYQtKXcteQWc/TWB5BZlKyeO5sas2B8=
X-Google-Smtp-Source: ABdhPJxX+B3x+yxvrh5gfv1Pi2z89pTabKydA16bmGIKK7OEFqL92KiJKE724HIsnLQgWVn9g3WGeg==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr54209715wre.408.1609409450798;
        Thu, 31 Dec 2020 02:10:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:50 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 12/16] struct-attr: prepare to handle attributes at the end of struct definitions (3)
Date:   Thu, 31 Dec 2020 11:10:30 +0100
Message-Id: <20201231101034.59978-13-luc.vanoostenryck@gmail.com>
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

Prepare the handling of this by having the 3 following cases in sequence:
1) a tag is present
2) no tag present but is followed by an opening brace
3) neither of these, so it's an error.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/parse.c b/parse.c
index 663f2141dbf4..69bfc2e0fe57 100644
--- a/parse.c
+++ b/parse.c
@@ -750,20 +750,17 @@ static struct token *struct_union_enum_specifier(enum type type,
 
 		// Mark the structure as needing re-examination
 		sym->examined = 0;
-		goto end;
-	}
-
-	// private struct/union/enum type
-	if (!match_op(token, '{')) {
+	} else if (match_op(token, '{')) {
+		// private struct/union/enum type
+		sym = alloc_symbol(token->pos, type);
+		set_current_scope(sym);		// used by dissect
+		ctx->ctype.base_type = sym;
+	} else {
 		sparse_error(token->pos, "expected declaration");
 		ctx->ctype.base_type = &bad_ctype;
 		return token;
 	}
 
-	sym = alloc_symbol(token->pos, type);
-	set_current_scope(sym);		// used by dissect
-	ctx->ctype.base_type = sym;
-end:
 	token = parse(token->next, sym);
 	token = expect(token, '}', "at end of specifier");
 
-- 
2.29.2

