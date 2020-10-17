Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A4AC43467
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38D220878
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCPfD/ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439829AbgJQW4v (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439827AbgJQW4v (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB7C061755
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u8so8719010ejg.1
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBMTECHk24dCmuASYwN15UEWJ11+jX5bB/+QCA/Zpuo=;
        b=NCPfD/tymi3VaPxcWaDXfPe02XIRBoQhQFrfnOjBsuqCiwJRbQMa+8K6y84+e/5xt/
         EywGIQsyBhvenIU2eCQrbPDrlfBvFprs7HW7mhHCfG9Tryfz4AWwUeLRr7pBChdPMR4l
         an+28i2ZD6tw+a/8iPJhKxIzELeP0meORbf9OBGsYl/02+JyPfVUmtpW+S2PeUEG6pTs
         zAvuCdhOSGkA4eUTyaE8Fdwezhx40G4a5WrvdwOdtyFJ6gVIsUUXLbRXZdiP+AEwYMxv
         U16k4M8NnSL+gt5O3VMRhSGUu9siHc5D8vuKAur29diFZJnoCNAAYuq5fovyJufHz14e
         b/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBMTECHk24dCmuASYwN15UEWJ11+jX5bB/+QCA/Zpuo=;
        b=gZpVLewSpCPqPzmJ4Rcr9/BYBDKalYfROQyMSGBwY0xDIRep/Y8UG/q0b95jeb6JjD
         KXApSKNTBWO7bNf9p9SStUAgJli0zG71aZ4D5RnhxXMgz4jhrxvCOeyNfAR3J3m1RwJT
         M13i1nBTlqTLkisvpZu0wr5wHfY3du/HZdDgyrMbFUVlBLz78dWr9RYWxBffYOXNMVMz
         Vb1JpuOIL2i6sjJIGcY8wGUsaeO2O9p+5re71+OX3bLXiP4PUfIwmT3bUz8/7nGUlIlc
         njdvDv5mYmuS21/QV0G2QhfCj1MbqCsut01n2ulXBgBXxEV4MXuQKXj/qFIRbr9eZcuk
         i5eA==
X-Gm-Message-State: AOAM530DazyjrGIGyQVrIa5sJ/aqknESsxaDyQH2FnzoSHIGGXP9o/m5
        WFYm700YIIyib/lrUDVENuv5KBU+JE0=
X-Google-Smtp-Source: ABdhPJwK3D9nC/m+9Od6stzEa6Kvu9qFAVM6YdjYVex/QOvo+RNNIcytm0Y97nC3g+BgShisGpxKFQ==
X-Received: by 2002:a17:906:b218:: with SMTP id p24mr10382510ejz.136.1602975408252;
        Sat, 17 Oct 2020 15:56:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:47 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/12] builtin: add support for __atomic_clear()
Date:   Sun, 18 Oct 2020 00:56:32 +0200
Message-Id: <20201017225633.53274-12-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
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
index 94f86a87c3e2..1c502597315f 100644
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

