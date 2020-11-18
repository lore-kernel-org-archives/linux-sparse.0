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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF14C63798
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CCC246B0
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIP7v6MW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgKRVLy (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKRVLy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 16:11:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5991C0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:11:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ay21so3555291edb.2
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tB7H+NEvFrt80vPQGak6mXL17G+DOEcOHEXuF8ABzo=;
        b=HIP7v6MWMp8bBhkyZNTJdh+UaLGvEI6SA3GuLI9yjjdvO0oOd8Moh1ZwNU0a68t3iJ
         3UwRqtdLTwWsZUVniADLNtQ9vXZVPm65gWmIGlamITVbIWn2blhpvfPdBy7fLdhvHtG4
         T/Ol0vUF7Y1sJuP30gesyY+wfiO7Y6zIBQT2gCiDnN6S0veLovb/2o+lzxyoOBBE34rG
         uz0HB20RHOb7gx8JblOijIXewZxa7Z9pOJbndlUrnL+fTaDy51hWhDhGRnE5h9Dxc/1k
         xd8FrOV79aR0PrbgPDTvQmi5i7tUAPowS346KK+ilqButgMXOlFi7pBbcsGjNcIQdPI8
         SWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tB7H+NEvFrt80vPQGak6mXL17G+DOEcOHEXuF8ABzo=;
        b=pS3YiTYGcphgU6b9mM4AP1bjEwJcTYhRwwvrcJjnMq9PXHnsKJt1Y36rKF3Ov1TlHn
         bMlK8Oc14vYTGv4XSS6BjeyQ6RCZuutDigNsIaVoU6kIyEiD5Jg+F+N+M4yc4GnMIx8O
         JFOEvvZAiWLN/pMuwFw2zhRR7CHMZCt7LvrICYv333uYYKD6hsQZ+DrJLcnksyU71CSe
         xy1xeNdx7T7oYlP2mLHKk/wHYY5sB7DSl0eCR1mmddc17PqdIGnnQ0snIImz1JmAU/Rv
         havBXUW2iDGKPiWDaVY1w0GBZaUfaAccCMUNdxhhmeERqXVTSpltmk7UhwKC25OggxCg
         q24w==
X-Gm-Message-State: AOAM531Zv1kZd7yA+MRMTVIaeii7DF6WsoJ0B9UbxrA8ixie61kDzRkq
        t9UUr2JViFgzNu5rBwoZL6RAvwqSn+g=
X-Google-Smtp-Source: ABdhPJwg8Xqxd/7h+tnxSjVL3oxdzFa1IjUiCE1lMqKueH0CBmesLUM5cBWVGc3kvzf9aXER0Tbuuw==
X-Received: by 2002:aa7:c886:: with SMTP id p6mr27087383eds.352.1605733912185;
        Wed, 18 Nov 2020 13:11:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:491a:3e51:301b:6e24])
        by smtp.gmail.com with ESMTPSA id rp13sm13510712ejb.79.2020.11.18.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:11:51 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] unqual: add testcases
Date:   Wed, 18 Nov 2020 22:11:43 +0100
Message-Id: <20201118211147.10680-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118211147.10680-1-luc.vanoostenryck@gmail.com>
References: <20201118211147.10680-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add some testcases related to qualifier dropping / lvalue conversion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/eval/unqual-comma.c     | 13 +++++++++++++
 validation/eval/unqual-postop.c    | 23 +++++++++++++++++++++++
 validation/eval/unqual-stmt-expr.c | 13 +++++++++++++
 validation/eval/unqual02.c         | 26 ++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 validation/eval/unqual-comma.c
 create mode 100644 validation/eval/unqual-postop.c
 create mode 100644 validation/eval/unqual-stmt-expr.c
 create mode 100644 validation/eval/unqual02.c

diff --git a/validation/eval/unqual-comma.c b/validation/eval/unqual-comma.c
new file mode 100644
index 000000000000..e06586cd43e3
--- /dev/null
+++ b/validation/eval/unqual-comma.c
@@ -0,0 +1,13 @@
+#define __unqual_typeof(x) typeof(((void)0, (x)))
+
+int *foo(volatile int x);
+int *foo(volatile int x)
+{
+	extern __unqual_typeof(x) y;
+	return &y;
+}
+
+/*
+ * check-name: unqual-comma
+ * check-known-to-fail
+ */
diff --git a/validation/eval/unqual-postop.c b/validation/eval/unqual-postop.c
new file mode 100644
index 000000000000..fb3082dc8836
--- /dev/null
+++ b/validation/eval/unqual-postop.c
@@ -0,0 +1,23 @@
+static void test_volatile(void)
+{
+	volatile int x = 0;
+	int *pp;
+
+	typeof(++x)		v1; pp = &v1;	// KO
+	typeof(x++)		v2; pp = &v2;	// KO
+}
+
+/*
+ * check-name: unqual-postop
+ * check-command: sparse -Wno-declaration-after-statement $file
+ * check-known-to-fail
+ *
+ * check-error-start
+eval/unqual-postop.c:6:40: warning: incorrect type in assignment (different modifiers)
+eval/unqual-postop.c:6:40:    expected int *pp
+eval/unqual-postop.c:6:40:    got int volatile *
+eval/unqual-postop.c:7:40: warning: incorrect type in assignment (different modifiers)
+eval/unqual-postop.c:7:40:    expected int *pp
+eval/unqual-postop.c:7:40:    got int volatile *
+ * check-error-end
+ */
diff --git a/validation/eval/unqual-stmt-expr.c b/validation/eval/unqual-stmt-expr.c
new file mode 100644
index 000000000000..bac6cb6b197f
--- /dev/null
+++ b/validation/eval/unqual-stmt-expr.c
@@ -0,0 +1,13 @@
+#define __unqual_typeof(x) typeof(({ x; }))
+
+int *foo(volatile int x);
+int *foo(volatile int x)
+{
+	extern __unqual_typeof(x) y;
+	return &y;
+}
+
+/*
+ * check-name: unqual-stmt-expr
+ * check-known-to-fail
+ */
diff --git a/validation/eval/unqual02.c b/validation/eval/unqual02.c
new file mode 100644
index 000000000000..f136cbd50510
--- /dev/null
+++ b/validation/eval/unqual02.c
@@ -0,0 +1,26 @@
+static void test_const(volatile int x)
+{
+	const int x = 0;
+	typeof(1?x:x)		i3; i3 = 0;	// should be OK
+	typeof(+x)		i4; i4 = 0;	// should be OK
+	typeof(-x)		i5; i5 = 0;	// should be OK
+	typeof(!x)		i6; i6 = 0;	// should be OK
+	typeof(x+x)		i7; i7 = 0;	// should be OK
+}
+
+static void test_volatile(void)
+{
+	volatile int x = 0;
+	int *pp;
+
+	typeof(1?x:x)		i3; pp = &i3;	// should be OK
+	typeof(+x)		i4; pp = &i4;	// should be OK
+	typeof(-x)		i5; pp = &i5;	// should be OK
+	typeof(!x)		i6; pp = &i6;	// should be OK
+	typeof(x+x)		i7; pp = &i7;	// should be OK
+}
+
+/*
+ * check-name: unqual02
+ * check-command: sparse -Wno-declaration-after-statement $file
+ */
-- 
2.29.2

