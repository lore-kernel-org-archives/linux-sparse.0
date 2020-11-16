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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D10C5519F
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA220E65
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJO35v+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgKPW3k (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbgKPW3k (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 17:29:40 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B061EC0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:39 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id za3so26684591ejb.5
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FA/hKoCDw1kyjHdjmVPcqeKfj2V8+QrYL9SmRN29fiY=;
        b=hJO35v+pxLLZom9fia+IV3KEy1vCrkX5/zBA9mXspBmdBi1IsSwlueN74ITMFZ+Rg/
         QEFWVVyhPoEh5MiCw/VdezU3EuPKodhZyKTu/wtUZJXjDUzJuwCMuu9xopz0BmpKvTxp
         133YUL+OWwluuLGjfvPvxdzIVWpMuR7/kyXyappyfOo9n+YHd1FS1LrDlXJKxUcxUHmL
         9H7vzZBCu9uUqFVNeuldRAohiskA+wB9UvSn2wdl0WtYPsHdEgoHhPbN6aUlmWT4bhol
         nd4MlsTf4gtOYVkCD9zNwYgZxT0BwV4FUfh0ZPqyTxgYGsA4BYIvUj1zrdHIMEprKVeT
         9r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FA/hKoCDw1kyjHdjmVPcqeKfj2V8+QrYL9SmRN29fiY=;
        b=SzVoqGJ1DuBfZIQsDbzjrUkOSXtJi1Rsq52GNDj3awpgKJExo1EZQNcMVYyLpZHaRg
         HIGugJL8zh8poh6M0zNq3uaUmplGySaPvs3N449Ak/mM+cn7lGNcLgkeot3t09QPjSUF
         FrafMJDrhxs6Soa5IKQnkY1/Tyfpxdo/M1H9RN2XIdw/iakVobde7AKWw1CQXPXd8soY
         TiWqozJg3prLpwmoKyTLPasM0aaCy9bMV7Dio7SMpI78QF4w2fublXqd58cz1MIFHICv
         SQXYj0vCg0xwYofa1RN3SzfxHn4mcaP8NJ30N9KGCVjQM0746/RVrj/gwa9vKpbHxPZC
         SrAg==
X-Gm-Message-State: AOAM530iEIc87xg8buKN8yXb3s096pZXxbUBMpANwvO9T0K2H4+jQca4
        M1vnYINjqqJBjyrnfAnh3a6vzWRFiK0=
X-Google-Smtp-Source: ABdhPJzHRY9mwnmtNZo/XefRaWhqctBuLz5fvM8xcIzpDFjK0XR0jUeUfXHsdF+npBVSpeNJiovP4w==
X-Received: by 2002:a17:906:6b86:: with SMTP id l6mr16685634ejr.524.1605565778229;
        Mon, 16 Nov 2020 14:29:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id bn25sm10805446ejb.76.2020.11.16.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:29:37 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/8] cfg: add missing REPEAT_CFG_CLEANUP
Date:   Mon, 16 Nov 2020 23:29:25 +0100
Message-Id: <20201116222927.51939-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

simplify_branch() & insert_branch() convert a conditional branch
into an unconditional one, removing a child which may then
become unreachable.

However, these function doesn't set REPEAT_CFG_CLEANUP and the
unreachable child may not be removed.

Fix this by setting the missing REPEAT_CFG_CLEANUP in these functions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 1 +
 simplify.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index ab91113d00eb..5d800b7f4006 100644
--- a/linearize.c
+++ b/linearize.c
@@ -726,6 +726,7 @@ void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic
 		remove_parent(child, bb);
 	} END_FOR_EACH_PTR(child);
 	PACK_PTR_LIST(&bb->children);
+	repeat_phase |= REPEAT_CFG_CLEANUP;
 }
 	
 
diff --git a/simplify.c b/simplify.c
index e58fb6cf3941..a0e23d6de01f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2048,7 +2048,7 @@ static int simplify_branch(struct instruction *insn)
 		kill_use(&insn->cond);
 		insn->cond = NULL;
 		insn->opcode = OP_BR;
-		return REPEAT_CSE;
+		return REPEAT_CSE|REPEAT_CFG_CLEANUP;
 	}
 
 	/* Conditional on a SETNE $0 or SETEQ $0 */
-- 
2.29.2

