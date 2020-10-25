Return-Path: <SRS0=+N6z=EA=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD980C388F7
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715B42222F
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIwepRpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416176AbgJYNJc (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416173AbgJYNJb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 25 Oct 2020 09:09:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95645C0613CE
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:09:30 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d6so4922627ejb.11
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLM8KpVoVG3YCdXsDKj/N/T54DNeEMgV0N6kdHzVU64=;
        b=lIwepRpcLIYkWvsaOCkLyJ+6y6Xv7T95WRhp22OnohWL3bugs3LkHQTQ/Mg9ePkcdU
         ic3LGu+wZzP/BYjTeZ52XFiFHOo/rh9b7Z3fb5onyB+AKTM2HmwxT18N2CZbun5EJXuO
         C6B5a39jYAtI194inN+mZyurRUrxR78W/17iVY2cPiVHo8hPITo5rY8lJAyM77ZBtX80
         t5wayS/wPtyJ5YSiVsWOIraYtHBr+osZ086jQpmworTaFxoMUWVrafhZVab/Qm+SniaY
         klyywev3tsU4O0Ted/BbI3RAZHHU3dFDG+hQfMBw8u4lwJ4IEnguD3SqezGm5EEd9uhB
         Royw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLM8KpVoVG3YCdXsDKj/N/T54DNeEMgV0N6kdHzVU64=;
        b=E7Qvbs4mKnVcm2ALDakwof8j3I/JfFUOT+npVEPRPMd84Qy1ZyAP6zZIAw0h0P9kNB
         imljK000FiFFLNc+bjbBIRJxToJAeH+uAnncotRfXGm+2QsTO1zCBYCBJflEJwyS61g3
         gdztpGZwCA3w8F/AxJEAC9iAaiJGO68FX3QM+24B7K5w2jEim+EUEl4boLq0xIxTCHQt
         /YPQA+F4JSlCv1cpdB7quB0uT87+5YE3IvxfTtqv0GyhFpjhaYWkosazzXzpOuEokU8k
         Z8Scc5EAPpDehobD7+AbS7AspdwAIF6DDjuUYMN9CgGZ/xS3p9wswE81DZfZrgjKaG26
         igcw==
X-Gm-Message-State: AOAM533h5ACuSK12z9IKUZwZUDmf5BlJigZny4BTct8MdHAaKfltjvLL
        XzmsOO0WHmhWP77HFCBwX0uRWR0Ef3A=
X-Google-Smtp-Source: ABdhPJwyrlKDDvvtkAHHqUv1TYuwIgcDeMY571K5eAvYcIrc+S+blnYCZDLW9tBpLFBygiqFOGA08Q==
X-Received: by 2002:a17:906:1418:: with SMTP id p24mr10882042ejc.46.1603631369127;
        Sun, 25 Oct 2020 06:09:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f136:83e9:1c3d:13f2])
        by smtp.gmail.com with ESMTPSA id q3sm3571350edv.17.2020.10.25.06.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 06:09:28 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix testing if a OP_CALL's function is pure
Date:   Sun, 25 Oct 2020 14:09:21 +0100
Message-Id: <20201025130921.20693-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025130921.20693-1-luc.vanoostenryck@gmail.com>
References: <20201025130921.20693-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

kill_instruction() will kill an OP_CALL but only if it's a
forced kill or if the corresponding function is pure.

However, only functions called via a symbol pseudo are so killed.
Those called via a function pointer are not because only symbol
pseudos contain the function type needed to test the presence of
the MOD_PURE modifier.

Fix this by using the function type always available in the
instruction's ::fntypes member.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/simplify.c b/simplify.c
index 6caf6cbcf918..634a3ea66e91 100644
--- a/simplify.c
+++ b/simplify.c
@@ -351,9 +351,9 @@ int kill_insn(struct instruction *insn, int force)
 	case OP_CALL:
 		if (!force) {
 			/* a "pure" function can be killed too */
-			if (!(insn->func->type == PSEUDO_SYM))
-				return 0;
-			if (!(insn->func->sym->ctype.modifiers & MOD_PURE))
+			struct symbol *fntype = first_symbol(insn->fntypes);
+
+			if (!(fntype->ctype.modifiers & MOD_PURE))
 				return 0;
 		}
 		kill_use_list(insn->arguments);
-- 
2.29.0

