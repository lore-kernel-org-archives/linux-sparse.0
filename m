Return-Path: <SRS0=ez6N=CO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCF2C43461
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD5720757
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9X5LLo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgIELM3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgIELMW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 07:12:22 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95EDC061245
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 04:12:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i22so11858697eja.5
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QvU1Zc6FDCgpXPiz8LPz25ihK1xA0Tr5Bo0r+9cilEk=;
        b=X9X5LLo45V8hU/3Dmt/VZN1bu2v7oUmJhRxgbli5hByC9PTvq6alIlCNFWGexZBQkg
         31fjOfTpx23ODFkT6zdyICQ9jRVnJ47AODA0HSzxCMur0+Ixieyv+F95PFyM+SR+YIwG
         WRSo99U1UV2MyIDe1R8oVraAgINR3rURCkzyaNDM2wjldr0+b+CyPTrHRfCR9dPGOY/V
         M0qOh/UQ0sBjzASBAzCqnpJB17SeJkmo7kKWW4pB/WmepfGunj0k9WGVT6gsS9FFb+90
         thonqLBpkY1uY8sDv0soPMHtxj8tNoiCYGQfizCD6cEg8Vc8X3dQRma+VBdOztu8thq5
         Ewpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QvU1Zc6FDCgpXPiz8LPz25ihK1xA0Tr5Bo0r+9cilEk=;
        b=YeLmkieqsbkVRj9nUlqTny25G0x9vGHhUq6akqxR4YpXbTr8R/YdPxINBMLXrmdiiG
         DTHKEk6CDGgo99hj78tI+KVS8qc6IARjmmKAjw589I8puoshwBT6sIII14T5Ufla4Xxc
         XpBQzCT4xizZ4iz9fdsxGltsPoFH5L0kHPsKOQ5A2ytBnMefmwvhoaMXqchcMP7ioQMq
         dEHl7r3TnZq3qpWXt4e3EXmkIsan3cCPd43sd2Zs8yUEczCktMRrwjtx+MTwvJHGI7RY
         1Qp9V2VivNrHpmw7EoF3HLD+evWezfsJcT2mFoYwYASWKv6vIJJceoS1+LE8YmyY9yl5
         Y71g==
X-Gm-Message-State: AOAM53023yq8d33+N8qrG6AHwb+xroIcKJIGATvz3bL0UnTuIHUuwlmm
        ZVBL5eLMdnE3twI6IxbrhD6PdrIDEzA=
X-Google-Smtp-Source: ABdhPJze+gzTuNbHSAgdDaZVFP9z6W15Vu//ib/xcmPl4fhICIGig5C+oqK84Vx/47hd4YN8dPiX1Q==
X-Received: by 2002:a17:906:8690:: with SMTP id g16mr11737931ejx.187.1599304337838;
        Sat, 05 Sep 2020 04:12:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id u15sm8319506edj.69.2020.09.05.04.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 04:12:17 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] add support for a new instruction: OP_FMA
Date:   Sat,  5 Sep 2020 13:12:08 +0200
Message-Id: <20200905111211.82199-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905111211.82199-1-luc.vanoostenryck@gmail.com>
References: <20200905111211.82199-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This will be the instruction for fused multiply-add
but the motivation for it is some experimentation with
the linearization of builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 ++
 opcode.def  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/linearize.c b/linearize.c
index 5a8e74970d98..1a2677713123 100644
--- a/linearize.c
+++ b/linearize.c
@@ -244,6 +244,7 @@ static const char *opcodes[] = {
 
 	/* Special three-input */
 	[OP_SEL] = "select",
+	[OP_FMA] = "fma",
 	
 	/* Memory */
 	[OP_LOAD] = "load",
@@ -461,6 +462,7 @@ const char *show_instruction(struct instruction *insn)
 		break;
 
 	case OP_SEL:
+	case OP_FMA:
 		buf += sprintf(buf, "%s <- %s, %s, %s", show_pseudo(insn->target),
 			show_pseudo(insn->src1), show_pseudo(insn->src2), show_pseudo(insn->src3));
 		break;
diff --git a/opcode.def b/opcode.def
index 2583e2f4a602..58fe9983cbc2 100644
--- a/opcode.def
+++ b/opcode.def
@@ -91,6 +91,7 @@ OPCODE(SLICE,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
 
 /* Select - three input values */
 OPCODE(SEL,             BADOP,    BADOP,    BADOP, 3, OPF_TARGET)
+OPCODE(FMA,             BADOP,    BADOP,    BADOP, 3, OPF_TARGET)
 
 /* Memory */
 OPCODE(LOAD,            BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-- 
2.28.0

