Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E164C43460
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCD961027
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhDJWbO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhDJWbO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 18:31:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45161C06138C
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so14196546ejr.5
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFiL5Q/NJtXHul7Bsk79dXVlUhHS1d6847PbaJPfV/M=;
        b=qnO0PzneN2RnKG5caAMxpvH4HKUDVFRRA7XW1gFsSoMFRIODnGG59bGZL9H60p42ib
         yQpY1+ShDxppINglm1VrMwrhB6Lp2s0qyl9zJvqLCa4WMxRWfadRafq9MPrgAord3wFi
         nsGvggo+CB2udldZoonQWj5sRt1sL4I9QFdPQDM3PfA91khs0AM71UJRydOL8yTAVj7R
         MgQ/vErfFNt8QGpeufoWy1sBcoQfYwiHXJtDvIBH7lsPDQN2bpGBOcPUsdG5xEilJ8RC
         7NqRVfgXXh/Hz5PbwgSIMEmnyV05PAiOpaP2CiWRlgio29HFadK10Qi+MHYQZeHc1EyF
         NCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFiL5Q/NJtXHul7Bsk79dXVlUhHS1d6847PbaJPfV/M=;
        b=J/fYxunMKCwRXtoJzbJOLQjbW/wRctSIVNcXnb36Dr7TnTuoopn7wAsSy2oai3x5Cz
         a24fYoLYbWQsQlkM73fXX0W1rviolL8q2GQiKJeqzIYf+28w30lVfXjyugnmPXH8M0rO
         TiY4SdA9O+iPattOyd0Q5+hSKiQQg5BXWSVfpSz4HNlnTeFB0Obzn2PYkCgS5NOsUi91
         vUAoZBn3BwFnqVcDpl0mxLIZ/dNk2eJlDMQ4BZUrdUYrfJvhCQc9V6vHflgEshabKOyG
         tYbcoI/RejYk/WI3juKZ/SDQRQ9oH+MUk5AH5EeckjVG3yBY8K1DC+UxU9nTt9hMbrbU
         9NIQ==
X-Gm-Message-State: AOAM532osG/o2oyN0MQLWefXfRFFgjy8ptvfgiyjIYWF5d74QJQZPks+
        M09mjFHftTfcmwZRnBKkqKwjVvlHD6k=
X-Google-Smtp-Source: ABdhPJz+rBSDGe3t5ZNSOhwT6sBt4lN+k1lPHlZgzqpRb9p/PeFZltgOOcNMLBzOI41Yjgnrh/dMCQ==
X-Received: by 2002:a17:907:110f:: with SMTP id qu15mr21307880ejb.336.1618093858068;
        Sat, 10 Apr 2021 15:30:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9597:4a1:b5b6:4666])
        by smtp.gmail.com with ESMTPSA id q18sm3701372edr.26.2021.04.10.15.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 15:30:57 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] volatile stores are never dead
Date:   Sun, 11 Apr 2021 00:30:42 +0200
Message-Id: <20210410223044.86100-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
References: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

so they shouldn't be killed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/memops.c b/memops.c
index 31fd2d3eaffc..8020f2e6cf03 100644
--- a/memops.c
+++ b/memops.c
@@ -215,6 +215,8 @@ static bool try_to_kill_store(pseudo_t pseudo, struct instruction *insn,
 			return false;
 		if (dom->opcode == OP_LOAD)
 			return false;
+		if (dom->is_volatile)
+			return false;
 		/* Yeehaa! Found one! */
 		kill_instruction_force(dom);
 	}
-- 
2.31.1

