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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F84C433E6
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB8964F2D
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhBYXj6 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 25 Feb 2021 18:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhBYXjz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 25 Feb 2021 18:39:55 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D60EC06174A
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:14 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a22so11728430ejv.9
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvGgaKQqNrs9hJBiKofBIDXJNgwVq583kxTESq+8cgU=;
        b=RApM9hYbIgR6/KYudyl/K2t1Sg7vzuvc6HSCRHsUlsSepZj69qjcKG3NCAIivci/Dt
         arQADery4bEPDRMulRABuqhkwvP+Oi02Y+9ihpaSmCWgIQxDRN1fFHLwvA7D42uxU+2L
         PRYxpv/f6op+UBSDQlBHM04kRUpyNOrYCzIi3+HPgqD1BmBvCWr7ElCZp+Z0F9MWY0ty
         lZmw8ZDjujNlF1g//OwIPMzHWPTGMWtjJBOUiYHkjSAqtZ4hk1+QUD1Bp2S/eUnLpS3d
         1zEAO7htKvTjDggFGRC699uwK2v4/UXQempBXvhqW4tp/sHrar/zxvpY4sQrDLMEyhaf
         qsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvGgaKQqNrs9hJBiKofBIDXJNgwVq583kxTESq+8cgU=;
        b=stQK8Dd2BSwTany78GT6ALL3tYljAvl7711sZEm75CseswmL4ZEVxBGu87XuGK9Jtz
         czkihjBF/XON132hBVifjCm096oRvP+Al2z8f7XjBxNz2wbpDPI3yTMBjMtDKyVHbdns
         mJq0H1GtKOZJ8wwahPJ9DGICdUBI/4svldamrA4N+HLMiz+N4axRoBn7V+v/KixTHYa2
         0Mb6kFU30RdnNCCTyYWCDJdqKIjtC0gGmxYuI82NG8DXg0VIhe81N8/gY+gDwLvOsVzc
         UFkmTPdhDAgdfaE0RP7M91oadvvd9Gp7z5vr125G1uJRX316sgL5e1KPjEPwWSD1xr/l
         T15Q==
X-Gm-Message-State: AOAM531Ux8WvKoJSV/3ZI6xnfmmKltOHOdBXwoaM2AYECwTWIPQJImGB
        pEIp3ETuux25Npl0NL/LiuGdHIcdvKI=
X-Google-Smtp-Source: ABdhPJx+OeVxQPstGg1MLmuFRNffmNn1RvZbjMahjDX7ZNFGt4C9ma49XhtqrxBkUlbBjX/wihyHKw==
X-Received: by 2002:a17:907:9619:: with SMTP id gb25mr132919ejc.64.1614296353099;
        Thu, 25 Feb 2021 15:39:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:2cfa:d768:30f4:f221])
        by smtp.gmail.com with ESMTPSA id q27sm3906167ejc.74.2021.02.25.15.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 15:39:12 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] slice: remove unneeded len from OP_SLICE
Date:   Fri, 26 Feb 2021 00:39:05 +0100
Message-Id: <20210225233908.97275-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
References: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

OP_SLICE::len is necessarily equal to the result size.
So remove this redundancy.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.rst | 2 +-
 linearize.c          | 3 +--
 linearize.h          | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/IR.rst b/Documentation/IR.rst
index 38df84ff3954..c7db32073361 100644
--- a/Documentation/IR.rst
+++ b/Documentation/IR.rst
@@ -408,7 +408,7 @@ Others
 	Extract a "slice" from an aggregate.
 
 	* .base: (pseudo_t) aggregate (alias .src)
-	* .from, .len: offet & size of the "slice" within the aggregate
+	* .from: offet of the "slice" within the aggregate
 	* .target: result
 	* .type: type of .target
 
diff --git a/linearize.c b/linearize.c
index 0c9b0e59cc4b..96a717bc2909 100644
--- a/linearize.c
+++ b/linearize.c
@@ -470,7 +470,7 @@ const char *show_instruction(struct instruction *insn)
 		break;
 
 	case OP_SLICE:
-		buf += sprintf(buf, "%s <- %s, %d, %d", show_pseudo(insn->target), show_pseudo(insn->base), insn->from, insn->len);
+		buf += sprintf(buf, "%s <- %s, %d", show_pseudo(insn->target), show_pseudo(insn->base), insn->from);
 		break;
 
 	case OP_NOT: case OP_NEG:
@@ -1239,7 +1239,6 @@ static pseudo_t linearize_slice(struct entrypoint *ep, struct expression *expr)
 
 	insn->target = new;
 	insn->from = expr->r_bitpos;
-	insn->len = expr->r_nrbits;
 	use_pseudo(insn, pre, &insn->base);
 	add_one_insn(ep, insn);
 	return new;
diff --git a/linearize.h b/linearize.h
index cf0cf066a8e5..4d83675caaf1 100644
--- a/linearize.h
+++ b/linearize.h
@@ -129,7 +129,7 @@ struct instruction {
 		};
 		struct /* slice */ {
 			pseudo_t base;
-			unsigned from, len;
+			unsigned from;
 		};
 		struct /* setval */ {
 			struct expression *val;
-- 
2.30.0

