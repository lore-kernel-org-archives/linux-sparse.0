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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C2C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4518064EC8
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhBUWfj (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhBUWfj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:35:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69E1C06178A
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:34:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id u20so25515680ejb.7
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2P241TTdYskntJuomQfjws2swqOAOJkaJvgVOeIZR4=;
        b=rx3Hppwh62vp/p4Wvmqzcpmo435yrH+0CAoLGaG5DhzRYSivKUcCBdP2qUIbzokNKm
         q9E+JfyBaSaaazMZmUeBW7KMVthz7XI/ToAKiLCPi3VfdQ6PKwKcterlrhK3r5ciyRhg
         cGWFWuzE9L7dI4pCO+q5CLu2yIAZ8+lUO3YQl8b1WLirtJ+3/OmN/nGwVOrhk2lzapsE
         Tp5zed7DBAXQsbhKcFO/CMZKN7jfuHXPX1sP811ramTzwBWHn84ji/JICwCjbvxbs3cL
         Zcv2WiAiR+ThwLjRZl1piqjwIL/gQhhChzjRsr/6G3gYBxjET2mk8Ive61eFcHW6keIn
         LD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2P241TTdYskntJuomQfjws2swqOAOJkaJvgVOeIZR4=;
        b=KwHhDAZ5OvH7zi/MK/9t/Oh3fY5qliIHd30R9aM4kzIlziyuumx+jfrUnjSh6GtFJ9
         kB0oA3eDioPh49+07bGnXS3h3pqcGr7wliXTQCaG4TdVM1WXEn6qZH91HsamnArPrjjR
         5tO1aiNR1bP1JfSlQHFhLPmUzs8q6C3h1irbDF36Nq4zDOCZkOsxzxx2Sn5Y57Bnhbsu
         9+vizRTH4nFEY0CJ2oj5aSIxF/iQDbNAdHlKhCoCJYtU5GsHx0UT7ERHsXxbJKkDe56J
         giP7vqQfe0rEVFOxJqn3FsviiSdV/qNqIlLJ+KfTOECrSdpAbxnoB5zCRrGJdEMCGk2A
         ovcA==
X-Gm-Message-State: AOAM531TSQSkUpMEk2ezVd7caqAOt28ySTxbktN0eRN3tmR9/03qqSB1
        g3ZxUa76OeSdqcIVRjZUd18tOiVNwcw=
X-Google-Smtp-Source: ABdhPJzLqaIxW8kVvPz1EsDJZtznS74Lg2Mh/fP9CdDJIN1BrlHdttROCl3Z6r09z0yPaEBR09lJZA==
X-Received: by 2002:a17:907:7667:: with SMTP id kk7mr6364125ejc.92.1613946897712;
        Sun, 21 Feb 2021 14:34:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id p2sm10433622edm.94.2021.02.21.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:34:57 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] asm-mem: add testcase for missing reload after asm memops
Date:   Sun, 21 Feb 2021 23:34:49 +0100
Message-Id: <20210221223452.8075-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
References: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Memory simplification is done with the help of the function
dominates() which determine when memory instructions interfere.

This function handles OP_CALLs, OP_LOADs and OP_STOREs but
memory can also be changed via OP_ASMs.

Add a testcase showing this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/mem2reg/asm-reload0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 validation/mem2reg/asm-reload0.c

diff --git a/validation/mem2reg/asm-reload0.c b/validation/mem2reg/asm-reload0.c
new file mode 100644
index 000000000000..c9e297dde428
--- /dev/null
+++ b/validation/mem2reg/asm-reload0.c
@@ -0,0 +1,15 @@
+static int asm_reload(void)
+{
+	int mem = 0;
+	asm volatile ("[%1] <= 1" : "=m" (mem));
+	return mem;
+}
+
+/*
+ * check-name: asm-reload0
+ * check-command: test-linearize $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: load\\.
+ */
-- 
2.30.0

