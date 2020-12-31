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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C9C433DB
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF42207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgLaKLY (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgLaKLX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:11:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC38C061799
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q18so19751599wrn.1
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QOpZROY4T6jf1pyt6op8rBT8oi/2DDtRed21rNFCYV8=;
        b=pRBZznpiuicUx4unLI3qZHsCdTYChjYeJ+tHtnyayf3HUDbDBAuJvHmaPZyZp1Vf28
         CsMJCO7cazm9J8DDjyxB8yUcM/AiLH/PoH95fUVwHgu68jsvbMi3vLBM1yvBGh4BhcDw
         P8D+NCepkSsomAg9XYpHJSvLJdn+Sp9uJyH7RY3Xx2sV1MfLuGxdbSyvjx4l+Y52oBq2
         vBEmy6i6nR8ifM9559XohQQtkG+IXwC1cuOSOF31oyoHJqHipcWgKBKpG7OJ6pGlZ/wB
         VzVB20EKIM1MgEWvozjaHHvQfZwDgZUluIcKQ7CoJpZlVGAKGCklkAfFw3uP38DG11DN
         h5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOpZROY4T6jf1pyt6op8rBT8oi/2DDtRed21rNFCYV8=;
        b=JrG0YK8ggQzqn2213k3HbMRARGbKWGdUe6c/LkSBUMPktjZJ3fZezAeYDTjhLaUyEl
         rqrvh+eZG8RzP5jNeuvKMRlPsHLSUOUOMLqRkIdVvCjbc3EpVM6KW3dHFGRbqw2UNNzK
         qOItBT+YivagyOpLuTuEL4l9c69vaW1su26umKIfROGg5TmDxtiLvwzAu7bsdqKy5WsC
         sjpPbdewk4LUrMVp5tP1gswUxWeUescSe560qHIX5PjAMLjJ0hKP8dZ3NzAQt9i3bP8t
         +NbfXWPcG9gMi3xz/qsjd7yPDQVKSZkCwZKFwFNjmDb28aZWDD53C+x82bVxmxhZxLbm
         QMpA==
X-Gm-Message-State: AOAM531BsLrheWyA4nfUBY0cY2WWMXISeXp5Dcx5eQfJW5lgxarP1YOZ
        saAd46y6ARLvcxXjYAvtyp7SA15pAbQ=
X-Google-Smtp-Source: ABdhPJxdmFm8ALis4W/R8OL/d6L3s8zBJeByUjycPrSfaBeFRSnc++PIE5BysM/4CBwA3aSs8+3eHA==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr63463630wrt.287.1609409441722;
        Thu, 31 Dec 2020 02:10:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:41 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 02/16] add testcases for exotic enum values
Date:   Thu, 31 Dec 2020 11:10:20 +0100
Message-Id: <20201231101034.59978-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

There is more than one complexity in the evaluation of enums.

Add a test for enums with 'exotic' values not covered in other tests.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/enum-type-exotic.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 validation/enum-type-exotic.c

diff --git a/validation/enum-type-exotic.c b/validation/enum-type-exotic.c
new file mode 100644
index 000000000000..a17ca0ad48ef
--- /dev/null
+++ b/validation/enum-type-exotic.c
@@ -0,0 +1,28 @@
+enum foobar {
+        C = (unsigned char)0,
+        L = 1L,
+};
+
+unsigned int foo(void);
+unsigned int foo(void)
+{
+#ifdef __CHECKER__
+	_Static_assert([typeof(C)] == [enum foobar], "enum type");
+	_Static_assert([typeof(C)] != [unsigned char], "char type");
+#endif
+
+	typeof(C) v = ~0;
+	return v;
+}
+
+/*
+ * check-name: enum-type-exotic
+ * check-description:
+ *	GCC type's for C is 'int' or maybe 'unsigned int'
+ *	but certainly not 'unsigned char' like here.
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: ret\\.32 *\\$255
+ */
-- 
2.29.2

