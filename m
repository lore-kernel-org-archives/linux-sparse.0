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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A2C55178
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1963208FE
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha+kpcI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgKHBTx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgKHBTx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:53 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B1CC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:51 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id i19so7240699ejx.9
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVscvQq2u4pMMO44qX3iV/3iy7b4PJ3CJXZcmwu1cTg=;
        b=Ha+kpcI0olcN0Orcp3yexQn5A8S64xm5nuE4IUeXo+xLBSkld/1Px/E6dW/bj4Yej4
         xN+NYoPdoVEljxjhHD+SoN8vig229yEZ7by4R3AYhY/QdUkAcDRGbmZjqu0GZFdK+kT1
         2FU9xZVEa+xj+6KwN9ufvzLv4qW+HHu2vY5TqxRW+87vZm2hyHvRy+CaVi6APQWd3mon
         j4Tf1Qit3VHH0kdOlX91//D2wSiFSFbZv5gRllnmqboMd6PKmZb1zres9TqE8lBjo69O
         nkPgmraMKEGbEz+21k9b+aLyZKHBieFxnYncczSLSLZo2/DJ23zURsHIiYfFh56RLn/o
         H5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVscvQq2u4pMMO44qX3iV/3iy7b4PJ3CJXZcmwu1cTg=;
        b=QSXUCQVIZUEDjyY7yaGi57z7vkFBJxGSG/BGP9vGFe+ZZjl9wVYbtvoZ+p+EPZr5NR
         4/dLiffEkKQprMVRuBROqPTBOUWws9v1uCCLjbuxNSVGSt8iXhP9AtU7vGFoXPffFLwC
         OivqpesYJU+uwH1R7xCX3O5p47+AR0rUsQLGJZoszydrEZX447DmOHxlW5V1c1qwci3x
         zJcIIh/8wSCErjgFlH773BE7daNsxHkFmxQEXE4BhAVuIhT4qhtdt8WOAjESnzJoLvcS
         a601aKEWgiYqX5K1vOauoO2Gg7tNsMLETP75WpGEzaK18/tVpyLJUputReu/PW5BOyYt
         s/YA==
X-Gm-Message-State: AOAM533YupDX/7KbI7xpdLTp1HEDOCEIyeoMfhSUEYdycJ025x2MR2B7
        QQnE+DxMW2RhTD3T8Ncet+ME6he39qo=
X-Google-Smtp-Source: ABdhPJyXXbx3wr90RaQbNrtunDTw6Hufz0QiRXxAc0NPmVSvjQMISgzJkOA5IjQKrp8TL78jVdhJxg==
X-Received: by 2002:a17:906:1458:: with SMTP id q24mr9218479ejc.541.1604798390206;
        Sat, 07 Nov 2020 17:19:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:49 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/16] cmp: simplify unsigned (x {<=,>} UMAX) into {1,0}
Date:   Sun,  8 Nov 2020 02:19:37 +0100
Message-Id: <20201108011939.94252-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These compares are always true or false, so simplify them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 5 +++++
 validation/optim/set-uimm1.c | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index b8dfbad1f077..160a6ab15e7f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1081,6 +1081,7 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 
 static int simplify_compare_constant(struct instruction *insn, long long value)
 {
+	unsigned long long bits = bits_mask(insn->itype->bit_size);
 	int changed = 0;
 
 	switch (insn->opcode) {
@@ -1103,10 +1104,14 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 	case OP_SET_BE:
 		if (!value)			// (x <= 0) --> (x == 0)
 			return replace_opcode(insn, OP_SET_EQ);
+		if (value == bits)		// (x <= ~0) --> 1
+			return replace_with_pseudo(insn, value_pseudo(1));
 		break;
 	case OP_SET_A:
 		if (!value)			// (x > 0) --> (x != 0)
 			return replace_opcode(insn, OP_SET_NE);
+		if (value == bits)		// (x > ~0) --> 0
+			return replace_with_pseudo(insn, value_pseudo(0));
 		break;
 	}
 	return changed;
diff --git a/validation/optim/set-uimm1.c b/validation/optim/set-uimm1.c
index d6928f59d044..aa9f54c3ff82 100644
--- a/validation/optim/set-uimm1.c
+++ b/validation/optim/set-uimm1.c
@@ -4,7 +4,6 @@ static _Bool setgt_umax(unsigned int a) { return (a >  ~0) == 0; }
 /*
  * check-name: set-uimm1
  * check-command: test-linearize $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

