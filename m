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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EE3C388F7
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBC520885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1YLamVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgKHBTx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKHBTx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:53 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4941C0613D2
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:52 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id cw8so7243168ejb.8
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKETXCOxbuPiYDn4OL3cUM1t7GC6XVLA7eZ9dGAEPbM=;
        b=X1YLamVBVgxymqFzTFoDqI7/8cducrhgc8AockGhEue56JFDEPoZy5sLPoQyTenay+
         5NZ1KD96SJuBWIm9XRu/zzetG1MYDw9AcWBxXM1+KUXeLFQB/6thS8idOafqC1hDZBCt
         PrOk3h6G9YEZ2D3SVPyfXlFz3Dch5y44W1Btl7hQ3E3KxpKuTniDOMaUoM2TQqkCq6ze
         f742jRRKwUrgy6vvf5r36+wMOAJ6ZlsiTFZNfdjoERmsBi4g4o4LBbDJx6I6fp63CN2w
         6+KYFzCsObWbCY4mFCVRFOvVO2Flp6bsPj9dWaoHfHVHgX4fuJ+ccphrlwfqsT3RSsJO
         B+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKETXCOxbuPiYDn4OL3cUM1t7GC6XVLA7eZ9dGAEPbM=;
        b=M+BK/Oy9nosAjsGt5ZsV3wON7iA1XAFztBpuv3XoZMRGor2zxOWhGuctDSv1jAfri3
         3yVuT/AjkLjR448OYEJ4211aphqV2Iw81Rtt2Np3GQzUDLNkY72r2S0Ex7rc7nShQE31
         hP7nOaSwIzq8Wh/PD6vyu/pE9lPp/ift1qTI4wxsEsuAJD+MB32IGcpbaWlr9KjAkCo5
         p0dxUSAjhKqMhUCTDeOVspXhoNZLloHLC4fSYaTPtPNp9Y+6LgjHOq5pdXjG1vkvriun
         HNsNYZQRa9hRFBG+b/ZnLuY5W5u5eekeWb9jK08SEgdFWfRI8hc556wvwki7q42NkBTM
         uHXA==
X-Gm-Message-State: AOAM533qsmcxTtn7bTUgThjK85/h/C7GN51LfjDOCA+/l/jjC3FbefSv
        tCdLTn4c+y6Hu5gtLoNvoMbX1P0B8WY=
X-Google-Smtp-Source: ABdhPJwrEJrJrasZgIEmNKcJtHwglcxSdPeZIci44Dy56kk8LFVWTugA55lSeT61LThLQaChvFcwaA==
X-Received: by 2002:a17:906:6d99:: with SMTP id h25mr8841408ejt.281.1604798391270;
        Sat, 07 Nov 2020 17:19:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:50 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/16] cmp: canonicalize unsigned compare with UMAX or UMAX-1
Date:   Sun,  8 Nov 2020 02:19:38 +0100
Message-Id: <20201108011939.94252-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Unsigned compares with UMAX (or UMAX-1) are equivalent to
equality tests. These are preferable since it's easier to reason
about them in other simplifications.

So canonicalize these compares to equality tests.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 8 ++++++++
 validation/optim/set-uimm2.c | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 160a6ab15e7f..7921300f7280 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1090,6 +1090,8 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_with_pseudo(insn, value_pseudo(0));
 		if (value == 1)			// (x < 1) --> (x == 0)
 			return replace_binop_value(insn, OP_SET_EQ, 0);
+		else if (value == bits)		// (x < ~0) --> (x != ~0)
+			return replace_binop_value(insn, OP_SET_NE, value);
 		else				// (x < y) --> (x <= (y-1))
 			changed |= replace_binop_value(insn, OP_SET_BE, value - 1);
 		break;
@@ -1098,6 +1100,8 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_with_pseudo(insn, value_pseudo(1));
 		if (value == 1)			// (x >= 1) --> (x != 0)
 			return replace_binop_value(insn, OP_SET_NE, 0);
+		else if (value == bits)		// (x >= ~0) --> (x == ~0)
+			return replace_binop_value(insn, OP_SET_EQ, value);
 		else				// (x >= y) --> (x > (y-1)
 			changed |= replace_binop_value(insn, OP_SET_A, value - 1);
 		break;
@@ -1106,12 +1110,16 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_opcode(insn, OP_SET_EQ);
 		if (value == bits)		// (x <= ~0) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
+		if (value == (bits - 1))	// (x <= ~1) --> (x != ~0)
+			return replace_binop_value(insn, OP_SET_NE, bits);
 		break;
 	case OP_SET_A:
 		if (!value)			// (x > 0) --> (x != 0)
 			return replace_opcode(insn, OP_SET_NE);
 		if (value == bits)		// (x > ~0) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
+		if (value == (bits - 1))	// (x > ~1) --> (x == ~0)
+			return replace_binop_value(insn, OP_SET_EQ, bits);
 		break;
 	}
 	return changed;
diff --git a/validation/optim/set-uimm2.c b/validation/optim/set-uimm2.c
index efa326f532ce..9138ae7276e7 100644
--- a/validation/optim/set-uimm2.c
+++ b/validation/optim/set-uimm2.c
@@ -6,7 +6,6 @@ static _Bool setgt_umax(unsigned int a) { return (a >  ~1) == (a == ~0); }
 /*
  * check-name: set-uimm2
  * check-command: test-linearize $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

