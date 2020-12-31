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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C34C433E6
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03AD207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgLaKLY (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgLaKLY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:11:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A9AC06179B
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y17so19692592wrr.10
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFJdvKn92/GbKfPYvhWYQ4d/ziGHTHFbZbzDhbkWBEo=;
        b=DFsaIOvsDv4b/eqkqv1RugrVFJ45RBQzXKAp1ja8T9zFqGPMeUXjdW+aZ0ulSbbh+n
         gif2y2PezTJpNRGn7Mkz/Yz/nN/H1ajUef/oz99gzHK7Gf1J4b9wqSzqAwSUTkyxmDPN
         A87+YSUGLLyJdlUJFooHQiVSMSxbCvmyEzO0JMhUbmVwdcOtUZwZLzXZZ8l0jzGP4bTf
         Hk1AnR1qR4iOHoPVM0cjFGSKj5LI1J2IeIzhWtHC14H7AFQlHrm1+LqnrWKdVNnYrSg1
         NjjVhTBQ44iCA+rifvwshAaOtsEsLbWJviTsBWnNYxlnb3OKl+XrL3bJvNMhSLgFt9bR
         b8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFJdvKn92/GbKfPYvhWYQ4d/ziGHTHFbZbzDhbkWBEo=;
        b=HlpKCKfSZw/KZ9Bc5fhuq5c/eZVNcr0PXfS/sTDI2YKvmOH6lMH6GFjHF6ObKfPBEu
         UXXnWkpMD0rILnmUrId+u9ESZ1s1MMI/a4vEqQCAJKxEaJVHDPzSh3edssskgpYwQlK1
         IvUVLFtudeV8RK9/Vwd3+pDxHCT5n4fvLqcEl2jHdZhWk50wlpj3NWaR8P4ccl6JXXcY
         wgJq5UyOjvykPLAZlVVL8E57bc0kHxK9H6hC3L/jNYGU2N3k6sPjrPiv1YKGbfmI5FAL
         +ipAgBOinR+oSf/yss6AH3gW5uewDOL0/geO76nJZIZ1ORkehQyoznBcpeKWXDd3JtO1
         xv9Q==
X-Gm-Message-State: AOAM531jqF+TbvSNyzOudzuqMlqTRKQU8svq3niC1Usf4pjER2FRbfiA
        KTi8vRJYwCs4NKq0wwKEInfBl3Z+EYY=
X-Google-Smtp-Source: ABdhPJwSRZt4KPuBAXfaT5bqLnDYeNtdia8V/eCMFlNhnEUGcvIkSo4K+V9IE7c3bnvKjJqvr83BRQ==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr65044513wrs.284.1609409442545;
        Thu, 31 Dec 2020 02:10:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:42 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 03/16] add testcases for enum attributes
Date:   Thu, 31 Dec 2020 11:10:21 +0100
Message-Id: <20201231101034.59978-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
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

