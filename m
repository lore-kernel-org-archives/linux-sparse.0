Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A5C63777
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAFA20E65
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPSQCjiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgKPW3l (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbgKPW3l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 17:29:41 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E5EC0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:40 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o9so26690758ejg.1
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgWpMH1SC564URbBb9Lr8nEHsRZl17Lt/DPmAksvKU0=;
        b=jPSQCjiFJ8oXpIFFCo5jbLlOAJ3zRu3xWnR5NNT2vQ5DswMs0/+62Bov7l3XhFbxvF
         gcPTZECfL++zjRLxBrt8f+0WP7id7dDvQSLezKa8dJ8vhBr4gLu72eF3uLtAlk4K5P8e
         b4gkFO2AYvx4Jjxo1PCt34tbA9Yd1/PES3JOXQKFHBG9Jw7TujyzCX6pEsQW27DYjfCw
         5m4C4cJMDS4lFAe/FwYE3v3HZH/PA/O07p2a5SMj6veYcQvVtKP+ZfEnzeu3CaaZmuH/
         w2xGx/PceBW4Kug8eCO/6k19z9t279khF8UvnIeN+mkGWnvEjARA/B59SaagOFv8Q+Et
         WJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PgWpMH1SC564URbBb9Lr8nEHsRZl17Lt/DPmAksvKU0=;
        b=a/ZCSGk6eKj7XFsO1BJkqcOjWjcmxU7hweofBdKtJZ+0RlZi0vY45nLq+uZGTSqyyJ
         Y6Om6p/fcG6BcCTHhxyND0jXFB2IPUnXWjcMxiEjw+RgbliprsYdxic7sToKxT6u2eXn
         coqrEe/5jnHeAdW6fMFc2nWfzKPgBFKHxyMUereldwjkEB5HWq74LQKCOXnd5z5tFWFy
         DGBSH2LmYefgzL6pARUdLiBNmh9jOeKDVHDJ2t7usa0BmLwsr36F+igO2kL4QkPwDABa
         bpd0Uh5LEC6Z1xAQoqI+cfIUWKW7LimXiIcpml0DPzFMScnREgIWE11G8BBTw2vn4AcK
         EyEw==
X-Gm-Message-State: AOAM5322fERYXr2OQ3fmivjYvllNABRMu/hNaqvGcLLPjbfgY+RxOJYj
        pekBKRU6ckWw3Jhm5ZLI9mDTRrQO4nI=
X-Google-Smtp-Source: ABdhPJyesGr7+rpo57pCZGcQQlSeXXcT03Qkx60hWkk0xZy91IOuqFz6OPS4OAQc3WaxlTvFowq8UQ==
X-Received: by 2002:a17:906:3813:: with SMTP id v19mr16976905ejc.462.1605565779420;
        Mon, 16 Nov 2020 14:29:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id bn25sm10805446ejb.76.2020.11.16.14.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:29:38 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/8] cfg: call simplify_memops() unconditionally.
Date:   Mon, 16 Nov 2020 23:29:26 +0100
Message-Id: <20201116222927.51939-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, in the main optimization loop, simplify_memops()
is only called if REPEAT_SYMBOL_CLEANUP have been set. This
has (at least) two problems:
1) simplify_memops() may itself create other 'symbol cleanup'
   opportunities. That's fine and when it happens REPEAT_SYMBOL_CLEANUP
   is correctly set but this is directly lost because repeat_phase
   is cleared just after. So, loads and stores are not always
   optimized away as they should.
2) Loads & stores are not always done directly on symbols, in
   fact, it often happens that they are done on some PSEUDO_REG.
   Here too, loads and stores are not always optimized away as
   they should.

So, call simplify_memops() unconditionally.

Note: this have only very small effects on the tests' running time:
	  before		after		  after too
	  real	 4m18.001s	real   4m18.655s  real	 4m19.4
	  user	71m32.911s	user  72m02.701s  user	72m06.6
	  sys	29m06.523s	sys   29m01.721s  sys	29m06.8
      which is under the noise I usually have.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c                           |  2 ++
 optimize.c                         |  4 +---
 validation/optim/memops-missed01.c | 23 +++++++++++++++++++++++
 validation/optim/memops-missed02.c | 14 ++++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)
 create mode 100644 validation/optim/memops-missed01.c
 create mode 100644 validation/optim/memops-missed02.c

diff --git a/memops.c b/memops.c
index f071e556da8a..badcdbbb9378 100644
--- a/memops.c
+++ b/memops.c
@@ -146,10 +146,12 @@ static void simplify_loads(struct basic_block *bb)
 				}
 				rewrite_load_instruction(insn, dominators);
 			} else {	// cleanup pending phi-sources
+				int repeat = repeat_phase;
 				pseudo_t phi;
 				FOR_EACH_PTR(dominators, phi) {
 					kill_instruction(phi->def);
 				} END_FOR_EACH_PTR(phi);
+				repeat_phase = repeat;
 			}
 		}
 next_load:
diff --git a/optimize.c b/optimize.c
index bfab74c01b62..8ab105bccdce 100644
--- a/optimize.c
+++ b/optimize.c
@@ -84,9 +84,7 @@ repeat:
 				kill_unreachable_bbs(ep);
 
 			cse_eliminate(ep);
-
-			if (repeat_phase & REPEAT_SYMBOL_CLEANUP)
-				simplify_memops(ep);
+			simplify_memops(ep);
 		} while (repeat_phase);
 		pack_basic_blocks(ep);
 		if (repeat_phase & REPEAT_CFG_CLEANUP)
diff --git a/validation/optim/memops-missed01.c b/validation/optim/memops-missed01.c
new file mode 100644
index 000000000000..fc616f1976a1
--- /dev/null
+++ b/validation/optim/memops-missed01.c
@@ -0,0 +1,23 @@
+void bar(int);
+
+void foo(void)
+{
+	char buf[1] = { 42 };
+	const char *p = buf;
+	const char **q = &p;
+	int ch = 0;
+	switch (**q) {
+	case 4:
+		ch = 2;
+	}
+	bar(ch);
+}
+
+/*
+ * check-name: memops-missed01
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: store\\.
+ * check-output-excludes: load\\.
+ */
diff --git a/validation/optim/memops-missed02.c b/validation/optim/memops-missed02.c
new file mode 100644
index 000000000000..6f0286497943
--- /dev/null
+++ b/validation/optim/memops-missed02.c
@@ -0,0 +1,14 @@
+void foo(int a[])
+{
+	int i, val;
+	for (;; i++)
+		val = a[i] ? a[i] : val;
+}
+
+/*
+ * check-name: memops-missed02
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-pattern(1): load\\.
+ */
-- 
2.29.2

