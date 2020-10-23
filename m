Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5C2C388F9
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C26B22210
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOQxedWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464148AbgJWQjr (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbgJWQjq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D5AC0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p5so3258095ejj.2
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDpipxFtyIu6yf4VGTryPfpHvoOsqP6AhViDOdPEcWI=;
        b=eOQxedWhjQM4v7kIfDwZdl5pcRfnjakBAoiBGP5U6rsGjnpYnF+PT9zDO/YGdN6CLh
         5ShA9m0dKtQbPPB9aDLQZJrwA32IlEYDXxC8nQrjgsqYcxzeX90hMJuwfsIITWqK33Yp
         acIfd6Tm+/ccTjk8A/0egleN/JJMG1f/Njd81Z8vPO3CHMZhLX5s0anibax63VW5NmOk
         HKKz2p2HEOseV3gqgcNU22vmq5H1w0iYnq4jurIcOQ68in6v/WHP9X/Y1JEIENr4T9bG
         X/43UIUa4Tyk8wKada/x/yBWlL5byor0YH4x1Be7qo50WHw9woWZpfCIxZkq41nhfA/n
         FxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDpipxFtyIu6yf4VGTryPfpHvoOsqP6AhViDOdPEcWI=;
        b=jfWa1bTE9Mk4MmXSC8869y0OpOJFl/2wxvTkDUd59Noqmc8QZAXfP93Q8emc6dNbhM
         ltN+Tt+rcvpRljCKcyp4A0K6n3G5AOqO+sriDZt0bd5IoVVrHxeMP/wPGWlBVeb797Tu
         DJKeM0uHsSNS6UKlDn1d8cvtyndLqeR0/OT9dycW8pFV4uDCaH6opu6vLaY6gdQ9EEuc
         z5AzbHO759GaBpfM7KYxVtUHkxclkfoBQM5wv/2zo3tII8UWiR8JnelBYl+sT42BFi4Y
         AsfmDjYfahCaJQnQ0QScj1zxUg3Ocxkz3l4fQdnDai1YDXx4IjJ/259KiomtLHZ/h0zG
         hbfg==
X-Gm-Message-State: AOAM531dl7nMe5U5qqvoA/VStMnR3Av5DNEcItaRPOxLr/irXRJ6LUxi
        zkj1CZWf1VRAevLSosCysOQ8DPvnOoQ=
X-Google-Smtp-Source: ABdhPJzTLcDlzlmEF2ZGAd+AGlYXp4/OLp1f/zU164vG90bTAxEZ/wNH+zG4rG2iXi9IlDUfnoCplQ==
X-Received: by 2002:a17:906:7210:: with SMTP id m16mr3005486ejk.490.1603471184458;
        Fri, 23 Oct 2020 09:39:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/9] unop: prepare simplify_unop() to handle more cases
Date:   Fri, 23 Oct 2020 18:39:32 +0200
Message-Id: <20201023163939.58359-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
References: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, simplify_unop() can only handle the simplification of
-(-x) and ~(~x).

Prepare it to handle more cases.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/simplify.c b/simplify.c
index 6caf6cbcf918..2750a90512b8 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1451,21 +1451,27 @@ static int simplify_constant_unop(struct instruction *insn)
 
 static int simplify_unop(struct instruction *insn)
 {
+	pseudo_t src = insn->src;
+
 	if (dead_insn(insn, &insn->src1, NULL, NULL))
 		return REPEAT_CSE;
-	if (constant(insn->src1))
+	if (constant(src))
 		return simplify_constant_unop(insn);
 
 	switch (insn->opcode) {
 		struct instruction *def;
 
 	case OP_NOT:
-		if (DEF_OPCODE(def, insn->src) == OP_NOT)
+		switch (DEF_OPCODE(def, src)) {
+		case OP_NOT:		// ~(~x) --> x
 			return replace_with_pseudo(insn, def->src);
+		}
 		break;
 	case OP_NEG:
-		if (DEF_OPCODE(def, insn->src) == OP_NEG)
+		switch (DEF_OPCODE(def, src)) {
+		case OP_NEG:		// -(-x) --> x
 			return replace_with_pseudo(insn, def->src);
+		}
 		break;
 	default:
 		return 0;
-- 
2.28.0

