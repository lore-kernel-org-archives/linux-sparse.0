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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B8C43381
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A388064F06
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhBYXj7 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 25 Feb 2021 18:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhBYXj4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 25 Feb 2021 18:39:56 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE72C061786
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n20so11742751ejb.5
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dayAgQkgoEWMtY8d4KcJ4zW79UMvO9gP8YBMcQY0lks=;
        b=ekBAEoCQj4pnVWwi6/Y43MkHjoaV0e/g+Xs7QYaQc4lpoiyttTR9HqAggz9e2/68Je
         CZrGFewy3IQTn5vBvfnBGf+ra5lKlZFeJEDvWxebHIgeusExPaplFA31LlIa6cM3V1oq
         Jz3ysMNi1dfMmAXtxbKpBqXUsNRWIxWTSYN5HxuuVl4w3ZHCLBKm/7Ea1b9jbehpb/l+
         CtkGEraFBwgMJvUM6sk3zLJuHzwn894cbJ+6Ie/er6Y4lkTjVRy/LvHXn4HBpERf+6Q3
         SLmbMw+Ds9thzIN+Ytzd20m7ihTNcn5d9sG4DOo+LGFbfwtg4Uk7kr8D5sRPSFwHeY1P
         Z7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dayAgQkgoEWMtY8d4KcJ4zW79UMvO9gP8YBMcQY0lks=;
        b=IrnflMxIzhAE3nxIy59WZCvbpfrWeDfAXKX7Z5K5D0Kbk9aXY3Z2jL98btPw3ZZT05
         Q6Alv8lxHu/ni6T1Dss7K25nDnpw+BF4Q0EkF5BDNLOtByPmjRDjm5gUwE+GMB4aCTlU
         qF9/XLA8E/ZDgpSmRZBB+QjIuvAmgrN08dsb75m8CkrfrQLWfwvGpWXS8j1aqvkvsuLw
         imvVfUDuBXyTrHPrHFughpejCx6RZNLg75hkF6pa+SCPdiq6xpoSrWzURkZ6sFEE0Htx
         u6kUakX7BNv1i8x4gmj8owfOMBITgrrOJkcUoKXdBmkZ19u32GA52ZGz9kzqZX6TIN35
         YmnQ==
X-Gm-Message-State: AOAM532vpE2WchqAM3rsSgtiRG6KyAbAk/T2XalkZEkBfqcFi0GNB4yj
        P0VCukmjBa+9JNy8Ygmdi2bPi9EaESM=
X-Google-Smtp-Source: ABdhPJyIVUineH+6rDFrFm22bBmwXYBTkF8SXa6CONP2hdnQr8B1ZBQsAIsYelUmepsZMDq/4UH5Fg==
X-Received: by 2002:a17:906:f9cc:: with SMTP id lj12mr85998ejb.544.1614296354948;
        Thu, 25 Feb 2021 15:39:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:2cfa:d768:30f4:f221])
        by smtp.gmail.com with ESMTPSA id q27sm3906167ejc.74.2021.02.25.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 15:39:14 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] slice: OP_SLICE needs the source's type: make it a kind of unop
Date:   Fri, 26 Feb 2021 00:39:07 +0100
Message-Id: <20210225233908.97275-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
References: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

OP_SLICE's source's type is needed for some simplifications.
For example, in some cases it can be simplified into OP_TRUNC.

So, merge its representation with the one for unops which also
need the source's type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 5 +++--
 linearize.h | 5 +----
 liveness.c  | 5 +----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/linearize.c b/linearize.c
index 96a717bc2909..7ab69d3ac968 100644
--- a/linearize.c
+++ b/linearize.c
@@ -470,7 +470,7 @@ const char *show_instruction(struct instruction *insn)
 		break;
 
 	case OP_SLICE:
-		buf += sprintf(buf, "%s <- %s, %d", show_pseudo(insn->target), show_pseudo(insn->base), insn->from);
+		buf += sprintf(buf, "%s <- %s, %d", show_pseudo(insn->target), show_pseudo(insn->src), insn->from);
 		break;
 
 	case OP_NOT: case OP_NEG:
@@ -1239,7 +1239,8 @@ static pseudo_t linearize_slice(struct entrypoint *ep, struct expression *expr)
 
 	insn->target = new;
 	insn->from = expr->r_bitpos;
-	use_pseudo(insn, pre, &insn->base);
+	insn->orig_type = expr->base->ctype;
+	use_pseudo(insn, pre, &insn->src);
 	add_one_insn(ep, insn);
 	return new;
 }
diff --git a/linearize.h b/linearize.h
index 4d83675caaf1..429f4797e359 100644
--- a/linearize.h
+++ b/linearize.h
@@ -113,6 +113,7 @@ struct instruction {
 		};
 		struct /* unops */ {
 			pseudo_t src;
+			unsigned from;			/* slice */
 			struct symbol *orig_type;	/* casts */
 		};
 		struct /* memops */ {
@@ -127,10 +128,6 @@ struct instruction {
 			pseudo_t _src1, _src2;		// alias .src[12]
 			struct symbol *itype;		// input operands' type
 		};
-		struct /* slice */ {
-			pseudo_t base;
-			unsigned from;
-		};
 		struct /* setval */ {
 			struct expression *val;
 		};
diff --git a/liveness.c b/liveness.c
index 30a9a5b6b169..755509e59b52 100644
--- a/liveness.c
+++ b/liveness.c
@@ -76,6 +76,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 	/* Uni */
 	case OP_UNOP ... OP_UNOP_END:
 	case OP_SYMADDR:
+	case OP_SLICE:
 		USES(src1); DEFINES(target);
 		break;
 
@@ -121,10 +122,6 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 		} END_FOR_EACH_PTR(pseudo);
 		break;
 
-	case OP_SLICE:
-		USES(base); DEFINES(target);
-		break;
-
 	case OP_ASM:
 		asm_liveness(bb, insn, def, use);
 		break;
-- 
2.30.0

