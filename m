Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71EEC47427
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B82F2075F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf8KvK1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbgI3XSo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbgI3XSi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6FAC061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e2so1128162wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4eWEw5lYC71dJVNgfeud3T/BUth3UQzZlVDmobacog=;
        b=Vf8KvK1IVnFqqnBvLkkpKBWe3hN/FswciahRD9laFODE8NdBgm9eBOjEA+XHuOe9FT
         vIOVix22KOMmBYvA0HnPsE21Cr2EF4u3h8ERXN7yyxpmW1mdY5xFi5PTlL0hTEdzDU0b
         OmwIcwRvuou9LtPPJHNuiOBwfV87dHbuxl6LQv7/2wqhT8NOtIi+WN/xlUIuwTuBe8LV
         6AXFZiYKzrN+YI4jX+i6iocUfxE7rvw9c4cyfc+uHWWn8Gd/ofmsb/siAyhTcbwvfGN6
         KIsZxUF9cLwiZ0vwJmO4xuHnGbNschn/TsgNWRNIxMkBIpWmBKLsTpmhiefU6FuDwNbn
         owvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4eWEw5lYC71dJVNgfeud3T/BUth3UQzZlVDmobacog=;
        b=gMNHnkp+06ZEKGcda2ZIlSE6fj468MdosJESvcv7oVLPlB6qtCkdfEDAYPUxrTlfdz
         TzqSLkrypy48y7hbr5HtTp3XCiZZd4K6gEKetU2inrhbvc987GlNYDzYvzmp62Jj5Fke
         34Ha2YpW5LxBvN86qcDRLqbaPEYM1Xff/A+dMFw/GlO+7zYQhwN9+5Qjuvb3HEDlj2VG
         BAvUbyfSVZVki/mB35NiM/Xt9aydofT12sxG2UroOTJ3//V9CQpXe21kXL83Zvyf25ox
         sp5mfzL/U74iFspF8CkOxZk5hYiUnsLIV0JwzwqYPVmQ5FJf0+7mN9mWHYS07rwkCsuU
         x49w==
X-Gm-Message-State: AOAM532emiS6Hgef2S/ACWqPGNAoQJnl8XyaOn2bdkgdhvBtLQaJL2jl
        01M6p3y3qaVhpMdozGG7+sFMe5PSzXk=
X-Google-Smtp-Source: ABdhPJwon8e/cT2piC8TUhaSHY32z63mFBu6biVPSJHa91Gdcz9o0D0Qjrf1Fn6nHLI4/Evw58RmSA==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr650303wmh.45.1601507915147;
        Wed, 30 Sep 2020 16:18:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:34 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/13] flex-array: factor out common part of lay_out_{struct,union}()
Date:   Thu,  1 Oct 2020 01:18:17 +0200
Message-Id: <20200930231828.66751-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is a preparatory step for later patches.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/symbol.c b/symbol.c
index 7f0c85580f06..365351a0a756 100644
--- a/symbol.c
+++ b/symbol.c
@@ -94,14 +94,6 @@ struct struct_union_info {
  */
 static void lay_out_union(struct symbol *sym, struct struct_union_info *info)
 {
-	examine_symbol_type(sym);
-
-	// Unnamed bitfields do not affect alignment.
-	if (sym->ident || !is_bitfield_type(sym)) {
-		if (sym->ctype.alignment > info->max_align)
-			info->max_align = sym->ctype.alignment;
-	}
-
 	if (sym->bit_size > info->bit_size)
 		info->bit_size = sym->bit_size;
 
@@ -125,14 +117,6 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 	unsigned long bit_size, align_bit_mask;
 	int base_size;
 
-	examine_symbol_type(sym);
-
-	// Unnamed bitfields do not affect alignment.
-	if (sym->ident || !is_bitfield_type(sym)) {
-		if (sym->ctype.alignment > info->max_align)
-			info->max_align = sym->ctype.alignment;
-	}
-
 	bit_size = info->bit_size;
 	base_size = sym->bit_size; 
 
@@ -196,6 +180,14 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 			sparse_error(member->pos, "member '%s' has __auto_type", show_ident(member->ident));
 			member->ctype.base_type = &incomplete_ctype;
 		}
+		examine_symbol_type(member);
+
+		if (member->ctype.alignment > info.max_align) {
+			// Unnamed bitfields do not affect alignment.
+			if (member->ident || !is_bitfield_type(member))
+				info.max_align = member->ctype.alignment;
+		}
+
 		fn(member, &info);
 	} END_FOR_EACH_PTR(member);
 
-- 
2.28.0

