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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F20C433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 19:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4982A610CF
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 19:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhDJTDA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhDJTDA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 15:03:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F931C06138A
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 12:02:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m3so10316054edv.5
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1qMp7iuTjugNLlDHDh8HY5WHAVNNNH8BiM3pEqMnBwk=;
        b=V427y03oRgMUOiGKrfnuLHIcL7cAvR2lNnSMf/Brir/4WTHaNFesWt36F8IqmsPCrR
         CtujkC/2wP5s+tlD9LEpuPEYOhjEjxvNuSdkfZO9FqyMHidfgDgSV3VkjyWeYwOCUgm8
         neY/eF4EQFPI5U17S9AprLijU9rFi7WjPY4bicPyNvnm09yGLelmqPwgzSJJcb/DjbW9
         yBtL3UHKwgqMmDjruLQmgVZ7Ad5bjEaNXLRzSSergKogLkw8DewmuvfTUiIoAYyOiWI4
         W4Qp4fUFOiW5McC28jQbrZL9WmKh1/IwAZ+GaQfpEHcIF2nN25lt1Crv8be7PzEseTph
         YB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1qMp7iuTjugNLlDHDh8HY5WHAVNNNH8BiM3pEqMnBwk=;
        b=qt/KJKRMm3CKVmRPQSh53xfnZf3Mar/BrCQlUo3dCPYwbrdd137xk/iJ0c+O+yu/R/
         wGPAb3nZtXDsHcodHZQWl0+DOYzk1woIWZRfi2U1QnQqIxyPgP+7orQzcFN8798UuPh9
         3aafDueWs2xheYrQFd67A1B4sS1O0NBkiBf6QxZtb+KynWFziA2I4FT+tTvEttY+H/UF
         +iWHbcK4KCthcF1YbgY3YyplcDKdIRUMLzTaATYbDUeGDWCC5tXwGDJuK2StlLlnW8a2
         6ZsS2qMvaUqBev+oYEWPnFKUTd3gbcEnMPTiH776ngwT4wj43zWU46dc6BOfejIs+4aw
         QRMw==
X-Gm-Message-State: AOAM5337HHZQC6RHxONl/SMUWsAsKqkoaBLpcn2mG6OT7WDBV1CutstS
        fJT+jl+uDPVzkZRhSmjVuuk1qqRALhM=
X-Google-Smtp-Source: ABdhPJzuKggjEtsxPf9QuOlKB36xKTlCP6z1Q+F/8Boi5T73mfzQMrWr39MmK2/DwLLiw/OCQ0pioQ==
X-Received: by 2002:a05:6402:34c8:: with SMTP id w8mr23629460edc.235.1618081363593;
        Sat, 10 Apr 2021 12:02:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9597:4a1:b5b6:4666])
        by smtp.gmail.com with ESMTPSA id w1sm3616790edt.89.2021.04.10.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 12:02:43 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add some notes about pseudos being typeless
Date:   Sat, 10 Apr 2021 21:02:34 +0200
Message-Id: <20210410190234.83750-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Pseudos are untyped. It's usually OK because their type can nevertheless
be retrieved in a simple way. But it also complicates things and
worse in some cases the type is completely lost.

Tell a bit more about it in the TODO file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/TODO.md | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/TODO.md b/Documentation/TODO.md
index 3f00bb1104d1..bb25c714a212 100644
--- a/Documentation/TODO.md
+++ b/Documentation/TODO.md
@@ -56,6 +56,15 @@ Optimization
 
 IR
 --
+* pseudos are untyped, it's usually OK but often it complicates things:
+  - PSEUDO_REGs are defined by instructions and their type is normally
+    retrievable via this defining instruction but in some case they're not:
+    for example, pseudos defined by ASM output.
+  - PSEUDO_ARGs are considered as defined by OP_ENTRY and are used like
+    for liveness trackability but their type can't simply be retrieved via
+    this instruction like PSEUDO_REGs are (with ->def->type).
+  - PSEUDO_VALs are completely typeless.
+  Maybe a few bits should be used to store some kind of low-level type.
 * OP_SET should return a bool, always
 * add IR instructions for va_arg() & friends
 * add a possibility to import of file in "IR assembly"
-- 
2.31.1

