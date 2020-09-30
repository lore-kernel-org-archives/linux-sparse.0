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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED64C4363D
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0310C2076A
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvCq+pXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbgI3XSn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbgI3XSm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5219C0613D0
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so3570887wrs.5
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARt8KG7zV1fRZnUN/ydWn313HkkzGFCeK4o0EQzQEeM=;
        b=DvCq+pXhoiFGZDlByoNR2s23evf9nJUAkaBRkyZvBqiDqw6KQQU8czcna/1GoElKK7
         HwX7FkvQCh7gpeRpDhNfX6d0/r5mIk1PfqKAj/u6paEdIdNFiTMZxE6tZG/p5wu0MO39
         xv+u58ac19SmLqaQO3EytZRQXhPP5qMU9pNNL18hbilVe3Sb/YsjotExrCkfh0PUg/zI
         qH+uyYbBTFoqY/rFQRyWv2OAm7tCg5wbi4h9i0AvHsb/yF97Ofd/z1dNztQY/auFVD7U
         VBBunMdLnf0P7kX3o7ljs958tQXw//1jTcHY8BROO1jchX+9/M9NPrtJ3BEOFHjZYsPP
         5tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARt8KG7zV1fRZnUN/ydWn313HkkzGFCeK4o0EQzQEeM=;
        b=YBhr6jybNOfWKHtiTlptFKss+cq9lEC0LlnOeJVGbhQZm1byFgfk8tPQ5lFLb1Wfwy
         YN7ztKTs5Dz9a/ZtjFiM0TrtTIw4ZEOaq3POQNREvzYOBhmq+7ekIt6ly7JfBgJqxqIJ
         F24dS2OqPJvBIUMz70JQcjMEAXwK7hqVqrY7PHdaiuKIl8PvpSBXRljB7VAsB3i44K/T
         smeWFzVUX/MtQCDS7GUD7blSikqtGH6WVGFKJCagplJ7/48Vk7xB7P0R4x+xwNd81iGg
         siTZZtUrrU+WYxE7GsjjaQfXjweMw/0ORQoNGVCS3x+f6dhWEwTxvMbrEEgwF36gTmj9
         c/cQ==
X-Gm-Message-State: AOAM530v9YXstyz55ZS+5K4R7Dc0eEOGkF8vXZ3GSRwQBzt6mN6tboSE
        wxWf/+tkhkiQPw1/5GjqGRjmur3i2iQ=
X-Google-Smtp-Source: ABdhPJwbqf8Cp2lqBh5FiziaXqYfX7FAcmtdrOfmCuhRk1w2EsQ8d1FXyVaInkPaB5GFYG6f5C3frw==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr5473844wrs.395.1601507920274;
        Wed, 30 Sep 2020 16:18:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/13] flex-array: identify structures with a flexible array member
Date:   Thu,  1 Oct 2020 01:18:23 +0200
Message-Id: <20200930231828.66751-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Structures containing a flexible array must not be nested.
So, as a preparatory step, detect structures or union containing
a flexible array, possibly recursively and mark the corresponding
type with a dedicated flag.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 6 ++++++
 symbol.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/symbol.c b/symbol.c
index b4c5e471372b..bffdc135ba69 100644
--- a/symbol.c
+++ b/symbol.c
@@ -87,6 +87,7 @@ struct struct_union_info {
 	unsigned long max_align;
 	unsigned long bit_size;
 	int align_size;
+	char has_flex_array;
 	struct symbol *flex_array;
 };
 
@@ -206,6 +207,11 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 		bit_align = bytes_to_bits(sym->ctype.alignment)-1;
 		bit_size = (bit_size + bit_align) & ~bit_align;
 	}
+	if (info.flex_array) {
+		info.has_flex_array = 1;
+	}
+	if (info.has_flex_array)
+		sym->has_flex_array = 1;
 	sym->bit_size = bit_size;
 	return sym;
 }
diff --git a/symbol.h b/symbol.h
index a3ed95678ee5..287df0a3a0ee 100644
--- a/symbol.h
+++ b/symbol.h
@@ -185,6 +185,7 @@ struct symbol {
 					examined:1,
 					expanding:1,
 					evaluated:1,
+					has_flex_array:1,
 					string:1,
 					designated_init:1,
 					forced_arg:1,
-- 
2.28.0

