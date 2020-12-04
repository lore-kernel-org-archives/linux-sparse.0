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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EC7C433FE
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 16:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AE52223E
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 16:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgLDQOp (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgLDQOp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Dec 2020 11:14:45 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E5C061A52
        for <linux-sparse@vger.kernel.org>; Fri,  4 Dec 2020 08:13:59 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id d17so9424710ejy.9
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 08:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bjq3Is6yAOcS9RC16JLydABtizsxMwvstqGXvMtrZ0=;
        b=OAHXwVJbDrQ/DcUT8HvLPL5AicMD9d9yuw4nlJTVwdI8cS9KkTc1tKTd9M5Nw645m0
         ycvV/dBs5j3OTZ2Lys6/reOfy74F3S9zum4A2aa+GOH4siKuAs/pgXX4WnIMfzXpxHe5
         sI+4GoARDV601OZpJfuZrTOmtpjH647SrQAiTgVeaRigjfks25m9ereUPvRBA0VB/Oof
         eXourhK9UE1wyYrn0VNh1vpTNuKtdkufCX719+wS2ZzfrwD44rZB9uxf4xvrxm7hFrDj
         Q9503gGEXr/GEejS3badWan50Si4zu18kflzo1CTm4ljlF0B7e5SNqP8IwBxFWqivgnN
         QOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bjq3Is6yAOcS9RC16JLydABtizsxMwvstqGXvMtrZ0=;
        b=JwlyPeV19GYm2H5cow0sIybyJGIbDwNFqAkHCn9HuXW+cE062BchygqdZ+SD0sAuQd
         kEu3cSnI2yDC80yQNRStVCmVyp0OSHLmt/V4mQybursjLnq1m3/YPTKqdBLhWTgsQ33u
         FnveMA08pUOiWbY342eL+WthcvLZPpOGw2ngm2nzu3dSs0Dq3aZHq25kV7VQE6d0aiyO
         Jak3jlb7IgZotzEVgxJ02z1ohqnXNYhIKscXstqztGwHD3NMOdh35MsepF2ssdLhQTCI
         k21lgjFn2xwJ7P+bbCISC32qYzoKPmiW1oqxewQV5kNZcknHs8dUsEMGo+9zaazHBEv5
         dsUw==
X-Gm-Message-State: AOAM530fE80nCAz6Q8+plapNo88qTPHjkZO1iXJiUdG57rOHkiTxRV/Z
        T49m4TByRuPQ9avtmExFI1KQI/kzRm0=
X-Google-Smtp-Source: ABdhPJwd8aiIlx2PtkYJWlTkA6seWwxR5wxWorBMiDb7xkKG2noBoHm5QKNwI59iC01/HDTxcEufZQ==
X-Received: by 2002:a17:906:234d:: with SMTP id m13mr7868401eja.270.1607098436549;
        Fri, 04 Dec 2020 08:13:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:8183:34c1:3ce4:9984])
        by smtp.gmail.com with ESMTPSA id bg4sm3407597ejb.24.2020.12.04.08.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:13:53 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix killing OP_ASM
Date:   Fri,  4 Dec 2020 17:13:49 +0100
Message-Id: <20201204161349.68272-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently OP_ASMs are only handled by default in kill_insn().
In consequence, the usage is not removed from their inputs,
possibly leaving dead pseudos.

Fix this by removing the usage on the input pseudos.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/simplify.c b/simplify.c
index 851f94209975..a877b693b610 100644
--- a/simplify.c
+++ b/simplify.c
@@ -308,6 +308,15 @@ static void kill_use_list(struct pseudo_list *list)
 	} END_FOR_EACH_PTR(p);
 }
 
+static void kill_asm(struct instruction *insn)
+{
+	struct asm_constraint *con;
+
+	FOR_EACH_PTR(insn->asm_rules->inputs, con) {
+		kill_use(&con->pseudo);
+	} END_FOR_EACH_PTR(con);
+}
+
 ///
 // kill an instruction
 // @insn: the instruction to be killed
@@ -373,6 +382,12 @@ int kill_insn(struct instruction *insn, int force)
 		kill_use(&insn->target);
 		break;
 
+	case OP_ASM:
+		if (!force)
+			return 0;
+		kill_asm(insn);
+		break;
+
 	case OP_ENTRY:
 		/* ignore */
 		return 0;
-- 
2.29.2

