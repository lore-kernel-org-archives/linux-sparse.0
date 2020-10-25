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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA696C388F7
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 12:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9105620795
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 12:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWD35BqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415733AbgJYMbz (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 25 Oct 2020 08:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbgJYMby (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 25 Oct 2020 08:31:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11DDC0613CE
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 05:31:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qh17so9492400ejb.6
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsG7j8iPi3S+NJfB6vKYepD66aSFl2+2w1XHMpxvPTk=;
        b=CWD35BqEcctFqHFZDjcgn45mrcaPsZhEq4+U8F6QPlheUO4nEzM32/Y8Us0A5K36kj
         TEpKqyjgqYGtfmdguwpcHYZ4lIm3dYW1yp2esxeINuMcdjJajDEEfh6j3Qx1blvF4FIG
         CQK+coRk44efVcsmPIa/ZQUwugBIiW37+9gr+iW5UbVng+Cy0PFFfKB3odm5BxIdvUjW
         utFOvTG8loqPBaADumGJk9ahgdKSOqTpLDohIn+NoYjfFCA+8VQDrpSYKq3WeMkS7ouZ
         k0aWsSpLU60IEGA4/pdBJCGY3gNpfsG8yQyER5S0NkAFtNqpBj22r5rsUR8NZ+gWPtUU
         wofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsG7j8iPi3S+NJfB6vKYepD66aSFl2+2w1XHMpxvPTk=;
        b=ps7eJsF/gY/CbJgHi6YJwOzcFC/Os+0LYY/oCyWh9BfcerafMvh01Jl+P6FmhhaGZc
         LBkVc9ygfq6Xg2MY4FyQjl0yr2lSEik/scU2s51hY3cV+Mm1G+UjOCiZi1ostlGp43Ho
         6YAmsth3NnwOcGlpq+cIm2mVzgJrra0k7FnV/CQNIJFwjLDRBnxYeKsAz9UFgqQIUQuO
         4/x7vUskTGMaU/n9IHIIYEccQbkLdPXcmpR4r2f724qJJNWmvM2crv/ngNbU3hEwaJqs
         SBDgaZrZkrWXXCkYWYS5djarr1LCUVWn3AtewTzwPbfRTW89aa7B5CnKPFIg9bJ8iDfM
         jRWg==
X-Gm-Message-State: AOAM532fVc/2mxOJu4zbfSdsJk+OX0UfuvaE43Ypwhn+a4fsaQbC91wE
        GvP/wRPYOo/FxVC7kCRBvILZOty6CBk=
X-Google-Smtp-Source: ABdhPJwSi8cINPKMorLe/F3GmgSoakQ0f6YVosr5fNr5Y/M0qYi22s0vMXAteF8DSaE1uYTjiBZhOw==
X-Received: by 2002:a17:907:366:: with SMTP id rs6mr10987197ejb.352.1603629112437;
        Sun, 25 Oct 2020 05:31:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f136:83e9:1c3d:13f2])
        by smtp.gmail.com with ESMTPSA id w1sm3861669ejv.82.2020.10.25.05.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 05:31:51 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] OP_CALL should use the full function type
Date:   Sun, 25 Oct 2020 13:31:47 +0100
Message-Id: <20201025123147.19301-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

OP_CALL keep a list with the type of the function itself
and of each of its arguments.

However, the function type added to the list is not the complete type
but its base type. So, we can't use the function's modifiers or contexts.

Fix this by storing the complete function type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linearize.c b/linearize.c
index 1081bda86425..2432801135f3 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1520,8 +1520,6 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	}
 
 	ctype = &fntype->ctype;
-	if (fntype->type == SYM_NODE)
-		fntype = fntype->ctype.base_type;
 
 	add_symbol(&insn->fntypes, fntype);
 	FOR_EACH_PTR(expr->args, arg) {
-- 
2.29.0

