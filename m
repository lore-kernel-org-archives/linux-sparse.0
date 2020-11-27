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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5532CC3E8C5
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0419221D46
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYAq0y3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgK0W1x (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgK0W10 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 17:27:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B09C0613D2
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:25 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g25so3228808wmh.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LN6gco1zIlqtyCTgrYmmvxgCDWzIy9ZAVhewoEZKPDE=;
        b=oYAq0y3ZdZmjvH8LYghSQyhEd9JrjjHH3l8VB7/vpMnSpfhBMZQhOoj8K0FegoJtxB
         7cwuYGmrsTwdLkHEeSoJvN1HntPhagY0OcgUChcC7LQOhcXzm6BqJgq0p/z6RY79+CIR
         7vGEIiUzR5Zuc2yj7en2HEWS51sDKRoguYkHcmJVqu5YQ3dJ/ekPRDLXFQWXeTdTpris
         pGTubV9YAPolueIkq8g0H7/eLJFme3lJ2O5JP9EQLhBS9NDs6WJnqP5LcdfkszrFXqqf
         ol6d8uZ6+eVTbZErU4OpW7Nz4GjYrz6D+L+JJrfcA69LOpLrLd2InYX+1KmJVYyrw4Z5
         DZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LN6gco1zIlqtyCTgrYmmvxgCDWzIy9ZAVhewoEZKPDE=;
        b=G+VLw/qhP4jyAV+ngMrbAkpYkJypKOrzEprnD6lMc0X8fIbDVNxQl7Ut/59yZFLNDI
         YamubRDSGjbrPqJ8li6sM4CiQlF30pYfxDH0YvqpvKFswZMpq5TZB4CYRZsM4Epy/QBq
         5vqVS0XOCcFdoH4CHZUWtYJ4P6IZKSsmyOlkdueWmTczvYwxkopK7N94w9RD1Qtay63c
         6yGZhTTL2g6lyOJw8rx3PGaaF1sswWxXnMu+3aLoooc0u3HhTff0H/XO6PocM8WEULj1
         eEx16PRb31Wai+a0MvVvgdARa739W3gzvNAqSEOTQRXzNCYPP5pCuqZNczbcLFQ6WXcS
         Lhhg==
X-Gm-Message-State: AOAM532vU/Qy00eVMXQK+8G2TanqN8wU706jIKLOqu1m/DXrqiCk9rEp
        ZToRaERHUuqzX6R2oc6UDgZiXIHs6wg=
X-Google-Smtp-Source: ABdhPJxUHNLO4hASpyBYJf6z6/EoOhsW2KcSR0wD4S4N63P/WRbAjnyF3dV5tFcpvX+9YD3Yrp7KQg==
X-Received: by 2002:a1c:2605:: with SMTP id m5mr10118172wmm.111.1606516044063;
        Fri, 27 Nov 2020 14:27:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f469:b93b:e449:cc30])
        by smtp.gmail.com with ESMTPSA id q16sm17347050wrn.13.2020.11.27.14.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 14:27:23 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] add testscases for 'bits translation' optimization
Date:   Fri, 27 Nov 2020 23:25:10 +0100
Message-Id: <20201127222516.44915-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
 <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add some testcase related to the simplification of expressions like:
	if (val1 & BIT1)
		val2 |= BIT2;
into
	val2 |= (val1 & BIT1) {SHL/LSR} |BIT2-BIT1|;

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/fact-select01.c    | 26 ++++++++++++++++++++++++++
 validation/optim/select-and-shift.c | 18 ++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 validation/optim/fact-select01.c
 create mode 100644 validation/optim/select-and-shift.c

diff --git a/validation/optim/fact-select01.c b/validation/optim/fact-select01.c
new file mode 100644
index 000000000000..ef4e5e89a7be
--- /dev/null
+++ b/validation/optim/fact-select01.c
@@ -0,0 +1,26 @@
+int add_yx_y(int p, int x, int y) { return (p ? (y+x) : y) == ((p ? x : 0) + y); }
+int add_xy_y(int p, int y, int x) { return (p ? (x+y) : y) == ((p ? x : 0) + y); }
+int add_xy_x(int p, int x, int y) { return (p ? (x+y) : x) == ((p ? y : 0) + x); }
+int add_yx_x(int p, int y, int x) { return (p ? (y+x) : x) == ((p ? y : 0) + x); }
+int add_y_yx(int p, int x, int y) { return (p ? y : (y+x)) == ((p ? 0 : x) + y); }
+
+int ior_yx_y(int p, int x, int y) { return (p ? (y|x) : y) == ((p ? x : 0) | y); }
+int ior_xy_y(int p, int y, int x) { return (p ? (x|y) : y) == ((p ? x : 0) | y); }
+int ior_xy_x(int p, int x, int y) { return (p ? (x|y) : x) == ((p ? y : 0) | x); }
+int ior_yx_x(int p, int y, int x) { return (p ? (y|x) : x) == ((p ? y : 0) | x); }
+int ior_y_yx(int p, int x, int y) { return (p ? y : (y|x)) == ((p ? 0 : x) | y); }
+
+int xor_yx_y(int p, int x, int y) { return (p ? (y^x) : y) == ((p ? x : 0) ^ y); }
+int xor_xy_y(int p, int y, int x) { return (p ? (x^y) : y) == ((p ? x : 0) ^ y); }
+int xor_xy_x(int p, int x, int y) { return (p ? (x^y) : x) == ((p ? y : 0) ^ x); }
+int xor_yx_x(int p, int y, int x) { return (p ? (y^x) : x) == ((p ? y : 0) ^ x); }
+int xor_y_yx(int p, int x, int y) { return (p ? y : (y^x)) == ((p ? 0 : x) ^ y); }
+
+/*
+ * check-name: fact-select01
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/select-and-shift.c b/validation/optim/select-and-shift.c
new file mode 100644
index 000000000000..fbe044c7cb44
--- /dev/null
+++ b/validation/optim/select-and-shift.c
@@ -0,0 +1,18 @@
+#define S1	2
+#define S2	5
+#define S	(S2 - S1)
+
+#define	A	(1 << S1)
+#define	B	(1 << S2)
+
+int foo(int p) { return ((p & A) ? B : 0) == ((((unsigned)p) & A) << S); }
+int bar(int p) { return ((p & B) ? A : 0) == ((((unsigned)p) & B) >> S); }
+
+/*
+ * check-name: select-and-shift
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.29.2

