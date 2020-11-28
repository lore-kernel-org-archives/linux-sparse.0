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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC42C64E7D
	for <linux-sparse@archiver.kernel.org>; Sat, 28 Nov 2020 22:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70FD21534
	for <linux-sparse@archiver.kernel.org>; Sat, 28 Nov 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZnu/or8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgK1VuS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732486AbgK1SH6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 28 Nov 2020 13:07:58 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C7C0254A3
        for <linux-sparse@vger.kernel.org>; Sat, 28 Nov 2020 08:50:30 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g185so1405070wmf.3
        for <linux-sparse@vger.kernel.org>; Sat, 28 Nov 2020 08:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Youjrri2/q4+QVQkPAmXVl0rFXlBB9WPMRfQvNOoMmQ=;
        b=FZnu/or84oPZjRjVveQlVOUL83SEHiuhoz/bztVWH8lkwB0eIpmW7Zz4U6bNRKXs6/
         ITWnTa7T2CrcU9HqONdNeY021aFIlGk5KGxqZoWlY03YFacuDNrGKXkvOQUgt1VL7ATk
         PWyFAp8/i7Uv7AJclG0teVt8I8yOTYFRzsPf53Ei9O3PxD27NkMz4YSQ/BEeNwS17vUk
         EsvRq+dvgh33uOAZ8kJ0DZ1BrZfROs09OoGz3WvMMYci2OMtcYEIcbtEAwi0JrcAJ+7y
         yAgYqipmZ4STR8TfVmGIm4Ag9RvqmVMOn3aruf7pZzqE2Ffg7WEpvbKufbV6Cujvmuda
         M7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Youjrri2/q4+QVQkPAmXVl0rFXlBB9WPMRfQvNOoMmQ=;
        b=jxlciQdY5k+vZSdunbJjzUvkiz9QqrmbkXHs69AkYrruedz6LRfz5PIc1mAjNGmFhn
         5HT208FBTLhtII8J+mBq3Wfgi8D9rf77G+7TGm/jvc3AzUXI3fC/rx29s5PjQvpxL/u3
         t3Il+DZu5tlm/xyrVPcVRfXyEsYF0IrFDgLee6J6dJGj3JNSHDeyuwIFJHU6Q7Tapt1U
         UyAuU0MmRTQmS+pXH/tmbOCwiT2ITLa6L6U+3R2BkHAztfaGBq7CMHCR5o3ymb2tjWhf
         nB7/gMalfF4xVyLtOBs3qo4BTRH2GYaBC6S/sti2jfhDZnmyxHc/O/y8FDR7AAWFYZdu
         aNzQ==
X-Gm-Message-State: AOAM530uzbaOCdE8sCuVLpwDgIwz1giv3DkUA5oW16GUkjNh9JDTOkJm
        dzQB+aGYYKs0oisLzDhLs6vxW1rnJ/g=
X-Google-Smtp-Source: ABdhPJySwQeu479K+JgHts2IeuIc8zP7TampV0oBhGzuGgyEH9c8gqWwfevLLx/ev9n9cbg/cOptuQ==
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr15010940wmc.103.1606582228775;
        Sat, 28 Nov 2020 08:50:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:454e:9866:4e78:c039])
        by smtp.gmail.com with ESMTPSA id d16sm22233291wrw.17.2020.11.28.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:50:27 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] memops: kill dead loads before phi-node conversion
Date:   Sat, 28 Nov 2020 17:50:25 +0100
Message-Id: <20201128165025.19323-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

During load simplification it may happen that a load is unused
but if this fact is ignored and the usual conversion to a phi-node
is node, then this value may seem to be needed and can't be anymore
be simplified away.

Fix this by removing dead loads during load simplification.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c                              |  5 +++++
 validation/memops/kill-dead-loads00.c | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 validation/memops/kill-dead-loads00.c

diff --git a/memops.c b/memops.c
index badcdbbb9378..6baf4d163b00 100644
--- a/memops.c
+++ b/memops.c
@@ -111,6 +111,11 @@ static void simplify_loads(struct basic_block *bb)
 			if (insn->is_volatile)
 				continue;
 
+			if (!has_users(insn->target)) {
+				kill_instruction(insn);
+				continue;
+			}
+
 			RECURSE_PTR_REVERSE(insn, dom) {
 				int dominance;
 				if (!dom->bb)
diff --git a/validation/memops/kill-dead-loads00.c b/validation/memops/kill-dead-loads00.c
new file mode 100644
index 000000000000..df7ec037e2f2
--- /dev/null
+++ b/validation/memops/kill-dead-loads00.c
@@ -0,0 +1,22 @@
+void fun(void);
+
+void foo(int *p)
+{
+	for (*p; *p; *p) {
+l:
+		fun();
+	}
+
+	if (0)
+		goto l;
+}
+
+/*
+ * check-name: kill-dead-loads00
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: phi\\.
+ * check-output-pattern(1): load\\.
+ * check-output-end
+ */
-- 
2.29.2

