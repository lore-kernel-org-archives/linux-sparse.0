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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508CCC433E6
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248762184D
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgLZRwl (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgLZRwk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:52:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684A2C0613ED
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n16so5231855wmc.0
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFJdvKn92/GbKfPYvhWYQ4d/ziGHTHFbZbzDhbkWBEo=;
        b=paLtGJVTOK8GtVybkatpET4VERrgue0kK69XVdC7rShJ3Sxo+vEjygPSkN0euFHQn/
         K+YJ0oxOlsm41AEjAC+6pNazzP29+b0ivZEcVwq555ZBaXVPf/x4CEYHj1OD9n3LoYUd
         ABJVGAsmuNGnyO4580S5hnzuecRrVkcoETp5BfCRoKiBbiLpTEGJlsJTxS6EVI7bz5fa
         QGZpZmRUh0ZwYB5OXDHJKRfqslJi2IsQlHib34zxOn6v6s8asNoQhqpYmbUoNjLa1mrG
         DnlUlsUVkcsIkbgZvqcEp/Rs+uUThpGvuLXwcNQe46dGZNE29XPrztTc/uuLMn7HzQ19
         R0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFJdvKn92/GbKfPYvhWYQ4d/ziGHTHFbZbzDhbkWBEo=;
        b=CZQ5hUW8x+vVEjQwnPId5nWClcl/KRqEz46V7//TIDUDx6TONnJ4prdZGeYF3gfRC0
         YX92m6BvYt6ahHDANkh1M72I62va4nDEqIgKWl4ph4EuNyUzMEWRtUsA2CrUwRArVILJ
         FROgdpghIgiMxmsr12BJso90jhQ16bAFZqMxgRj16eHj9rBkmNmuWT6/4ONIi0is2COI
         oD2I+Uxa6yKapngKNFciIWuP+V8hBjqmLDq9vqI5K9xBZpN4ZhDMa6OzqsCiyi/WNY77
         /stM7uV8nV60vUpcxySMGQizfPZzGt9HLmlcemxbleNqK7TSnuQU8scw303QMo/dEVt+
         2vIg==
X-Gm-Message-State: AOAM530L9XEU3UmVuD+EYgUO2bJecRwWb8ireqJ9F/Qup8vlv072Aw1f
        LRFPaAqYlyVchqvNjw8SF4NCL1rSS4w=
X-Google-Smtp-Source: ABdhPJxqowhv0bciuMyRqyhxZNYuCiKFMrFk4e8Qly0/Lh52J67DCVdriByHIxR/RUItodGy9gd9bw==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr13223810wme.3.1609005119221;
        Sat, 26 Dec 2020 09:51:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:51:58 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 03/16] add testcases for enum attributes
Date:   Sat, 26 Dec 2020 18:51:16 +0100
Message-Id: <20201226175129.9621-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/parsing/enum-attr.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 validation/parsing/enum-attr.c

diff --git a/validation/parsing/enum-attr.c b/validation/parsing/enum-attr.c
new file mode 100644
index 000000000000..a962d8b417af
--- /dev/null
+++ b/validation/parsing/enum-attr.c
@@ -0,0 +1,29 @@
+#define __attr __attribute__((deprecated))
+
+enum {
+	old __attr,
+	cur __attr = 42,
+	new,
+};
+
+enum odd {
+	odd = __attr 33,
+};
+
+enum bad {
+	bad = 43 __attr,
+};
+
+/*
+ * check-name: enum-attr
+ *
+ * check-error-start
+parsing/enum-attr.c:10:15: error: typename in expression
+parsing/enum-attr.c:10:15: error: undefined identifier '__attribute__'
+parsing/enum-attr.c:10:15: error: bad constant expression type
+parsing/enum-attr.c:10:22: error: Expected } at end of struct-union-enum-specifier
+parsing/enum-attr.c:10:22: error: got 33
+parsing/enum-attr.c:14:18: error: Expected } at end of struct-union-enum-specifier
+parsing/enum-attr.c:14:18: error: got __attribute__
+ * check-error-end
+ */
-- 
2.29.2

