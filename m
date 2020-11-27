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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE48C6379D
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA9E221EB
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8cLEhKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgK0QwC (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732128AbgK0QwC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 11:52:02 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395A0C0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so6214555wrw.10
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ScrtSZlA/2DvlbYC7iS+PdZe8g+yHK5UMOTMv5T7unI=;
        b=f8cLEhKBpOX3vYYy6aJo0v1vBbfPnmoSm9PIjmU9gafpLD/RBmHn0jwrlfzvzV2ADE
         13qha09KvHSAZFpALogmZAuUhDHPLc7idnyuORLB5T56wXUJ93t9wcuiX5+gSnXDi/4l
         A7SVbONUIRU0OCC40nOSwACqz73IbjuxkuG3mWIwxFUinqJp9/RSJgOkfzmOJp0jnfMw
         rOL/JqbEvWGM0d7ySHokx3C3/c7Q5EtW5pAtwEOEAwJJFDuueNGCa3ZHk6/CUuc1NtrY
         PbbX8eSEeD7PAQ0JxY5meLnwOo1xuflRHcTWjh1v7os64obdArbFlkmw/0hwbE2/Mpuo
         HEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ScrtSZlA/2DvlbYC7iS+PdZe8g+yHK5UMOTMv5T7unI=;
        b=nING2ReSaRUfe8CfAdBHjmnjzXlFWcUaOmBXg9p4xJpuuQNiDh+1RoZHkL4M4r+JoG
         1GYhK1yER2/PQy344053Ila+2m6wwcptxqkSF4PJ5YfMEkEEUb34taQWQ67UcQjORWf9
         dbAakyxHK7jAmNmjCvdbgn9M1WQb7WaCk29uA2KwBeCpPkp12BaDOyNZM69lYdrmfZvg
         gLMSGiAgJe9IEIvjpzX5gX2pVJTkNF5OTPtKFdVI2ScsB2RySIvJcvDBARfsYQFHDnSX
         5bIvzPXZ+tznR/CCR4Iw6wFng6KQalCv/Onni0JwDQX225XGvgCwlvkNV2lxF+IqQqKG
         j0ng==
X-Gm-Message-State: AOAM531mtdE1NbFziqBXjQxPD9T0oXQYOHfXWgwHTlZtNQCxP9graFHc
        zMF1mCkDdJ/b58NTX21Y+7Ur9Jk8AGA=
X-Google-Smtp-Source: ABdhPJwxxVfC/nskA3wd1UZvjfkN5gBgxXXmXun1exeGQrBH7AaMzoUQjF35pJW5TLTieOneKLvShw==
X-Received: by 2002:adf:e490:: with SMTP id i16mr11622076wrm.337.1606495920709;
        Fri, 27 Nov 2020 08:52:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e9bd:38ae:745f:40ea])
        by smtp.gmail.com with ESMTPSA id y2sm15895539wrn.31.2020.11.27.08.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:52:00 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/8] reassoc: add helper can_move_to()
Date:   Fri, 27 Nov 2020 17:49:44 +0100
Message-Id: <20201127164950.41517-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
References: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When transforming IR expressions, it may happen that we want to
reuse an instruction and move a pseudo into it but that this pseudo
is only defined later.

Add a small help to check this: can_move_to().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/simplify.c b/simplify.c
index de03d315ec33..d16390caed49 100644
--- a/simplify.c
+++ b/simplify.c
@@ -46,6 +46,7 @@
 #include "linearize.h"
 #include "flow.h"
 #include "symbol.h"
+#include "flowgraph.h"
 
 ///
 // Utilities
@@ -1508,6 +1509,42 @@ static inline int simple_pseudo(pseudo_t pseudo)
 	return pseudo->type == PSEUDO_VAL || pseudo->type == PSEUDO_SYM;
 }
 
+///
+// test if, in the given BB, the ordering of 2 instructions
+static bool insn_before(struct basic_block *bb, struct instruction *x, struct instruction *y)
+{
+	struct instruction *insn;
+
+	FOR_EACH_PTR(bb->insns, insn) {
+		if (insn == x)
+			return true;
+		if (insn == y)
+			return false;
+	} END_FOR_EACH_PTR(insn);
+	return false;
+}
+
+///
+// check if it safe for a pseudo to be used by an instruction
+static inline bool can_move_to(pseudo_t src, struct instruction *dst)
+{
+	struct basic_block *bbs, *bbd;
+	struct instruction *def;
+
+	if (!one_use(dst->target))
+		return false;
+	if (src->type != PSEUDO_REG)
+		return true;
+
+	def = src->def;
+	bbs = def->bb;
+	bbd = dst->bb;
+	if (bbs == bbd)
+		return insn_before(bbs, def, dst);
+	else
+		return domtree_dominates(bbs, bbd);
+}
+
 static int simplify_associative_binop(struct instruction *insn)
 {
 	struct instruction *def;
-- 
2.29.2

