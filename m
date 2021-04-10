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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B0C43460
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285E261028
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhDJNbM (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhDJNbK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 09:31:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E89C061764
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hq27so12888349ejc.9
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtBnJvpqiIeBmNYe9hP4F4mtkSRnyV2MSG0yXiMSTMw=;
        b=fZLbQ3nKarEli+tC2P6Y0GA6gSJV68AC2Br6N3m+qyjkyWO5mZ872uRc0OdR4Hz6fD
         zaw+PsHAca5wn6SuXlNK8S2wwEBO2e5NHxUBwyX64QTKa9ok6/jXnXU3Jkf4psbL2RfV
         gbmEGntRjaLqXcPOY+l8ldncKv2jiT2AAd15eeTYa803NvwJQ5M5BVNNXVRA6GykVQG8
         9lJZ6ZJcqGlszQnIpTqLPg16u2rWO8Zu3ZF65M7jZXH3ofSkWNgc7+O1GIO3lY9nY8rb
         TGjf7PPzV4phd+qpMVa3K/eZhMzvLFZAsylGBRknyehASm0qdlxbZqReb9gEHCtufc7V
         1shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtBnJvpqiIeBmNYe9hP4F4mtkSRnyV2MSG0yXiMSTMw=;
        b=tvbNS1Xq3n4GmVnGXqMR1BTcMj8XShCv7i3tF8XyxrhQmcdEntIg708z4HO6srwRXf
         iE764oAwLLF5h8uYaZkULeoDngyY3A33gXW+XHyaKLp2hDUxzXi2szmcVaGFTjrTQAco
         flO82YmbdeQ24qJ/W1JL7w3/uo2Wq7rMt5vNlbYe88O9/FKoRTfY4fGAT/SenP1Bik4S
         bvee9hz1L9w+T6JUORhq//uL51P1kldscsF4ff0Nv1zSXb/JN/LWciGYyrCkaX5lCrHP
         G8AfYf7CGTXSfJ9NI1ptfZtx7qXXWtr3xwAGAbrp8J4hwhnDSgDBqGCAc23uFIeyTlp9
         +Nfw==
X-Gm-Message-State: AOAM530jgcSIHqGaxy+Lf+X5A2sOaVouGxKnGQQUNj+R2NuiR323FbVE
        vCf3aC32HmOzFT85fPYjHWXhc8yH4rY=
X-Google-Smtp-Source: ABdhPJwUXcFoLNjEvY40Lsyd9LiXTG4FyZj26U1w2PBCvXW3VyHP7zuFkoNY5s9rGt8nPLSeoc9/ZA==
X-Received: by 2002:a17:906:1749:: with SMTP id d9mr19579006eje.12.1618061454195;
        Sat, 10 Apr 2021 06:30:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f96a:804d:4fe5:372f])
        by smtp.gmail.com with ESMTPSA id g26sm2594910ejz.70.2021.04.10.06.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:30:53 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/8] .gitignore is a bit too greedy
Date:   Sat, 10 Apr 2021 15:30:40 +0200
Message-Id: <20210410133045.53189-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current .gitignore specifies that the generated programs
must be ignored. Good.

However, this is done by just specifying the name of the program
which has the effect of having any files or directories with the
same name to be ignored too. This is not intended.

Fix this using the pattern '/<name>' instead so that they match
in the root folder.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 .gitignore | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/.gitignore b/.gitignore
index 63c74afdb156..6a28fa50f8bb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,25 +8,25 @@
 .*.swp
 
 # generated
-version.h
+/version.h
 
 # programs
-c2xml
-compile
-ctags
-example
-graph
-obfuscate
-sparse
-sparse-llvm
-semind
-test-dissect
-test-inspect
-test-lexing
-test-linearize
-test-parsing
-test-show-type
-test-unssa
+/c2xml
+/compile
+/ctags
+/example
+/graph
+/obfuscate
+/semind
+/sparse
+/sparse-llvm
+/test-dissect
+/test-inspect
+/test-lexing
+/test-linearize
+/test-parsing
+/test-show-type
+/test-unssa
 
 # tags
 tags
-- 
2.31.1

