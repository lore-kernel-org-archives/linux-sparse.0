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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC54C433E6
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 09:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FE2207E2
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 09:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgL0J2q (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 27 Dec 2020 04:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgL0J2p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 27 Dec 2020 04:28:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840C8C061796
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 01:28:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t30so7889666wrb.0
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7n4RElj/o9VgPMDmk+wZnxQpcGKXr6GTzzgkPzIvSE=;
        b=rEWRV6c3NOBqH5spuDTmtYV03H+WvcOhFWbLM7QOHJ3nxbJH+SsrUgC6c5ZKhab0QX
         6wp/a9T1pp9l2t2E4V+3qBZD52Wdtk8kRanZYJOtLONBbJ8qG0EeLWhw16kmI3st6RwT
         luh16bCnpByIIZHReapc5bPDGrv8/qzdMDk38TC7GtLMZ9fXTRzPRbngKjytWWbFAEaZ
         azjWj6DPis2IV/33b6Luc5hyaO/pSXV2CjgTASE07/giX9403K3Wm9N/VLdiEbLPhkEK
         h8eQXRcIA41sTSpFCpuN5m5PJZCrFi2qrCsutsDg7f08GkqfzLTwa5grz7WaFYYpX30u
         ysSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7n4RElj/o9VgPMDmk+wZnxQpcGKXr6GTzzgkPzIvSE=;
        b=HBWO66x7rbUfgfaya4V0LvA1xRnuqbvfZWg/FvnONCgkucINghUL+RwqPtUz57wEWL
         IWoB07WzHY1Nx/hzfd45EUNFKnNqoBGc6rsmAbfv1q5XEuclGUB36P+Aq/kxvxT1INr0
         Ko/KyhFf6TPGXOBeyI3s6hibCP1bbrXoW+zLGHRZZm/2/kQF3W4G+73kGctEU75Vk/5l
         Goz+Y4Q3Ghyvl2phxr4qu74wuudAOktF5iAgSQgY3No5ZRqmC7UEmPxzugoe/O+oxFVm
         m1S51nS3+5n4sJopxjLTzX6Vb+NNTJ2KQf5wlJajms9toV0BsHznJ9GEsblcKoAropE2
         hW0w==
X-Gm-Message-State: AOAM5309+bKacKWHcNbcil8Ow2/2I3oj1VR5EUXIYXQullLu3SwpmtoW
        0RGpQHkVueMI78+XkZRpjf0SOw2QkQY=
X-Google-Smtp-Source: ABdhPJxpCdRHYmTRN8w5fcKst4qO29CVqtDLztafJeItFJwpyywVOeUlX0FMQRGhBz+H8g+1ke1Org==
X-Received: by 2002:adf:f70c:: with SMTP id r12mr45724435wrp.234.1609061284389;
        Sun, 27 Dec 2020 01:28:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c99c:3949:2fe7:7420])
        by smtp.gmail.com with ESMTPSA id n8sm49904007wrs.34.2020.12.27.01.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 01:28:03 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix rem_usage()
Date:   Sun, 27 Dec 2020 10:27:59 +0100
Message-Id: <20201227092759.30999-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
References: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

rem_usage() is used to remove an element from a def-use chain. Optionally,
if the chain become empty, the defining instruction can also be killed.

This optional part is currently be done on all pseudos but only those
having a definition should be concerned.

Fix this by adding a check so that only PSEUDO_REGs and PSEUDO_PHIs are killed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index a877b693b610..12482d787189 100644
--- a/simplify.c
+++ b/simplify.c
@@ -271,7 +271,7 @@ static inline void rem_usage(pseudo_t p, pseudo_t *usep, int kill)
 {
 	if (has_use_list(p)) {
 		delete_pseudo_user_list_entry(&p->users, usep, 1);
-		if (kill && !p->users)
+		if (kill && !p->users && has_definition(p))
 			kill_instruction(p->def);
 	}
 }
-- 
2.29.2

