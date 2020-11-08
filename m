Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B3C55178
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BC820885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjveBPVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgKHBTv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKHBTv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:51 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B8DC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:50 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id s25so7254354ejy.6
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OS4AcG1O4cpQ6/U2QD62EfC5C0OVzJBqlMYt0mJ9kXw=;
        b=LjveBPVsd8+DetQiFinRnIoP5I538ApePApMu+nYOKdglZKAb7SepKvWbVzMips/L1
         WJvnFfgWSU5BWcXU6P39Pm3hfvcpO7InrHRAHLKvOw3nVh8vXSvwuusZ+AOME/jcUt/H
         n//i0nNJBfdQhUUCQyG4jsefwbVzXzCklkkflIfkRqq59GS8L0IH5+DUBc5ueAAZZMbf
         6hyXQE4B7HnzepeE3gov1h//Vp+Oimh5/spYRzKTDJPpZlGCXnOD5P1eadZShmTJoML+
         tSDdBUzhh0xcgbky3l87C//lwyFaPYafpZocf8Uau4iun+2ckZ3NZWTKTFOEk30nBf2k
         BiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OS4AcG1O4cpQ6/U2QD62EfC5C0OVzJBqlMYt0mJ9kXw=;
        b=R92mjlhWWkdLxiPOzhbF7eqa55N0YPFzwW2rnZIs2/0TGJtDCxImkcvD8Jx2nSdJ4P
         0W4o+OxFJSzbeF/sAk8XPKxXNfXuP84TOXOfAIzSQCXJU+l8brMAdY/2n+F9gqBqHL+G
         +yUHpS2+BHPamPxsfpPYgoX+XhQRz2RLomN449sauJbWpChO2q7t/eSqsgL77ru7r/6T
         eLthDzGfEIe6PRde3VM4yS5LvL/W3f9K/L4pkqM/O+Yv5QhIQQXBNIanHlKIZAj+G/uw
         44sxRiSdPMtHGRYWliRb19uSoUahQLS3kU8sqLCNTs/JCu3EmBI80UZSN8GlXu3IhJDY
         xtJQ==
X-Gm-Message-State: AOAM532gisNc7tgksKvjad2vgGnvZZYpiR1ZqDjKPBO+uTWXYgFYgyVQ
        dA4kccfS6NWv8I8pMwAcYx9T8kGLNrw=
X-Google-Smtp-Source: ABdhPJyMGKVwt3mJEOprkjXTk29xMo8632FLTNcMuBI2aVdJf/gX5Fz8J7pDMBMcCuYMdZ7Mk+DP6g==
X-Received: by 2002:a17:906:aecd:: with SMTP id me13mr909435ejb.433.1604798389381;
        Sat, 07 Nov 2020 17:19:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:48 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/16] cmp: canonicalize unsigned (x {<,>=} C) --> (x {<=,>} C-1)
Date:   Sun,  8 Nov 2020 02:19:36 +0100
Message-Id: <20201108011939.94252-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

An unsigned comparison like (x < 3) is equivalent to (x <= 2).
Canonicalize '<' & '>=' to '<=' & '>', such that the smallest
constant is used.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                        | 8 +++++++-
 validation/optim/canonical-cmpu.c | 1 -
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index 59e6d1eee291..b8dfbad1f077 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1081,18 +1081,24 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 
 static int simplify_compare_constant(struct instruction *insn, long long value)
 {
+	int changed = 0;
+
 	switch (insn->opcode) {
 	case OP_SET_B:
 		if (!value)			// (x < 0) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
 		if (value == 1)			// (x < 1) --> (x == 0)
 			return replace_binop_value(insn, OP_SET_EQ, 0);
+		else				// (x < y) --> (x <= (y-1))
+			changed |= replace_binop_value(insn, OP_SET_BE, value - 1);
 		break;
 	case OP_SET_AE:
 		if (!value)			// (x >= 0) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
 		if (value == 1)			// (x >= 1) --> (x != 0)
 			return replace_binop_value(insn, OP_SET_NE, 0);
+		else				// (x >= y) --> (x > (y-1)
+			changed |= replace_binop_value(insn, OP_SET_A, value - 1);
 		break;
 	case OP_SET_BE:
 		if (!value)			// (x <= 0) --> (x == 0)
@@ -1103,7 +1109,7 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_opcode(insn, OP_SET_NE);
 		break;
 	}
-	return 0;
+	return changed;
 }
 
 static int simplify_constant_mask(struct instruction *insn, unsigned long long mask)
diff --git a/validation/optim/canonical-cmpu.c b/validation/optim/canonical-cmpu.c
index 482408aa90c1..29bbd0a8690a 100644
--- a/validation/optim/canonical-cmpu.c
+++ b/validation/optim/canonical-cmpu.c
@@ -9,7 +9,6 @@ int cmp_geu(unsigned int x) { return (x >= 256) == (x >  255); }
 /*
  * check-name: canonical-cmpu
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

