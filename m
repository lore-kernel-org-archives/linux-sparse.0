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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE5FC64E7C
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639EE20825
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT8SEZIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgK2OuM (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 29 Nov 2020 09:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2OuL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Nov 2020 09:50:11 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2BC0613D3
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:30 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jx16so15097169ejb.10
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCiIEs6nNh78aSN1WYa7at1l/GNGiQmarIXqJd9KdtI=;
        b=dT8SEZILjs71ogpoS3oosfO4obfRtcYreR+anhAPaEv0zQUNLHOtoq7K9Sml01VYC7
         4uQ/agekFputh7OYcFoigLhLzvvD31y7P1ioxCElg50BctQHuJz4wtWLQJhMK+qNzkZa
         A/ri+JjGfLunfbzhPe//xu6y4/cYf5xDL7f+5MMcnw9bTNh/7mZpjUk1yy2wNR/BIOg1
         v0IGzQTOvdesIrEyXHnfh7/O129QDfctXJ0E/aiAGuu8/Fn+5ZBrhPHYkqPFpiiqcecM
         wdeAEIx/4ZeVWRu6bXCJhwn0vVbBYzHiXd8pHqJyWBdiOKrerdqrLf+DRyckTS+Rvd7Y
         5rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCiIEs6nNh78aSN1WYa7at1l/GNGiQmarIXqJd9KdtI=;
        b=fSPntPQ3tmOuBfev9Dt2oaGZwJSowxte54YTx4+8qfKppQe1889xepGfK5gzZn3BNJ
         c3X877ZPilARm/1Car86fxQ3JyyWOuLc3+Q0I2/vIUTcjWzypiaCXDAiptkyJCCOlYXp
         5ju69G/nrBpkzxcl6cvapw66AoIx9gj2QHAAjCI1374VYK0R9zR2ZLI9E4WIEBkIqVJC
         QmWc/XbJDINV4Va6EY1YG1oTj2BiYMkXXT3B5eKDLIBxXhUtna2qRB4uCbXZysTPOgjZ
         3yHSjC6s7qME1AAiQcmtt/cqO29TsFPHuh6tXpWQ8arhLjYsKql85GPDnKokfaE8LAYt
         sWUw==
X-Gm-Message-State: AOAM533l/TF/sYCD3iIHYQYWX5gxapp3+6nzl2h0mXTuwie9r6a1Y6tP
        bHuCWWHWM3BqE5TX6sxYzWo07bFfg1o=
X-Google-Smtp-Source: ABdhPJz2XU+kSvpG7drJ6FwnPqViXgA3E0JvvKb953O7JyFu85CRO9qd7wpPw4tjkvX5c9k2xxRzpA==
X-Received: by 2002:a17:906:d1c3:: with SMTP id bs3mr16169153ejb.306.1606661369439;
        Sun, 29 Nov 2020 06:49:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:149a:de72:e1c0:dd0f])
        by smtp.gmail.com with ESMTPSA id p25sm7435649eju.63.2020.11.29.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 06:49:28 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] make a header for simplification
Date:   Sun, 29 Nov 2020 15:49:19 +0100
Message-Id: <20201129144922.56209-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129144922.56209-1-luc.vanoostenryck@gmail.com>
References: <20201129144922.56209-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The few external functions defined in simplify.h are declared
in flow.h (for historical reasons).

In preparation for some changes, create a specific headers for these.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.h     | 1 -
 optimize.c | 1 +
 simplify.c | 1 +
 simplify.h | 8 ++++++++
 4 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 simplify.h

diff --git a/flow.h b/flow.h
index c3461c8c33bd..7cdc7c2a496b 100644
--- a/flow.h
+++ b/flow.h
@@ -21,7 +21,6 @@ extern int simplify_cfg_early(struct entrypoint *ep);
 
 extern void convert_instruction_target(struct instruction *insn, pseudo_t src);
 extern void remove_dead_insns(struct entrypoint *);
-extern int simplify_instruction(struct instruction *);
 
 extern void kill_bb(struct basic_block *);
 extern void kill_use(pseudo_t *);
diff --git a/optimize.c b/optimize.c
index 9b754831f8b0..3351e67b9d5e 100644
--- a/optimize.c
+++ b/optimize.c
@@ -12,6 +12,7 @@
 #include "flowgraph.h"
 #include "linearize.h"
 #include "liveness.h"
+#include "simplify.h"
 #include "flow.h"
 #include "cse.h"
 #include "ir.h"
diff --git a/simplify.c b/simplify.c
index 29b368e94ff4..69eae4f8a5a1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -44,6 +44,7 @@
 #include "parse.h"
 #include "expression.h"
 #include "linearize.h"
+#include "simplify.h"
 #include "flow.h"
 #include "symbol.h"
 
diff --git a/simplify.h b/simplify.h
new file mode 100644
index 000000000000..200d79c00a83
--- /dev/null
+++ b/simplify.h
@@ -0,0 +1,8 @@
+#ifndef SIMPLIFY_H
+#define SIMPLIFY_H
+
+#include "linearize.h"
+
+int simplify_instruction(struct instruction *insn);
+
+#endif
-- 
2.29.2

