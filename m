Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B2EC41604
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A959E2237B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BitYzZB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438669AbgJTVKo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438680AbgJTVKo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978FAC0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id h24so4835549ejg.9
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=daEENoVXtJCtGpSewHDuWwUYs9cRkwFb1HtSCPa8Izo=;
        b=BitYzZB31kIo8RJBpCeuTeNNxQBl+rxQQ9wjPfXATAHaEeYu6Jkyro0rBq+lkrp7pB
         e1FFy2esWgvAa0q1qcdggsAXvoX1nKH8X+VUeu558R5ElAirIom4+uHC9xZrLbi/Napj
         3BjZixftPLehA896+uLkrg2Tt3z3ECq4X/C5ApJ38Xn8I/H3Baf2MqTSn8berYpRQKAN
         PwQ7mk0cvdDKm06rjZvfkdWI4lj+8c32No9ZjpvZnFEVjvviOiDTDkRa9uYLOOS651U9
         2yyz1eTVdguVnjqeJDFja+yfVE3wxM9mvgI/VM99ldZKkejCui/2k0WLS2/Vqw8mk4ym
         UPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=daEENoVXtJCtGpSewHDuWwUYs9cRkwFb1HtSCPa8Izo=;
        b=nZhMhgueeRB8ePwiLXl06Ya5ropA7isjGUNSSZ9QwWUGMHpJvIdFhME/+AZX64ZK6w
         kJTLgD7zfQ5bLLrsTNWewjMzrS9dNTierD2om9NawkESR0MpG92S2yc0gUwD+u1or4z3
         66MbTUKrjsiAEa/TCsq6n3dZqE3PnSKUzfe6eGFjf6VG0feQkEhnz65wdbYx5nTLsE5Z
         Pt//3iJKEDAN3wVVtdWNUbgM0leH6P7zk3obKv2pCzSmS7PLMi3pX8NOeqDgNTjCRQVf
         8kN3q9czVXQGvlM7QrW/wbahzi6gd1FH6wAUTPS4oS8QeZiQg5RFIhMANgddPG5M3iZs
         attQ==
X-Gm-Message-State: AOAM533ahYA0kx2saOY1/zTVrPfKkanvNIh5slv4OLObFb2uvojdk7dX
        s0fUmGGz2wtiXmgTXsaMDRjqUbWBMlM=
X-Google-Smtp-Source: ABdhPJwwTFdatOEEoi/zsl8WbTiTtXEwMBh9wRvM2iZdfgYxkYuPS2oAvj6HtrSJMkDwS040C2TKWg==
X-Received: by 2002:a17:906:b783:: with SMTP id dt3mr97910ejb.534.1603228241118;
        Tue, 20 Oct 2020 14:10:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 19/22] sub: simplify x - (x + y) --> -y
Date:   Tue, 20 Oct 2020 23:10:18 +0200
Message-Id: <20201020211021.82394-20-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                                | 4 ++++
 validation/optim/simplify-same-subl-add.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 08b706ca8f41..48bf48d29f9a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1396,6 +1396,10 @@ static int simplify_sub(struct instruction *insn)
 	}
 
 	switch (DEF_OPCODE(def, src2)) {
+	case OP_ADD:
+		if (src1 == def->src1)		// x - (x + z) --> -z
+			return replace_with_unop(insn, OP_NEG, def->src2);
+		break;
 	case OP_NEG:				// (x - -y) --> (x + y)
 		insn->opcode = OP_ADD;
 		return replace_pseudo(insn, &insn->src2, def->src);
diff --git a/validation/optim/simplify-same-subl-add.c b/validation/optim/simplify-same-subl-add.c
index dbc0fe97f126..e7ae08092556 100644
--- a/validation/optim/simplify-same-subl-add.c
+++ b/validation/optim/simplify-same-subl-add.c
@@ -3,7 +3,6 @@ int subl_add(int x, int y) { return x - (x + y); }
 /*
  * check-name: simplify-same-subl-add
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: neg\\..* %arg2
-- 
2.28.0

