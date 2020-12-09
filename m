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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE901C4361B
	for <linux-sparse@archiver.kernel.org>; Wed,  9 Dec 2020 23:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72082207D1
	for <linux-sparse@archiver.kernel.org>; Wed,  9 Dec 2020 23:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgLIXcb (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 9 Dec 2020 18:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgLIXcY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Dec 2020 18:32:24 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA28C0613CF
        for <linux-sparse@vger.kernel.org>; Wed,  9 Dec 2020 15:31:44 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id u19so3515508edx.2
        for <linux-sparse@vger.kernel.org>; Wed, 09 Dec 2020 15:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSj+9xz0Xuv7H6CNykKmwRnUaXX6E9sJuvBIGVBChpA=;
        b=hO4KCloDTInlDkjyd/Pwexk2FrwP0EFvXv6lDYeqtYg4R/bHN4iZkTXvGWApNt0dl2
         dYM8AdXRCyCF5+TxZdEMj6zIzXX4CNGFRmD52P6I1sCDNhh5GNmqcapkuqIIBtXcTzlJ
         jwZp1pGON5GO0Rdsf9S/tR1rZeAdpHf9bbZ8+OASlHGjrDl9z8Z3qkccxekB8hvK85ch
         Kn7/D6GzomSlB8beFQqllS+hGL+YYoifeiTLTHBlCGY7KePSOFxbnwoao+ohSV3LrKdv
         epoipEYNtFJ3K5cjmJop0teI0jKZCvSLsc+TzAeh0TlkwKyaCQF7kcmawSVn9ioY92VH
         kbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSj+9xz0Xuv7H6CNykKmwRnUaXX6E9sJuvBIGVBChpA=;
        b=qJMnVBwpar09F+5S5uGPQWsrCOFTaBEJVUWxOH+R19ay8PTVt4+zkhXsRzBencToma
         MOy0+0K+PYVIy4SmQNJjA+LklGlGeFhEBOnQBXqh5XrHxmDwdS32Gk3jLhaibGQztuMM
         ikkSbg2hM00OOis68+ZCyPaYmWIysNb/kfVMAtw4NDkWZI1Lc1tWHoHSF0jJcj2yY4F4
         lSGZLIiBzumqFIV+qe5c296+DnDh0wRAFD0Kkm3p2ZEoQnp2f3/H6aGDkOsC6Eb0M7bY
         42lyTlFdTu1GB6+1CE6S8IB0yB2TwFT9FuMc9gLnbzF8zRCYoJv8bu+C+bH0jlNyo9Q2
         +Uww==
X-Gm-Message-State: AOAM530R/LPQuLrhiCPhMaYGC26x+az1uZ5nn6/SneOqGQIOnivwc16i
        9JM5YoF73yvBXOYBoblP3w82bwybAZE=
X-Google-Smtp-Source: ABdhPJzns+aY3Uhf0EMAibAHTMN7zw4jQ1CX93ffzon/Pzz5gwHnsocZlEJ6MtCC2HHG7eax6jLt+g==
X-Received: by 2002:aa7:d41a:: with SMTP id z26mr4246066edq.267.1607556702922;
        Wed, 09 Dec 2020 15:31:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f451:8d6a:c585:35fb])
        by smtp.gmail.com with ESMTPSA id m7sm3038240eds.73.2020.12.09.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 15:31:42 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] move check_access() to late_warnings()
Date:   Thu, 10 Dec 2020 00:31:38 +0100
Message-Id: <20201209233138.76056-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

check_access() is called at each run of simplify_loads().

However, a bad access can belong to a dead branch and thus a
bad access warning can be issued for code that is not executed,
maybe specifically excluded.

So, move check_access() to late_warnings(), where all optimizations
have been done.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                    |  6 ++++++
 memops.c                       |  3 ---
 validation/bad-check-access0.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 validation/bad-check-access0.c

diff --git a/linearize.c b/linearize.c
index 9fecb4b57e43..0250c6bb17ef 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2532,6 +2532,12 @@ static void late_warnings(struct entrypoint *ep)
 				continue;
 			if (insn->tainted)
 				check_tainted_insn(insn);
+			switch (insn->opcode) {
+			case OP_LOAD:
+				// Check for illegal offsets.
+				check_access(insn);
+				break;
+			}
 		} END_FOR_EACH_PTR(insn);
 	} END_FOR_EACH_PTR(bb);
 }
diff --git a/memops.c b/memops.c
index d96bd8a9090d..0a1106b0e464 100644
--- a/memops.c
+++ b/memops.c
@@ -147,9 +147,6 @@ static void simplify_loads(struct basic_block *bb)
 			struct pseudo_list *dominators;
 			unsigned long generation;
 
-			/* Check for illegal offsets.. */
-			check_access(insn);
-
 			if (insn->is_volatile)
 				continue;
 
diff --git a/validation/bad-check-access0.c b/validation/bad-check-access0.c
new file mode 100644
index 000000000000..3c4c023f2f89
--- /dev/null
+++ b/validation/bad-check-access0.c
@@ -0,0 +1,31 @@
+#define SIZE	2
+static int buf[SIZE];
+
+static inline int swt(int i)
+{
+	switch (i) {
+	case 0 ... (SIZE-1):
+		return buf[i];
+	default:
+		return 0;
+	}
+}
+
+static int switch_ok(void) { return swt(1); }
+static int switch_ko(void) { return swt(2); }
+
+
+static inline int cbr(int i, int p)
+{
+	if (p)
+		return buf[i];
+	else
+		return 0;
+}
+
+static int branch_ok(int x) { return cbr(1, x != x); }
+static int branch_ko(int x) { return cbr(2, x != x); }
+
+/*
+ * check-name: bad-check-access0
+ */
-- 
2.29.2

