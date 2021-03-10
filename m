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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD176C4332B
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F3064FAB
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhCJWLO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbhCJWLD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60575C061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jt13so41987358ejb.0
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKxt5LUBVm+Q16Mixc+0ghRopZAZs/iOW4EmhpRAzq4=;
        b=k3a84pw1abqjjdBkc4Ue0tXdTDT7AeoZWHPd1MZnC5G4TVCbYB0D+XAftzfLFH4s29
         vXjAfB0Gp1XpXOQxWw0che5wL/wYbgZJXSL+9NPKSHyZvarWQGvkRBG1eCUyDyM9qVZd
         yUyY4Djno3hbvMNPHyMW07udkHvWvMqb2WvlslJgVYwtoQPeT4mUnDfc8ogArpJRWIH1
         +wfMgVD3nSgeOGhobkSoMJvx5XHY0niy+esQ5O2bLFXeDR2vD868yTzyiNMZf80C4MjA
         14kf2KmHxcX5q0AYl0csi+Kehl5bnd2mSxOytVw8dNLadAH5XYWjrTJ4RpStOQqo2R05
         3HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKxt5LUBVm+Q16Mixc+0ghRopZAZs/iOW4EmhpRAzq4=;
        b=EeE+cOo1rodW0Tcn7EjWUMzie65PeoUbuviHeK2epbpvGpmWS+MtmQEF2Daxhc33cm
         G1KdiVMBYOEJIARX4lS5qts2h+oYtZcDmauDJjShsgb8VTpUhhAvD+ssQ+LTSqIfpi4P
         UnHNWFPG3rFpw6F7HXzLarT6464Xw8F+ml8yGmTkWtqiDT9UO2qByQtb+YO/Zw1xqbAE
         e2SheqcZ7qmM+FeVJqGrEQQ8Ek2SrEK/RG99IYHz7wY0IjhSx3qEs7lKleRaRHIINpDh
         RaoOtZb0pMpMJw8iAahx1uU5ErZ6YPj99/xCizQUj9Q2eZ7zQ2faTZDZ92nIQgDc4Ndj
         aprA==
X-Gm-Message-State: AOAM5312zdTo1mqk0lBdYZHK5B/SHswfhJcIRq+Erys2KvKKxCmdb3Rr
        0ml1hny/4944l0zyDECM8Gq6LqIOqCg=
X-Google-Smtp-Source: ABdhPJwVzixx5rLF1Sbx6Et6IcyXCCWToEwsczSF9STAnf6BaZc3qIA5Wdio3w1S7qQATv4z2ieE1w==
X-Received: by 2002:a17:906:ac6:: with SMTP id z6mr42029ejf.505.1615414262118;
        Wed, 10 Mar 2021 14:11:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:11:01 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/9] simplify (x & M) cmps C
Date:   Wed, 10 Mar 2021 22:49:44 +0100
Message-Id: <20210310214950.84192-4-luc.vanoostenryck@gmail.com>
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
 simplify.c                   | 25 +++++++++++++++++++++++++
 validation/optim/cmps-and0.c |  1 -
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 207af8edf28f..90b0c5ba0127 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1258,6 +1258,31 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 	src2 = insn->src2;
 	value = src2->value;
 	switch (DEF_OPCODE(def, src1)) {
+	case OP_AND:
+		if (!constant(def->src2))
+			break;
+		bits = def->src2->value;
+		switch (insn->opcode) {
+		case OP_SET_LE:
+			value = sign_extend(value, def->size);
+			if (bits & sign_bit(def->size))
+				break;
+			if (value < 0)
+				return replace_with_value(insn, 0);
+			if (value >= (long long)bits)
+				return replace_with_value(insn, 1);
+			break;
+		case OP_SET_GT:
+			value = sign_extend(value, def->size);
+			if (bits & sign_bit(def->size))
+				break;
+			if (value < 0)
+				return replace_with_value(insn, 1);
+			if (value >= (long long)bits)
+				return replace_with_value(insn, 0);
+			break;
+		}
+		break;
 	case OP_SEXT:				// sext(x) cmp C --> x cmp trunc(C)
 		osize = def->orig_type->bit_size;
 		if (is_signed_constant(value, osize, size)) {
diff --git a/validation/optim/cmps-and0.c b/validation/optim/cmps-and0.c
index 097ec2f9f16c..962fbd2d29f8 100644
--- a/validation/optim/cmps-and0.c
+++ b/validation/optim/cmps-and0.c
@@ -15,7 +15,6 @@ int cmps_and_ge_gtm(int a) { return ((a & MASK) >= (MASK + 1)) + 1; }
 /*
  * check-name: cmps-and0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

