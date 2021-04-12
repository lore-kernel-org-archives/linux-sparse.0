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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077CCC433B4
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA2361278
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhDLVVn (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbhDLVVm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE92C061756
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n2so22572763ejy.7
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtBnJvpqiIeBmNYe9hP4F4mtkSRnyV2MSG0yXiMSTMw=;
        b=KczJiMkGiocpfuw+96XRbWtvm2jq84y6uV1ArtpB85Fj0Mu8+3lttiBfR2eFVHMK7t
         ud8E6o+uwmNzT4JkOwloR2VsgZ3ztHGheWGiXnyn8Ogvo3CcVWrkWYfJ+/G/oJVyNs94
         W9LhWOhhI24IawTiLL8ZFGSAoEz481cSxftv3bs+5eDQK/a+TTtiLkc0H4qz9H9t4HLu
         n1sbC6pbdS2/zMPyCHxVRPWclZ37rx8GmxHnU5H8VQ/tQxsxEGvmJ7kGsl++gnurJZs+
         7uUk7ykDioCdO+17Ubccxov3f5Q1hOKFoU1yOUkt6WgQZRbZUeFinjRv78epud85C8fR
         prvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtBnJvpqiIeBmNYe9hP4F4mtkSRnyV2MSG0yXiMSTMw=;
        b=j28WoOHwSOx7OKj7OlWY0QrL7aGSWKIHDxMWsewgFgC7nX2UPPNTJxO+2KPDADHUWG
         zibziH4in5NbUa+jd2llY+tqyfYvX8CFQ560+CQMYT1vVLRpffL5tL8uvbccH9W5b5fe
         Z8Pv2kgcjN69l/rCXsQLPJRU0FeFJuHlgmCn9QWsFTgHh4v0dmDgs9wueFmAES4VgL97
         iWdyDXIhQ8kBpou5LncB9GVGEHire7n06hTadgQtDsUU+k5ir0Cz24z6qGZPYvLdLlxH
         avr0qM/G0hvrpygoqHDckuMQ5Ei7EYzIk2GV8PRcQC6gDqeFOc6FbEv+F5wJrtbAtNNv
         6AgA==
X-Gm-Message-State: AOAM530GmR5kIEpC0yPww0QRLmZXKH1LUshsqvxTx7K3BllTXc7LJv5y
        cTYSaGit20LwXeWVukxYz31Vp04NJZM=
X-Google-Smtp-Source: ABdhPJwGR2wDcZI38gnksN1wxoQX/6CG75TDYVqos60WsYtFKc4P5WTyHKWdgk+gC6Pjt2dKKOpAjQ==
X-Received: by 2002:a17:907:9611:: with SMTP id gb17mr29800501ejc.325.1618262482571;
        Mon, 12 Apr 2021 14:21:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6903:692b:54da:df0c])
        by smtp.gmail.com with ESMTPSA id g11sm7744156edt.35.2021.04.12.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:22 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 3/8] .gitignore is a bit too greedy
Date:   Mon, 12 Apr 2021 23:21:06 +0200
Message-Id: <20210412212111.29186-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
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

