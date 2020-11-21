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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC04C63777
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5D620738
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0lHCGdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgKUUxP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUxP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 15:53:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FC8C0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p8so14506685wrx.5
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qwa4aVnaJ+MYhsDmxRUQRMbkKnrRNCkuUNPaMQ349g=;
        b=u0lHCGdIJT0IH4Aw7K/Vu2EO2hhYu8jmH1EekiofCdOfDTcOor9bkQyz+VobXSawPt
         LqPMD8Pz4erczZRPNCE0AjIvJ6Y6LOX4c+deti22x3vAQ8eNzEaRdz4V8pt5SZEBxRUj
         RaR7r77BWEhP91+H7aS0fMDBXML4itxX85Sw66tFNHjgNe9wWwQWtEBISHNn8t04Pkpi
         dUSExhZI7eoGRsP73RE2fwL5Z3B9Ojgyb48KnagQFOQuv1tn6LFNzcKNxriH7pz1bKpq
         xkvV+B4qNlb6fN7lwPFVDx5vOjatb59W12qcg/SPF8flMK2oxPFWQhUgrbw3JAuFd6te
         Ol+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qwa4aVnaJ+MYhsDmxRUQRMbkKnrRNCkuUNPaMQ349g=;
        b=ne5Nt44qzGojW6zhpc1nGjkx+rM7HhTKMmvvwkNG0hg1xGvCZ6X/tT5a4uR/02mU2l
         fGUePuX+Nr0dwtlLTAQN8BWBnXDsmN6Aa8l6lUUw7/e4N1C7pNRcgloIrgromg94TLER
         vfsiQyAMyHQ89d1/Fm38GR6Jf3YXBs1mORVS7YXL042a7rkOp3DNksQgxumSX0KPrpgy
         PjPY47xU6jB1ir1bSFS9NASuuIriPg33emdNIKRGx8nAk5X55yO4riAOKSemzKCGgXpB
         ILrYLpWQxLrPwaP+dzU7uLwhtvQWSuSsK39wdMVSiYRiEIzoWyQIAddekFJeoks3AZa/
         EkOA==
X-Gm-Message-State: AOAM532Hk+hAoohJW5ENcn6t1NT0/kqfBIau7Sl5C3F+mFlWSDcyDTTK
        09Z2lyzuEeeVX06ML1eFkwzwS8CZniU=
X-Google-Smtp-Source: ABdhPJwFjmUC+mllhyfP3a+wrsTpdFD7NQqopdkVZjorhfdWcoqm44umbav3LMy/xebVHubnCk6+3g==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr21946201wrv.243.1605991993237;
        Sat, 21 Nov 2020 12:53:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dcb6:7e9c:ccbf:c450])
        by smtp.gmail.com with ESMTPSA id p4sm9369815wmc.46.2020.11.21.12.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 12:53:12 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] add testcases for COMPUTEDGOTO simplification
Date:   Sat, 21 Nov 2020 21:52:57 +0100
Message-Id: <20201121205300.94642-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
References: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/cgoto01.c   | 25 +++++++++++++++++++++++++
 validation/optim/cgoto02.c   | 18 ++++++++++++++++++
 validation/optim/cse-label.c | 14 ++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 validation/optim/cgoto01.c
 create mode 100644 validation/optim/cgoto02.c
 create mode 100644 validation/optim/cse-label.c

diff --git a/validation/optim/cgoto01.c b/validation/optim/cgoto01.c
new file mode 100644
index 000000000000..350c6cd99f08
--- /dev/null
+++ b/validation/optim/cgoto01.c
@@ -0,0 +1,25 @@
+void abort(void) __attribute__((__noreturn__));
+
+int foo(int a)
+{
+	void *label;
+
+	if (a == a)
+		label = &&L1;
+	else
+		label = &&L2;
+	goto *label;
+L1:	return 0;
+L2:	abort();
+}
+
+/*
+ * check-name: cgoto01
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: set\\.
+ * check-output-excludes: jmp
+ * check-output-excludes: call
+ */
diff --git a/validation/optim/cgoto02.c b/validation/optim/cgoto02.c
new file mode 100644
index 000000000000..5869d5b4a24d
--- /dev/null
+++ b/validation/optim/cgoto02.c
@@ -0,0 +1,18 @@
+int foo(int a)
+{
+	void *label = a ? &&l1 : &&l2;
+	goto *label;
+l1:
+	return a;
+l2:
+	return 0;
+}
+
+/*
+ * check-name: cgoto02
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: %arg1
+ */
diff --git a/validation/optim/cse-label.c b/validation/optim/cse-label.c
new file mode 100644
index 000000000000..e42968204615
--- /dev/null
+++ b/validation/optim/cse-label.c
@@ -0,0 +1,14 @@
+int foo(void)
+{
+label:
+	return &&label == &&label;
+}
+
+/*
+ * check-name: cse-label
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.29.2

