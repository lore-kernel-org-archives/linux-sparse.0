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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF36C433E6
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65B865100
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhCIXmq (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 9 Mar 2021 18:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhCIXmk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 Mar 2021 18:42:40 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DE8C06174A
        for <linux-sparse@vger.kernel.org>; Tue,  9 Mar 2021 15:42:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x9so24036141edd.0
        for <linux-sparse@vger.kernel.org>; Tue, 09 Mar 2021 15:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=es/SK1q1KGUvCOyVSta1FFBoZxR4tOMghpelImSO+4w=;
        b=q8kGLveFFtyEO+eUI6iws6MF/9SzMyngXxRiFBn48ZWatNGtlkUsh52hBVGWGcEPzU
         xeA5cYcvKFHOJoLL2Unp+2UKwChIQwjV5bgVeeANkkPgq2XJ9xNpft0IahXgr1mPzFXI
         qi3DputOGWHPgAHXQb6u7ILENedGXLmbz/8EQtlJWwFAmXt6FKuxyYahtIV8A8hS8/qA
         0lIm043Ob2/rmkvEVPMuPvdsU2pUDagPjaY+Mfdod8IQT2ufpfLY+PZ+h2XXmReX2x4g
         8hk9cirVhA3VYCnpRDIFoSMwrlTu44AnxVNAFC3F8RFfe/O5c3yXGjh4TdrqIdHuqW6g
         cTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=es/SK1q1KGUvCOyVSta1FFBoZxR4tOMghpelImSO+4w=;
        b=FytZv6tc+kZre83U9DHpqDzu59khGoQKSRcfTsMk+R0CayUXWH1jqAHHxsmu/5ID+t
         NdQsHHvOmP2pW//tZbXbpsDvYgN5ong9qEZPkqSjjCBG1k5oMhPdtN0WSoXWKoGOnxOx
         pU0w2Ihs++yLY0wXafabHTbRrfmLc56BQl3nqAQm/mEfR69AS3h8yTben2uV6pAEJycC
         uPyVm/VTAzeb+UNDT+JY7tMaKwRubZ8mKHmPuFkEnY/huG6X+LD48Yts05aBlpkbBIeP
         EpIefV9yK4pKsPRG0au911vDyEzMC9ynbxti12K3gPREE3Rsmm7CCO4AVLymf/zkUdu+
         uiRA==
X-Gm-Message-State: AOAM5317mRzGyvO0Tq99pHw1HsVYW2w/nm4jVpHUXL0n89ZQBCPUETeY
        EWmAC8nulvWUh57odDRqyIRPQGQBTew=
X-Google-Smtp-Source: ABdhPJwwEiNoA31sW+mm2AKKM3jROM6ZMjnfEw8A3f1wNhX5ngQFCUGeTQxvWzW9LJVFH0D/7xzzMg==
X-Received: by 2002:a50:ed83:: with SMTP id h3mr178239edr.140.1615333359066;
        Tue, 09 Mar 2021 15:42:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:1dad:50b9:7959:c788])
        by smtp.gmail.com with ESMTPSA id cw14sm10147984edb.8.2021.03.09.15.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 15:42:38 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] ssa: the sparse set is not needed
Date:   Wed, 10 Mar 2021 00:42:30 +0100
Message-Id: <20210309234232.50889-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210309234232.50889-1-luc.vanoostenryck@gmail.com>
References: <20210309234232.50889-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The implementation of a 'sparse set without initialization' was
somehow needed during the initial design but it's not needed anymore.

So, remove the implementation and replace its use by the usual
bb->generation mechanism.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile |  1 -
 ssa.c    | 11 ++++-------
 sset.c   | 28 ----------------------------
 sset.h   | 56 --------------------------------------------------------
 4 files changed, 4 insertions(+), 92 deletions(-)
 delete mode 100644 sset.c
 delete mode 100644 sset.h

diff --git a/Makefile b/Makefile
index f9883da101c7..6ad14375b3cd 100644
--- a/Makefile
+++ b/Makefile
@@ -63,7 +63,6 @@ LIB_OBJS += show-parse.o
 LIB_OBJS += simplify.o
 LIB_OBJS += sort.o
 LIB_OBJS += ssa.o
-LIB_OBJS += sset.o
 LIB_OBJS += stats.o
 LIB_OBJS += storage.o
 LIB_OBJS += symbol.o
diff --git a/ssa.c b/ssa.c
index b9044207db16..3f4fa1a831df 100644
--- a/ssa.c
+++ b/ssa.c
@@ -7,7 +7,6 @@
 #include <assert.h>
 #include "ssa.h"
 #include "lib.h"
