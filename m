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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE8C63798
	for <linux-sparse@archiver.kernel.org>; Thu, 26 Nov 2020 20:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BDB21D7F
	for <linux-sparse@archiver.kernel.org>; Thu, 26 Nov 2020 20:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkY7X5ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgKZUfm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 26 Nov 2020 15:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbgKZUfm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 26 Nov 2020 15:35:42 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB647C0613D4
        for <linux-sparse@vger.kernel.org>; Thu, 26 Nov 2020 12:35:41 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id mc24so4611258ejb.6
        for <linux-sparse@vger.kernel.org>; Thu, 26 Nov 2020 12:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOiED7j9JXNnSraLFN9HUWF/4g+uIHunnaxVHGFa8so=;
        b=mkY7X5ixJ0qXUel1AnRDKZeeuKBzaA0Z1n75BYFaET2fg1wfCowLSgGPO9eNnhP0J4
         maykHMindoFgFgpO00ebj0MLsEj+gb2Th9Yqzm9hMHy+uW8G2QEsbAAO/jzKePmtvy6g
         wMRDkpNlFRHGcyqLfSSnOgHoqccsCs5rGH7BH4hy+OhHJIMIkoa3jTrNu43kNYwZDYWX
         g6lhWe/VjWS97aqyPWGe+YqNh9Guk+YGxO5n2HAQ+DMRFLYV7ndGau4hqnMZb4DPyOkr
         qbQdpC45e/1yRM2IkIjmTtMJP1Uh09PE3S3LXIko/PWhWmbA75Vi6BVL1Tpd1++eCeBy
         eyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOiED7j9JXNnSraLFN9HUWF/4g+uIHunnaxVHGFa8so=;
        b=X8R0BooIK73hvCeBUEwKcbzHWwj05lwnGchJZyhi4TK+mO1tLVE9BZ92NnjYxzc2a6
         smMWoaFt4Tu1FB/TThiy76q5EuqsLCNxEwzL0/R3ZBiI/V8+s/1/pXB7wYbJ6oxjxmS1
         O9TMcObo1a/8OFpPBwtJsaxMpqgg/Y/zUznoMo4n6XobxOhsGlhS3jQBlKoQ0UbtpqNi
         z1wSswGff40VEkGRL4fJTNEmrnBu+rO0rMCIJyIqbkXsfPl7RoT0EQP73Im2wjrDICX4
         DGCCMtJTyEYshucGylPMhAwDvszMOn600S0y179fM0NgI+wA0e/yt+8waoh1Rjs90TC6
         5/vA==
X-Gm-Message-State: AOAM531kAsLoZ3fK6hABDAC4LBbnODqClBUyiGXgFReVNvRWLG4PgIFj
        MRJxwHDrvbtbkPQ50IbdxNdrV5gkMBM=
X-Google-Smtp-Source: ABdhPJxVyCBkVGZZbPhU2igprtClMRQNkZ1VEzF5cxfyoEfZrD+72LGWsIKLc5MX9xoUmeHhGR/LlA==
X-Received: by 2002:a17:906:b255:: with SMTP id ce21mr4189834ejb.137.1606422940367;
        Thu, 26 Nov 2020 12:35:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:909a:c722:ec47:1c96])
        by smtp.gmail.com with ESMTPSA id q19sm3715517ejz.90.2020.11.26.12.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 12:35:39 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix trivial_phi()
Date:   Thu, 26 Nov 2020 21:35:35 +0100
Message-Id: <20201126203535.15353-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A phi-node is called 'trivial' if it only reference itself and a
single other value. In this case the only possible value for the
phi-node is this single other value which can thus replace the
phi-node.

However, the current code get this slightly wrong when the first
referenced value is itself and not the other value.

Fix this by moving up the test checking if it references itself.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       |  4 ++--
 validation/optim/trivial-phi01.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 validation/optim/trivial-phi01.c

diff --git a/simplify.c b/simplify.c
index de03d315ec33..5238d33f0040 100644
--- a/simplify.c
+++ b/simplify.c
@@ -204,14 +204,14 @@ static pseudo_t trivial_phi(pseudo_t pseudo, struct instruction *insn, struct ps
 		src = def->phi_src; // bypass OP_PHISRC & get the real source
 		if (src == VOID)
 			continue;
+		if (src == target)
+			continue;
 		if (!pseudo) {
 			pseudo = src;
 			continue;
 		}
 		if (src == pseudo)
 			continue;
-		if (src == target)
-			continue;
 		if (DEF_OPCODE(def, src) == OP_PHI) {
 			if (pseudo_in_list(*list, src))
 				continue;
diff --git a/validation/optim/trivial-phi01.c b/validation/optim/trivial-phi01.c
new file mode 100644
index 000000000000..a22732e45d33
--- /dev/null
+++ b/validation/optim/trivial-phi01.c
@@ -0,0 +1,21 @@
+void foo(int a)
+{
+	if (a) {
+		while (a) {
+			switch (0) {
+			default:
+				a = 0;
+			case 0:;
+			}
+		}
+	}
+}
+
+/*
+ * check-name: trivial-phi01
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: phi\\.
+ */
-- 
2.29.2

