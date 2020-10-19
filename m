Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CCEC43457
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56092225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oa7Fn4oK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgJSQMq (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbgJSQMq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40DEC0613D0
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a3so14660197ejy.11
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6EJC55/FlHu33srHnXJbqGfFQRI6gZex24sx3aDi0g=;
        b=oa7Fn4oKfSWQAAVQQ2ixqdsCHUYPTTvFdSLy/ryZiYlp28VCMcYYIdkU57Qy7vB56C
         7BwW2JFSukxW9cmWczpq20pJoNxWZe4h2JsxzVzxS1GEeptJVil7jpXAbfsOApP1/b5+
         Ts3y8iQe6c5GfG9YDYbIxUWh4Xoo61yGNCt6tSV1aZe01zCMwcz3FIdDVz1IOd4FkvUd
         HKno0uhjfB4JggUy+D29ThP6SUTGgDdOod/D/rUH3EnAPwSmhR3Qt9kqBLj2TFhJ2wap
         6PbFYU6781Mbi9heTF75CUIX1D5oVvkuxoFzFajInkB4ymsZVFZePcvy3DaIXf4CjuTk
         EXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6EJC55/FlHu33srHnXJbqGfFQRI6gZex24sx3aDi0g=;
        b=JctTpZ73I1IkcRfWfSgvmUHjqv0FQVOv8E3Av6NtwJYWveEomKLq1TD70e2zz3rozq
         GrjcLbYJritcNgWJA0ApWQE4DIPpigTC77hRgiRAdGN7d7MvZbKfi3d5kngscydAYkZ7
         rp3TZQBEEiD/tyEueCv9+Ol8PSeQpYdrb+LlY+lI+5on8WHMn1Lj9HwWFyUtL8mSQ7oU
         Th0wa9KvG0fNBZgkpRealLUY/bc30ndPuz8StXXAQfXkI0CasjLBhrE+J8GUTJVYRWbs
         k2wuNptAQygni2RaJ+5r+yryVeZF+VNEkEcJ7MVWmXlmJvLBqmU/dgWzOe79KREjj1o7
         mPng==
X-Gm-Message-State: AOAM530bv9SrPlI7Dn08AwycdNPUB5W3ssMQSVLEApK9WcoQsnLfx5Q0
        8HVybZ3islvbpM+CjPTFI82UGY0Ml4Q=
X-Google-Smtp-Source: ABdhPJzR1TEGm2ZMKTlZf+/NbNo/7Q2nLu+fgkaNsllW0D9fv/rXR70XRxb3WqzqSAkU9wWUlyKWFQ==
X-Received: by 2002:a17:906:b204:: with SMTP id p4mr665291ejz.214.1603123964453;
        Mon, 19 Oct 2020 09:12:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:43 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 11/12] builtin: add support for __atomic_clear()
Date:   Mon, 19 Oct 2020 18:12:25 +0200
Message-Id: <20201019161226.97429-12-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The first argument is supposed to be a pointer to a bool, but
of course, a volatile qualified pointer should be accepted too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c                         |  1 +
 validation/builtin-atomic-clear.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 validation/builtin-atomic-clear.c

diff --git a/builtin.c b/builtin.c
index 1a95018c7699..b481a8102f38 100644
--- a/builtin.c
+++ b/builtin.c
@@ -483,6 +483,7 @@ static const struct builtin_fn builtins_common[] = {
 #define vol_ptr		&volatile_ptr_ctype
 	{ "__atomic_add_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_and_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_clear", &void_ctype, 0, { &volatile_bool_ptr_ctype, &int_ctype }},
 	{ "__atomic_compare_exchange", &bool_ctype, 0, { vol_ptr, &ptr_ctype, &ptr_ctype, &bool_ctype, &int_ctype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_compare_exchange_n", &bool_ctype, 0, { vol_ptr, &ptr_ctype, &dyntype, &bool_ctype, &int_ctype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_exchange", &void_ctype, 0, { vol_ptr, &ptr_ctype, &ptr_ctype, &int_ctype }, .op = &atomic_op },
diff --git a/validation/builtin-atomic-clear.c b/validation/builtin-atomic-clear.c
new file mode 100644
index 000000000000..ef430c64c244
--- /dev/null
+++ b/validation/builtin-atomic-clear.c
@@ -0,0 +1,15 @@
+void foo(void *ptr, _Bool *bptr, volatile void *vptr, volatile _Bool *vbptr, int mo)
+{
+	__atomic_clear(ptr, mo);
+	__atomic_clear(bptr, mo);
+	__atomic_clear(vptr, mo);
+	__atomic_clear(vbptr, mo);
+}
+
+/*
+ * check-name: builtin-atomic-clear
+ *
+ * check-error-start
+builtin-atomic-clear.c:1:6: warning: symbol 'foo' was not declared. Should it be static?
+ * check-error-end
+ */
-- 
2.28.0

