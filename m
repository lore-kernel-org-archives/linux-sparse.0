Return-Path: <SRS0=XrIr=DV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D4C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BB4214D8
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfN4s+Y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgJNJVz (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731132AbgJNJVv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0EBC08E88D
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so2182155eja.2
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u94bsAtH5K5sSVbrHfFwOjoX84dBu7o23PCVNaYysfw=;
        b=jfN4s+Y+KFE65IxAqrPDfXoFAWKzWEGnoZTuWjb+UDMP7deUnLIyCUWWnnip/oVjj9
         N21lEhP6LCDYlp13BjQQLnXBVuR46Mz9abhe1UFsnfbfEhg/OZ/bms4GMpyE+pFhbqgq
         GtIN2uUt4DwCNWJY+KI70zl46vrFzIsKFT8l1sJbdGikZwGE8vO7mYHO6xGXzFmRgUkk
         pv5iz9eHLObn6DP3oWAr/hVJjf6o96u4sGxl/6+0x1jd9AcjCOxSylji/vF6alLl/7YM
         WBNgX1DNISyzf6bu6KUIWquKBxw8IaIgIKGPn76DUBaUgYvzKgurr5IcQt1iYC3FC/au
         ggvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u94bsAtH5K5sSVbrHfFwOjoX84dBu7o23PCVNaYysfw=;
        b=hduBNOdC6U+pJrdo3TY5KWIPcZ5hXp5tHKUnwJiYZNWurP2Yoe125dy9c7ry96JSkE
         UTRiUlWyBmyOxBeI0hWk+WMjHLCICyTHuCQjfEvOO+c0AGo7O8N1UfI7EM9FAD/QocTf
         4RCJsDKNixoPXip0D3nFpjeOSp0xs8MyHGjwkUqWtfsV6Yz/GHyZaVxMsR2zSum8hS2+
         wrDoFZUcVcfpvi1HgZSpCZJmGwzw6JNxFC1PE0pAqYuNfDyx6geJj7YsfIRyQS+POh+6
         w5uHfvyeVDei357efitE9GjZ69E/AkARuS1vAJuF1VdkRCYNTVncBzFP3g+QyVDmOo9X
         bPPA==
X-Gm-Message-State: AOAM530KDAH7utm2S9UIA4TXEaG89xsnzzWgPiZWnDOX0xVHQQP+eKWo
        ZXn0EB9KtGlO/Y59S64D9SorkvmUXnY=
X-Google-Smtp-Source: ABdhPJzxPSX4kYvtZIWRbRzAAEM1M2/ipQLKjFokisU42jkBrsg3BXppR7f9wVCUQXzbjZ3BgLeR4A==
X-Received: by 2002:a17:906:a59:: with SMTP id x25mr2190965ejf.489.1602631368985;
        Tue, 13 Oct 2020 16:22:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:48 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/13] format-check: remove printf_fmt_print_pointer()
Date:   Wed, 14 Oct 2020 01:22:27 +0200
Message-Id: <20201013232231.10349-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is currently not needed, so remove it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/verify-format.c b/verify-format.c
index cd55a49e0676..34c3db96fe3a 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -201,22 +201,6 @@ static int printf_fmt_pointer(struct format_type *fmt,
 	return !(*typediff = check_printf_pointer(fmt, ctype));
 }
 
-static int printf_fmt_print_pointer(struct format_type *fmt,
-				    struct expression **expr,
-				    struct symbol *ctype,
-				    const char **typediff)
-{
-	// TODO TODO: fix this here!!!
-	int ret;
-	ret = check_assignment_types(fmt->type, expr, typediff);
-	if (ret == 0) {
-		/* if just printing, ignore address-space mismatches */
-		if (strcmp(*typediff, "different address spaces") == 0)
-			ret = 1;
-	}
-	return ret;
-}
-
 static struct format_type printf_fmt_ptr_ref = {
 	.format = "p",
 	.test = printf_fmt_pointer,
@@ -367,7 +351,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		}
 		break;
 	case 'p':
-		type->test = printf_fmt_print_pointer;
+		type->test = printf_fmt_pointer;
 		type->type = &const_ptr_ctype;
 		/* check for pointer being printed as hex explicitly */
 		if (*ptr == 'x' || *ptr == 'X') {
@@ -375,7 +359,6 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		} else if (isalpha(*ptr)) {
 			/* probably some extra specifiers after %p */
 			ptr++;
-			type->test = printf_fmt_pointer;
 		}
 		break;
 	case 'n':
-- 
2.28.0

