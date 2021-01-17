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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2225C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 17 Jan 2021 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5402251F
	for <linux-sparse@archiver.kernel.org>; Sun, 17 Jan 2021 15:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbhAQPVW (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 17 Jan 2021 10:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbhAQPOo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Jan 2021 10:14:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174F6C061757
        for <linux-sparse@vger.kernel.org>; Sun, 17 Jan 2021 07:14:04 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id by27so14762391edb.10
        for <linux-sparse@vger.kernel.org>; Sun, 17 Jan 2021 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oz5JTpLtXO9RaVXI9WWV6iuwSaJIBZ1mttz6tnmsCAo=;
        b=Y0w8qGFYD8q6Ah2eFQdsRMQUgXFI4A0hrusPLtz1P6bOYg4/2GML4ofyJPnR79N2Nt
         a10eqMdNWCg8K7ME0j84rHka9g74SN6GI/56AtmFWk9u7TSkxLb7IGonuzqKPjQSoAWN
         TRov0f9ixQfKH2Z8uKm9N3zxZ6J/kt6jffDvv/c9+Z5sBxnA1CkrlLG7FeKkkQIoHBwf
         mWJHS2unl87pZCLX7HwsA57RpC80NA8WJJ039fCkRHPLYGeDzAmjJ+qNhhkYUNI9gRTq
         FM+3Hy2WWQnJw+1ZcEzr5YQ6t00Zs0E7TnJ+scONHd/9WzQn02JRhBLbcSJPDumm1drb
         amBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oz5JTpLtXO9RaVXI9WWV6iuwSaJIBZ1mttz6tnmsCAo=;
        b=uHeQkGvniBAdqTGs2UGqdxJQZLRFwMzofiZv6V+uVdH9YkcCv2nYJ0a/1Ui6SQvV4v
         OJhOTjSNIHasZvYYluutriK/r4Ca5o/1zhENBJN1XXkKJ+DD6l7B6C3WR8q9GeW3b3SM
         EtVgn56V+YqERP9FhNVrwCLshLm3HXL4n3YImoMUhrj6YT9UYujxXUXaeL7Z4nih6Z0u
         zdjobzQAh0tyDMbMlByLSk3vWhL4YSqHcevSnoPBcGbthzCJBHT0LsMqlW19zYNJLxPh
         tcaUZZQ6newP6cSUyA6SFZ5V7IEOnV3h6UxC8TVI5f3RhZVeJJ3KZrkFgcJb7U4RcZFH
         r7aw==
X-Gm-Message-State: AOAM5309QYoLgsyWwef3Cz0G9el/WoWpRCK1LNdUkZk24rrwWuSOEMg4
        jGjhfTXnCh3Lo3cf+DYlihqB/Vj3Qyo=
X-Google-Smtp-Source: ABdhPJwezpUELQYlc48IjW5bzhUEK9wsxqMSMgGL+8wv9bMqCbV94JfO1gvj43EPFLBemza++9md+w==
X-Received: by 2002:a05:6402:788:: with SMTP id d8mr8165900edy.277.1610896442845;
        Sun, 17 Jan 2021 07:14:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:148c:eab8:9056:fbe4])
        by smtp.gmail.com with ESMTPSA id x17sm9099181edd.76.2021.01.17.07.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 07:14:02 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix type of canonicalization of sext + unsigned compare
Date:   Sun, 17 Jan 2021 16:13:55 +0100
Message-Id: <20210117151355.30515-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In commit 4a5f616407e2 ("cmp: canonicalize sext(x) cmpu C (with C >= SMAX)"),
the operand is replaced to avoid a sign extension but the corresponding
type was not updated. Fix this now.

Fixes: 4a5f616407e26efb67013f8267adef2d6e093bf1
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/simplify.c b/simplify.c
index b0d2c1b5b7c6..1e7648486c49 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1225,12 +1225,14 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 		switch (insn->opcode) {
 		case OP_SET_BE:
 			if (value >= sign_bit(osize)) {
+				insn->itype = def->orig_type;
 				replace_binop_value(insn, OP_SET_GE, 0);
 				return replace_pseudo(insn, &insn->src1, def->src);
 			}
 			break;
 		case OP_SET_A:
 			if (value >= sign_bit(osize)) {
+				insn->itype = def->orig_type;
 				replace_binop_value(insn, OP_SET_LT, 0);
 				return replace_pseudo(insn, &insn->src1, def->src);
 			}
-- 
2.30.0

