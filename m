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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E32C43333
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5F764FAB
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhCJWLO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhCJWLG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7AC061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:06 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b13so143441edx.1
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRz/c+V0KLbt7rcYnVpHcsX3x3H0fM14HqWzYEQ8oos=;
        b=rkQQfkapgcQ5QTQNYe35hALGVrVB2xHTt6C8ZGzfG0RuJZi9Y26hCb0JkO2wQ01rjT
         aVQ2a5AzLK05ajLz3ka6khGA+yY5uhHrLA+R9wzIrQslvcISmI8cZFzHp50woSiO1PVm
         NCddHr4mD5nWKxHBrJ63o4iz48WGrMLBfG506LnL3hx22Pz5TZABCj77+yBd03/BmNyK
         BFzuc8Xd++ZaGSVlTJMHRrKMdX7wB2GHXtbbWfT+6GrfLxwrJ+wWnLVM0/o2xN52O3x8
         USyS27bM5/FBVsJNW0P5X9ULDeokrx/df+Kv7N441I/gBInSpmTGmZL301UF2+DWuRzZ
         71pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRz/c+V0KLbt7rcYnVpHcsX3x3H0fM14HqWzYEQ8oos=;
        b=hHb2U4cg8TLtBZWhmhNNXUIkUCQWev7UmtCAtncD5arJIuTD0I8yrOjzaLglCHhWZZ
         OfT+sC5NcOtfYZ2MOvT6U8GyiTBgoxc2MmyH13+GFgLwYuG7kDJ3xHUNvnLkKedfIIld
         rGo9Gj2I2GcqZPYuhU6NHZqxGPgK5TiPGlQBSxaxDUlTfaJlLpQls87OBCIiVh5eXMbb
         PBADEF8nrjFkLO7CLSVpCn6glceUIZvbEIClUu6ZpQLjHYAn3z1tvNRoFjmqEbwWoYoN
         tGLjPNUNdezIRRvwSU9JrYTXt5ey3l0Otg4M81LXtb1698kipw25qYSXlCmG5kpYFknm
         byDw==
X-Gm-Message-State: AOAM531G+bLTySh9U3I5Iy6JWJtLmvP12abygDFhP5hZVYwYDoi4km3N
        jj1915dnwXGA36TEPwjNGWTKCJPJ16k=
X-Google-Smtp-Source: ABdhPJyspMtoBDhfy40vij6VvgoZ9NzRvRMeh6O1AE6TOLJTxmDiEu19X2xsEF2OvHWVBTbNuq6WOQ==
X-Received: by 2002:aa7:d987:: with SMTP id u7mr5500081eds.326.1615414265277;
        Wed, 10 Mar 2021 14:11:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:11:04 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/9] simplify (x | M) {==,!=} C
Date:   Wed, 10 Mar 2021 22:49:48 +0100
Message-Id: <20210310214950.84192-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
References: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                  | 15 +++++++++++++++
 validation/optim/cmpe-or0.c |  1 -
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index b46e08c3b79a..865fadfb590e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1311,6 +1311,21 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			break;
 		}
 		break;
+	case OP_OR:
+		if (!constant(def->src2))
+			break;
+		bits = def->src2->value;
+		switch (insn->opcode) {
+		case OP_SET_EQ:
+			if ((value & bits) != bits)
+				return replace_with_value(insn, 0);
+			break;
+		case OP_SET_NE:
+			if ((value & bits) != bits)
+				return replace_with_value(insn, 1);
+			break;
+		}
+		break;
 	case OP_SEXT:				// sext(x) cmp C --> x cmp trunc(C)
 		osize = def->orig_type->bit_size;
 		if (is_signed_constant(value, osize, size)) {
diff --git a/validation/optim/cmpe-or0.c b/validation/optim/cmpe-or0.c
index bef2316120f7..2e89d611117d 100644
--- a/validation/optim/cmpe-or0.c
+++ b/validation/optim/cmpe-or0.c
@@ -4,7 +4,6 @@ int cmp_ne(int a) { return ((a | 1) == 0) + 1; }
 /*
  * check-name: cmpe-or0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

