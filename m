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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5269C43460
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 907E46113E
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhDBU0J (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 2 Apr 2021 16:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbhDBU0I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Apr 2021 16:26:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E2DC061788
        for <linux-sparse@vger.kernel.org>; Fri,  2 Apr 2021 13:26:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a7so8809096ejs.3
        for <linux-sparse@vger.kernel.org>; Fri, 02 Apr 2021 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNmtcZ/e6H/x3zSvyuDHsMo4X4OY6U5g11MOGEqOP2o=;
        b=PTgw+nlawMX+kfH7NKlPt50wPtg1Ux+eXQKI+BG5xSZUvoGiKXwmF9NtDhkHs78BsS
         LiHsHxWJ5APJhfKu+Ur+DAOwBbmOiObIZ1hUiorAWiqoPTrQ9Fwk15u7GS7aZ45rYUr1
         oOWXE56WUOsQpGxyRz/ixnGy4ioQWqWuMCi9ZWCwcYy7/zMEKcegt1ub7VQ8g1ZIHBuV
         lTGHvLZRSHRAYTIMkuekZglfPbhI/8HoKHA0RD2tbdJI9V4MJYXS/E9fUfH+vHYhUK/V
         zQviO+e6OvzR7zP3IGXHkNxA/xJRMPCQAd5HqTVy/QdHMb6aQJuIuzB7H5QljC/3t/yp
         A2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNmtcZ/e6H/x3zSvyuDHsMo4X4OY6U5g11MOGEqOP2o=;
        b=j4lqRvQk6O2QMybGUbh7RFWcwNIeM59ZOD9QfEi79I/CvZ4LQM5nHDi/B/GjXKRA2/
         QD9pg4l4n6RdpfhkgU/suNkMODRgJjjj5eYKtX1jvNM6tcsxMbAAGH1jV7E3ocEtUoWu
         2YFdJPK65Z1h9uzUjLQRBH0Jn7jHvNYah7AbG1ifKrpC5QtOJVH3GpBJZ9ty/P6RGAbx
         1ZPFJRzG7g2SeUe5Pga8HKw0B360k2NCGxcVmj07wUmxYLXlv7oQacICUZUvAqfPZlAx
         uglaavwahGeeGVkFHH1MqgaRm4bvozNgJSIRN1YAzQqssKOMMtHALYP5h3aHdtux/ovv
         ylaw==
X-Gm-Message-State: AOAM531XmHjV2q4c0rJsR/n/VNvrDraHpS8VS7pEFxL6/U94Mc1e2w4O
        fVM3JUYO4FhsD5OrCN5ROadM1uPUfG8=
X-Google-Smtp-Source: ABdhPJxwr3U+N7hyswXpOmD2ej8spg68Ph5BX6dYOth7vnbYpPfoi18YFk1qEMiiL06bhWmNC54X5w==
X-Received: by 2002:a17:906:3751:: with SMTP id e17mr16002772ejc.553.1617395164781;
        Fri, 02 Apr 2021 13:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8a3:6a32:4891:b7b])
        by smtp.gmail.com with ESMTPSA id p24sm6011890edt.5.2021.04.02.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:26:04 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] correctly count phi arguments
Date:   Fri,  2 Apr 2021 22:25:56 +0200
Message-Id: <20210402202558.54504-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402202558.54504-1-luc.vanoostenryck@gmail.com>
References: <20210402202558.54504-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In a phi-node,pseudo_list_size() can't be used for counting its arguments
because VOIDs must be ignored.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                         | 18 +++++++++++++++++-
 validation/optim/phi-count00.c | 27 +++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/phi-count00.c

diff --git a/flow.c b/flow.c
index cb94fcf20834..58807432b3aa 100644
--- a/flow.c
+++ b/flow.c
@@ -189,6 +189,22 @@ out:
 	return false;
 }
 
+///
+// count the true number of argument of a phi-node
+// VOID arguments must be ignored, so pseudo_list_size() can't be used for this.
+static int phi_count(struct instruction *node)
+{
+	pseudo_t phi;
+	int n = 0;
+
+	FOR_EACH_PTR(node->phi_list, phi) {
+		if (phi == VOID)
+			continue;
+		n++;
+	} END_FOR_EACH_PTR(phi);
+	return n;
+}
+
 /*
  * When we reach here, we have:
  *  - a basic block that ends in a conditional branch and
@@ -211,7 +227,7 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 	 * simplify_symbol_usage()/conversion to SSA form.
 	 * No sane simplification can be done when we have this.
 	 */
-	bogus = bb_list_size(bb->parents) != pseudo_list_size(first->phi_list);
+	bogus = bb_list_size(bb->parents) != phi_count(first);
 
 	FOR_EACH_PTR(first->phi_list, phi) {
 		struct instruction *def = phi->def;
diff --git a/validation/optim/phi-count00.c b/validation/optim/phi-count00.c
new file mode 100644
index 000000000000..38db0edaea0e
--- /dev/null
+++ b/validation/optim/phi-count00.c
@@ -0,0 +1,27 @@
+inline int inl(int d, int e, int f)
+{
+	switch (d) {
+	case 0:
+		return e;
+	case 1:
+		return f;
+	default:
+		return 0;
+	}
+}
+
+void foo(int a, int b, int c)
+{
+	while (1) {
+		if (inl(a, b, c))
+			break;
+	}
+}
+
+/*
+ * check-name: phi-count00
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-pattern(0,2): phisrc
+ */
-- 
2.31.1

