Return-Path: <SRS0=Te2Z=BR=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD28C433DF
	for <linux-sparse@archiver.kernel.org>; Fri,  7 Aug 2020 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCF52177B
	for <linux-sparse@archiver.kernel.org>; Fri,  7 Aug 2020 20:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM+cZh8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgHGUpN (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgHGUpN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Aug 2020 16:45:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C9C061757
        for <linux-sparse@vger.kernel.org>; Fri,  7 Aug 2020 13:45:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id m19so3371132ejd.8
        for <linux-sparse@vger.kernel.org>; Fri, 07 Aug 2020 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wNdu1/DOW8/XoVW/DK2D8C8Zj8Bf0PQgzDE0AvkqKI=;
        b=EM+cZh8o0OY6lIbz3Jd1hVzrmCh6lyZBwZuTcksNY4ZyCfZqmd9waPfLxz6chqoq/m
         hms5Xq3STwR4OGvflsAcK1Ll3eS1/rka8nUU+hBZmEnRnOsqnnk/vBSF7jqkew3l00rh
         HeFCITgg2u77nmNfR/sLe9ztwzBAeZIrSVmgE9w4PskMgZe2MT6U9JzDojBuRgUISffK
         hFvAo2QMKkxzPg/m3X9WABJlV1jCLFdzJQk/pJzauSG3G0l74nV17p1v7OLsoxOt/BMx
         FxXbu3OBc7faIkAtoAFaIxG91eiGrMX37H9XumbR9mvBJV1PR+eOW8yelHLi8Cg3ofs8
         m/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wNdu1/DOW8/XoVW/DK2D8C8Zj8Bf0PQgzDE0AvkqKI=;
        b=mCAkKSAzzJgaHhgYY0Y9kAgGZ3LLTbhZhDvpAu5IGrOPj0/W6KFHvphOLUoAu/X4r2
         V9XWuYSnRb6eQnjRSE0p6z2Teq2Eksl4axvHb9gnwdceF+E3b5UGO8sFCpNS2lt2CoN1
         5agyaQ3f9Mrau8SRRBGCpaQXbF9E5AZyBXQlrCzfoR8JKS5TdnBeGEZubmpi2Mfjg0h4
         x4S5ctcaYocJ3FJ3ORT+diCI05NYUr2Gaz7czOPTaaJJKUSBptD9HJF2SaaTZqujT1XK
         PV7ZEaz4k99HBfQJ2bHC7s5OpONCquMMudu9FRGtN2SCJbmmclF9XiZezvd0gTdXHcYA
         1T1Q==
X-Gm-Message-State: AOAM531pBRYKI2FDAQa7GzoZ1HgHVOUYonaE85KWeCKlyR1uEwtLoP77
        XxBoet74RVDlKXqlaCkDwqwS+rwK
X-Google-Smtp-Source: ABdhPJyVLivDnQh92j5jAm6ma4xkioCkhIfu3uNYCed+E5wpUz/REY5NkP5JrWe6gy4LSOQFeGhBOQ==
X-Received: by 2002:a17:906:d159:: with SMTP id br25mr10762739ejb.16.1596833111751;
        Fri, 07 Aug 2020 13:45:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:8076:aed9:5a81:5448])
        by smtp.gmail.com with ESMTPSA id u4sm6120883edy.18.2020.08.07.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:45:11 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add testcases for __sync_{bool,val}_compare_and_swap()
Date:   Fri,  7 Aug 2020 22:45:04 +0200
Message-Id: <20200807204506.1100-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807204506.1100-1-luc.vanoostenryck@gmail.com>
References: <20200807204506.1100-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/builtin-sync-cas.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/validation/builtin-sync-cas.c b/validation/builtin-sync-cas.c
new file mode 100644
index 000000000000..e289eba2949b
--- /dev/null
+++ b/validation/builtin-sync-cas.c
@@ -0,0 +1,26 @@
+static int *foo(int *ptr)
+{
+	__sync_val_compare_and_swap(ptr, 123, 0L);
+	return __sync_val_compare_and_swap(&ptr, ptr, ptr);
+}
+
+static long bar(long *ptr)
+{
+	return __sync_val_compare_and_swap(ptr, ptr, 1);
+}
+
+static _Bool boz(_Bool *ptr)
+{
+	return __sync_bool_compare_and_swap(ptr, 0, ptr);
+}
+
+/*
+ * check-name: builtin-sync-cas
+ * check-known-to-fail
+ *
+ * check-error-start
+builtin-sync-cas.c:9:49: warning: incorrect type in argument 2 (different base types)
+builtin-sync-cas.c:9:49:    expected long
+builtin-sync-cas.c:9:49:    got long *ptr
+ * check-error-end
+ */
-- 
2.28.0

