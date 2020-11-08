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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FF6C388F7
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D409420885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9PbDJ9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgKHBVc (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHBVc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:21:32 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19735C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:21:32 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id i19so7243132ejx.9
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8fNM+9Fl4SDVO1MpW++I3AWFAWGB9v0J0HGJYwUTPuM=;
        b=J9PbDJ9Ge3ZaTRyH2YliKJU/kI6YtEAE6o+xATgIhX9sZQ1VpMQk08FpHRTnTOuyxj
         IgLPn1nrqvAdKrcyM6Jyi4CkemTnDQCZotLHJed47/oG9HmVrjKKqhMbddVaI6CCUwkJ
         WHffdhSUCQubcEkUEdau9yIgr6JxZCvDxcmaU9sdfqkIklmsjd4Phpqo0LJPSNik/1Ny
         K6/Z5F6j+Dvm+nvYXComp0J75yCOWzC+pvWjuWRT+4nahsfM+cmLiaHn0V7gaeA8uE7E
         CqPDs2Gj8Oi73GQeidWX216Uu12+EjOEeCeTEm708QDMjXT4icUIUhobPgnCbtEuJ5nq
         epWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8fNM+9Fl4SDVO1MpW++I3AWFAWGB9v0J0HGJYwUTPuM=;
        b=e/ndcaAcGL4MfdppL3DybL1EE9f6XmHrgZpVdGaUQQhX1hQhMot9tOYf7hm8F4K0IV
         2SWM23VpDUqr+aCFgXYhvkmUhgQtOEc/djfNS7vxDqaZVnSYB9vVYbRHl4umQNrSGqQ2
         YZlnHfpAnEd6usXVs8N8XyQ22321UaCZgmWnt12AWjmBM1rcMIdjvZqodk/hhcmM69Iw
         sWJPIJgi2YUfbJFSu25oWb1GP5nSISSqPEgG3jV/UPr8Pjg1dxQ+4DCJnN1zJiEILPan
         uXynJN6J8XLAHlBlf6OG7L/w9GDhisOOzdtYHcjR70+XZmU0g4b8xggE8v5HDwf//nBS
         45fA==
X-Gm-Message-State: AOAM531mthtnp0HqdUJKJQrN7cjyhy+J6VVeo62kwcqzk36Nc7GNT4b/
        apY+9QAO2rVspEYUZh9zPIZxkoCWTyw=
X-Google-Smtp-Source: ABdhPJzm115WrC09p3tswhbNd63kZk83lUO+9C/GU8SaOpnYswO4vLYCY/az/Cpnocx/wKtfmyU59Q==
X-Received: by 2002:a17:906:4bc2:: with SMTP id x2mr9182473ejv.525.1604798490643;
        Sat, 07 Nov 2020 17:21:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id u25sm4511426eje.99.2020.11.07.17.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:21:30 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/16] cmp: simplify zext(x) cmp C --> x cmp C
Date:   Sun,  8 Nov 2020 02:21:21 +0100
Message-Id: <20201108012126.94339-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
 <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When doing a compare of a zero-extended value against a constant,
this extension can be dropped and the comparison done on the
original type if the constant is within the original range and
signed compares become the corresponding unsigned one.

Simplify away these sign-extensions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                        | 11 +++++++++++
 validation/optim/cmp-zext-uimm1.c |  1 -
 validation/optim/cmp-zext.c       |  1 -
 validation/optim/zext-cmpu.c      |  1 -
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/simplify.c b/simplify.c
index eb2c724f6307..1cb5275b7a73 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1149,6 +1149,17 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_pseudo(insn, &insn->src1, def->src);
 		}
 		break;
+	case OP_ZEXT:
+		osize = def->orig_type->bit_size;
+		bits = bits_mask(osize);
+		if (value <= bits) {
+			const struct opcode_table *op = &opcode_table[insn->opcode];
+			if (op->flags & OPF_SIGNED)
+				insn->opcode = op->sign;
+			insn->itype = def->orig_type;
+			return replace_pseudo(insn, &insn->src1, def->src);
+		}
+		break;
 	}
 	return changed;
 }
diff --git a/validation/optim/cmp-zext-uimm1.c b/validation/optim/cmp-zext-uimm1.c
index ffcdaad5c1bd..c21780ea728d 100644
--- a/validation/optim/cmp-zext-uimm1.c
+++ b/validation/optim/cmp-zext-uimm1.c
@@ -9,7 +9,6 @@ int zext_gt_p(unsigned int x) { return (zext(x) >  (BITS    )) == 0; }
 /*
  * check-name: cmp-zext-uimm1
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/optim/cmp-zext.c b/validation/optim/cmp-zext.c
index ecee6b5e9101..ac4847806251 100644
--- a/validation/optim/cmp-zext.c
+++ b/validation/optim/cmp-zext.c
@@ -11,7 +11,6 @@ _Bool cmpu_zext(ARGS(UINT32)) { return TEST(UINT64, UINT32, a, < , 0xffffffff);
 /*
  * check-name: cmp-zext
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/optim/zext-cmpu.c b/validation/optim/zext-cmpu.c
index 279ed70e0fda..9758e0710d7b 100644
--- a/validation/optim/zext-cmpu.c
+++ b/validation/optim/zext-cmpu.c
@@ -10,7 +10,6 @@ int gtl(unsigned x) { return (((long long)x) >  0x0fffffffeULL) == (x >  0xfffff
 /*
  * check-name: zext-cmpu
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

