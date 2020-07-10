Return-Path: <SRS0=t/C/=AV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABB7C433E0
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 00:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3451C2065F
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 00:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbjrQYdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGJAN6 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGJAN5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Jul 2020 20:13:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C1C08C5CE
        for <linux-sparse@vger.kernel.org>; Thu,  9 Jul 2020 17:13:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d18so3213867edv.6
        for <linux-sparse@vger.kernel.org>; Thu, 09 Jul 2020 17:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enqFYqd6tgsb8MMCP7k85/ExV0OhBL6Pij31QI8um0w=;
        b=BbjrQYdBvuDokD3tLCVfsja/S3ZSlELJpPcfMfoUH52dLyCHaReSBI8ut+TCmxUn+4
         K4YT5jowiAOYplcpUzZkBDh0j+/wlWmsNPvZlKCzab/N0CuDIQGgPX47rRhaalNY+eZ5
         C/HWv1TcQPTkyabeth3pnGfdD/zr51hpxaGEYmf/AHfsf/dVWfFhd/u2+ZCkr2ZHFYVD
         wLI+lLev77DeR/gmIGNBzxrIm/MrZhRySAt1jFh0Qyny+59pfedf3OD/f8f8reBArrrt
         tzLuEv6XrQ1QJHYDb0SlP3AtnISDHReAOvHpCl2cqdB7qZMhb+odX3yQukvFv+42kQe2
         zvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enqFYqd6tgsb8MMCP7k85/ExV0OhBL6Pij31QI8um0w=;
        b=p00y4vB6zZatxdvd3lSDAbs4tQcY+PtZhWtqz8+yaDkLqCv7SHZpzwlO3IsvGqZKMS
         fk5gUXc4eSboHuTGEfzy/pye/wD6n9VG9q6Wl/fRxYzyLLDDK8hPPu4rII4nvDm1oe8/
         mFCDOGnS7Wrw4nw5mi4vVcayM43TEvWLWq+u2qv9TziFtpXCA2KE/SI/rBP8B7SxSPrh
         Qfg+GQ0hFzIFsaJ1GLNk2cQE7lK8rAgzO/1s1NhLmcZjs2VGJ4pY+jzQGQnGcc/VNCZO
         4Ub9toOMOl4CE0nfs+iQeCG3Zr7og9ZcfYJ8qOlhdteJKj2NHR4Y5I8GPc/ClsJE1uIQ
         53Gg==
X-Gm-Message-State: AOAM532UmiI2F1LETQi/1TT7uLrjwVveMICwoh3/RyQz/bHfaaiE1aAx
        K+zPe7zH9ufiWO6R0FNpeKh5eKXG
X-Google-Smtp-Source: ABdhPJye6ZpsMNYeSOpcZnFr+8iAjNoHozCc7gR47c6G7PNuTtfVpAS6X1eGJ24ouScD8JNg4ElIuA==
X-Received: by 2002:a50:d49e:: with SMTP id s30mr1702835edi.228.1594340035952;
        Thu, 09 Jul 2020 17:13:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:c80f:e21c:9480:e854])
        by smtp.gmail.com with ESMTPSA id u8sm2614199ejm.65.2020.07.09.17.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 17:13:55 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] add testcase for missing warning for assignment to const
Date:   Fri, 10 Jul 2020 02:13:21 +0200
Message-Id: <20200710001322.18391-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710001322.18391-1-luc.vanoostenryck@gmail.com>
References: <20200710001322.18391-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The problem is seems to be related with evaluate_dereference()
where all mods are dropped when the type is a node.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/eval/array-quals-node.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 validation/eval/array-quals-node.c

diff --git a/validation/eval/array-quals-node.c b/validation/eval/array-quals-node.c
new file mode 100644
index 000000000000..99a4db13e4da
--- /dev/null
+++ b/validation/eval/array-quals-node.c
@@ -0,0 +1,29 @@
+struct s {
+	int a;
+	int b[3];
+	int c[2][3];
+};
+
+struct c {
+	const struct s s;
+};
+
+extern struct c v;
+
+void f(void)
+{
+	  v.s.a = 0;
+	 *v.s.b = 0;
+	**v.s.c = 0;
+}
+
+/*
+ * check-name: array-quals-node
+ * check-known-to-fail
+ *
+ * check-error-start
+eval/array-quals-node.c:15:14: error: assignment to const expression
+eval/array-quals-node.c:16:14: error: assignment to const expression
+eval/array-quals-node.c:17:14: error: assignment to const expression
+ * check-error-end
+ */
-- 
2.27.0

