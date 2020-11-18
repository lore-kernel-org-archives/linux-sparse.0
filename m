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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FB0C6379F
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46118246B2
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWC3sAyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgKRVLz (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKRVLy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 16:11:54 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ADAC0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:11:54 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id m16so3554102edr.3
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSlCQnbvubc/6EU5L3H0FzpkYn93JO5457mk026+YyA=;
        b=EWC3sAyVk6rvEfDfkXDQXsCyaYN61Uc3rurzLD2I9Yuai3C9KD2k4PP1Vz26NGit/s
         yvpE3TM8p42QPHJFgAX6GfCTDtkhaPzax+Br16kUuefAx2iC7k9OTGvpxBuj/14rWwQI
         TTJKr3AQEjHsfoUR0SmybJDLWHneV82jiQaznVONHpNspm4ZHXa0pSaiwscbVenmdn56
         WWpne8m330mkZGqSNVAK3xYYOADxM34/r88XFT9b5C5n84ZsJGKYVvPH50outmBo+T6I
         M7g+JorAYEUXlJJSaDrnXKqHOTePqAJs7qXGAjTm0MRFk1UHG5eh+N9FsNMHoV+Qa5eV
         qb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSlCQnbvubc/6EU5L3H0FzpkYn93JO5457mk026+YyA=;
        b=Uc9ygDcb6y4dVoU9ClrfF+fK3m2vupDUxqPYngPvY2K9yKhzKjBbmuoISU/6gMgIfT
         PXQH1fkodg6P1dgn7jPXkTZ1xedQrTnhTSZR0wv751nhTb+jRNkGCE8ZJ86oddo9zHBK
         p9J8sNBPy0XZeqvHa4Yu6bkRgBy7WWKNuZEVm1XzMJzeYqUj8gBZyi63FKXqKqUmtRBp
         CD31NGMgI0N/1zjAe/lwWgJvrYeEVC1to2Lv9rQhrOj4qOqUou4WhBdwNeLifhNkYowS
         Gec7S3YSK69K4KkuUG/4rfVoiWhXde48dJ3pWWjzwvIAOIwdAY1m3eLczLT/GOLOmNj6
         sQCA==
X-Gm-Message-State: AOAM532Akta9V/PNTQOryl+gyOsVyEGvDTN1K5x8GqUSRcNdYdqKpupd
        ZSGbYlfc7jjt093beZpSAJzwIKD5+pc=
X-Google-Smtp-Source: ABdhPJzeFyYPM5eSZQavaC6pMwTo9Hy6Ml4O5OhxVBUzU8xa29Lo7wnRUWL2mbnahVpM4h3GNclbyg==
X-Received: by 2002:a50:b761:: with SMTP id g88mr27900439ede.387.1605733913219;
        Wed, 18 Nov 2020 13:11:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:491a:3e51:301b:6e24])
        by smtp.gmail.com with ESMTPSA id rp13sm13510712ejb.79.2020.11.18.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:11:52 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] unqual: unqualify_type() should check for null ctypes
Date:   Wed, 18 Nov 2020 22:11:44 +0100
Message-Id: <20201118211147.10680-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118211147.10680-1-luc.vanoostenryck@gmail.com>
References: <20201118211147.10680-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

It's possible that the input type is NULL, so add a check for it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/evaluate.c b/evaluate.c
index c39f9ec73da9..fd84205c7f2c 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -63,6 +63,8 @@ static inline int valid_subexpr_type(struct expression *expr)
 
 static struct symbol *unqualify_type(struct symbol *ctype)
 {
+	if (!ctype)
+		return ctype;
 	if (ctype->type == SYM_NODE && (ctype->ctype.modifiers & MOD_QUALIFIER)) {
 		struct symbol *unqual = alloc_symbol(ctype->pos, 0);
 
-- 
2.29.2

