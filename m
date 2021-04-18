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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D020C433ED
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 11:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071FC61207
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 11:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhDRL5N (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 07:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhDRL5N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 07:57:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB0C061760
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 04:56:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w23so32872185ejb.9
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NH0LNSWBNR9oDnZxvy31WWrnQiSVgZOVFw7tMgZKXy8=;
        b=hTP/kZIPzI+Ue92t3QpYpk019fwYfpa/WfaZJwJK1IJZnZfVrhHZnvOegqrRM5PYB9
         H4Vw9rlQ5Skr16AfOAtUuItiLYsKE2rkmIZJ9LB6cJtctJL4mUbV5BTm385QuQPTLH0b
         0pp/qo2dCkX+QqegPXioGnO7rogFkxi5x/8PDWqgMvJeW3NMcqDjA2+l2lf+0+8zqkds
         XSK7qCY/SqEo2k5Mu71f6U9baTy49aaYYkjRLdvD1qzYHumI5XJ7ZEqZXHjzS351iahl
         bz0//ZL/zkTCz1IkiheSi1nB2bAA87QaAoKoUyoSY/aqG/JnvAc8AwJlpGthvJekXlrW
         0aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NH0LNSWBNR9oDnZxvy31WWrnQiSVgZOVFw7tMgZKXy8=;
        b=dskyy+CiRhBjL5XBwEb5CxxaE8ZnpOcVBvCU6JcyOyxTc6YfIPpGIQcZSpQoN3P1S4
         rs0Xl+0cp0XUY3llaTNDhCCEqjHuZp6/meV5vH4KiC9xXGsjOGjQyCSnjr/r7OS2JiUX
         pBLT5djJwLPuveSdmJtlxPSO35vm7hZkx0F2Nh+vstRhVvpbmkUe3oc6Rr/Zfddx75o4
         3OtKuuu4ZtXFpETFpEZdNRED45NohEkICUyz6Sd03p/+B5y8aCghdtTIdvQu/x++dui6
         1QsVKWp4FTcvmgbkQFzLAzkCD/mme3JrDdCRGgg3fdz4SS4csTnshAO7hsaSKJ7xRxeL
         HyPw==
X-Gm-Message-State: AOAM530qZSi9O3AJAlnVo1vI7K/xPaXb25NbUy2++RsscB2ux7mWoBPf
        nY+h0Y4sXb87l3TMI1urQ/TEQ5m90dA=
X-Google-Smtp-Source: ABdhPJwwfaEiqEhcVmqzfcAMGE0rXGJbcoi2vqwKsPqg0UMPlvgvl9T91OE5a5TGql+U3FIH+1VU3Q==
X-Received: by 2002:a17:907:9607:: with SMTP id gb7mr16658165ejc.380.1618747003177;
        Sun, 18 Apr 2021 04:56:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:959c:c85:d486:38cf])
        by smtp.gmail.com with ESMTPSA id y11sm10298199eds.10.2021.04.18.04.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 04:56:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add testcases for simplification of casts.
Date:   Sun, 18 Apr 2021 13:56:33 +0200
Message-Id: <20210418115635.40608-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418115635.40608-1-luc.vanoostenryck@gmail.com>
References: <20210418115635.40608-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

and remove one that didn't made much sense.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/eval/not-cast-bool.c  | 15 +++++++++++++++
 validation/eval/not-cast-float.c | 15 +++++++++++++++
 validation/optim/and-extendx.c   | 24 ------------------------
 validation/optim/trunc-not0.c    | 21 +++++++++++++++++++++
 4 files changed, 51 insertions(+), 24 deletions(-)
 create mode 100644 validation/eval/not-cast-bool.c
 create mode 100644 validation/eval/not-cast-float.c
 delete mode 100644 validation/optim/and-extendx.c
 create mode 100644 validation/optim/trunc-not0.c

diff --git a/validation/eval/not-cast-bool.c b/validation/eval/not-cast-bool.c
new file mode 100644
index 000000000000..af4224125c34
--- /dev/null
+++ b/validation/eval/not-cast-bool.c
@@ -0,0 +1,15 @@
+static _Bool foo(void)
+{
+	unsigned char c = 1;
+	_Bool b = ~c;
+	return b;
+}
+
+/*
+ * check-name: not-cast-bool
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/eval/not-cast-float.c b/validation/eval/not-cast-float.c
new file mode 100644
index 000000000000..445b91d7563e
--- /dev/null
+++ b/validation/eval/not-cast-float.c
@@ -0,0 +1,15 @@
+static int foo(void)
+{
+	int i = 123;
+	float x = ~i;
+	return (x < 0);
+}
+
+/*
+ * check-name: eval-bool-zext-neg
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/and-extendx.c b/validation/optim/and-extendx.c
deleted file mode 100644
index 5c181c93384e..000000000000
--- a/validation/optim/and-extendx.c
+++ /dev/null
@@ -1,24 +0,0 @@
-typedef unsigned short u16;
-typedef          short s16;
-typedef unsigned   int u32;
-typedef            int s32;
-typedef unsigned  long long u64;
-typedef           long long s64;
-
-u64 ufoo(int x)
-{
-	return x & 0x7fff;
-}
-
-u64 sfoo(int x)
-{
-	return x & 0x7fff;
-}
-
-/*
- * check-name: and-extend
- * check-command: test-linearize -Wno-decl $file
- *
- * check-output-ignore
- * check-output-contains: and\\.64.*0x7fff
- */
diff --git a/validation/optim/trunc-not0.c b/validation/optim/trunc-not0.c
new file mode 100644
index 000000000000..febed165b0c4
--- /dev/null
+++ b/validation/optim/trunc-not0.c
@@ -0,0 +1,21 @@
+typedef __INT32_TYPE__ int32;
+typedef __INT64_TYPE__ int64;
+
+static _Bool sfoo(int64 a) { return ((int32) ~a) == (~ (int32)a); }
+static _Bool sbar(int64 a) { return (~(int32) ~a) == (int32)a; }
+
+
+typedef __UINT32_TYPE__ uint32;
+typedef __UINT64_TYPE__ uint64;
+
+static _Bool ufoo(uint64 a) { return ((uint32) ~a) == (~ (uint32)a); }
+static _Bool ubar(uint64 a) { return (~(uint32) ~a) == (uint32)a; }
+
+/*
+ * check-name: trunc-not0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.31.1