-#include "sset.h"
 #include "dominate.h"
 #include "flowgraph.h"
 #include "linearize.h"
@@ -162,13 +161,12 @@ static bool rewrite_single_store(struct instruction *store)
 	return true;
 }
 
-static struct sset *processed;
-
 // we would like to know:
 // is there one or more stores?
 // are all loads & stores local/done in a single block?
 static void ssa_convert_one_var(struct entrypoint *ep, struct symbol *var)
 {
+	unsigned long generation = ++bb_generation;
 	struct basic_block_list *alpha = NULL;
 	struct basic_block_list *idf = NULL;
 	struct basic_block *samebb = NULL;
@@ -199,7 +197,6 @@ static void ssa_convert_one_var(struct entrypoint *ep, struct symbol *var)
 		return;
 
 	// 1) insert in the worklist all BBs that may modify var
-	sset_reset(processed);
 	FOR_EACH_PTR(addr->users, pu) {
 		struct instruction *insn = pu->insn;
 		struct basic_block *bb = insn->bb;
@@ -208,8 +205,10 @@ static void ssa_convert_one_var(struct entrypoint *ep, struct symbol *var)
 		case OP_STORE:
 			nbr_stores++;
 			store = insn;
-			if (!sset_testset(processed, bb->nr))
+			if (bb->generation != generation) {
+				bb->generation = generation;
 				add_bb(&alpha, bb);
+			}
 			/* fall through */
 		case OP_LOAD:
 			if (local) {
@@ -390,8 +389,6 @@ void ssa_convert(struct entrypoint *ep)
 		bb->phi_map = NULL;
 	} END_FOR_EACH_PTR(bb);
 
-	processed = sset_init(first, last);
-
 	// try to promote memory accesses to pseudos
 	FOR_EACH_PTR(ep->accesses, pseudo) {
 		ssa_convert_one_var(ep, pseudo->sym);
diff --git a/sset.c b/sset.c
deleted file mode 100644
index e9681e00ddd4..000000000000
--- a/sset.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// sset.c - an all O(1) implementation of sparse sets as presented in:
-//	"An Efficient Representation for Sparse Sets"
-//	by Preston Briggs and Linda Torczon
-//
-// Copyright (C) 2017 - Luc Van Oostenryck
-
-#include "sset.h"
-#include "lib.h"
-#include <stdlib.h>
-
-
-struct sset *sset_init(unsigned int first, unsigned int last)
-{
-	unsigned int size = last - first + 1;
-	struct sset *s = malloc(sizeof(*s) + size * 2 * sizeof(s->sets[0]));
-
-	s->size = size;
-	s->off = first;
-	s->nbr = 0;
-	return s;
-}
-
-void sset_free(struct sset *s)
-{
-	free(s);
-}
diff --git a/sset.h b/sset.h
deleted file mode 100644
index 69cee18a2768..000000000000
--- a/sset.h
+++ /dev/null
@@ -1,56 +0,0 @@
-// SPDX-License-Identifier: MIT
-
-#ifndef SSET_H
-#define SSET_H
-
-/*
- * sset.h - an all O(1) implementation of sparse sets as presented in:
- *	"An Efficient Representation for Sparse Sets"
- *	by Preston Briggs and Linda Torczon
- *
- * Copyright (C) 2017 - Luc Van Oostenryck
- */
-
-#include <stdbool.h>
-
-struct sset {
-	unsigned int nbr;
-	unsigned int off;
-	unsigned int size;
-	unsigned int sets[0];
-};
-
-extern struct sset *sset_init(unsigned int size, unsigned int off);
-extern void sset_free(struct sset *s);
-
-
-static inline void sset_reset(struct sset *s)
-{
-	s->nbr = 0;
-}
-
-static inline void sset_add(struct sset *s, unsigned int idx)
-{
-	unsigned int __idx = idx - s->off;
-	unsigned int n = s->nbr++;
-	s->sets[__idx] = n;
-	s->sets[s->size + n] = __idx;
-}
-
-static inline bool sset_test(struct sset *s, unsigned int idx)
-{
-	unsigned int __idx = idx - s->off;
-	unsigned int n = s->sets[__idx];
-
-	return (n < s->nbr) && (s->sets[s->size + n] == __idx);
-}
-
-static inline bool sset_testset(struct sset *s, unsigned int idx)
-{
-	if (sset_test(s, idx))
-		return true;
-	sset_add(s, idx);
-	return false;
-}
-
-#endif
-- 
2.30.0

