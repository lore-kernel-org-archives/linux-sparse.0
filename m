Return-Path: <SRS0=+i1M=DX=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5A7C433E7
	for <linux-sparse@archiver.kernel.org>; Fri, 16 Oct 2020 14:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE0420708
	for <linux-sparse@archiver.kernel.org>; Fri, 16 Oct 2020 14:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbHWjfzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405356AbgJPOsj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 16 Oct 2020 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405029AbgJPOsi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Oct 2020 10:48:38 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA7FC061755
        for <linux-sparse@vger.kernel.org>; Fri, 16 Oct 2020 07:48:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id cq12so2712642edb.2
        for <linux-sparse@vger.kernel.org>; Fri, 16 Oct 2020 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1a7MDC3iCJdmVrF3jQluhMmcCP2I1TbRUytlBXMsKY=;
        b=MbHWjfzurkJyW7VusjfVhbxBzSYPj2WCtOi9kl7qJ2kNroSYVfm8LIE3y48OIfMNgA
         Ts1BC+fsePhd/k8dprzcBjp+BN280T3rg3xvtH5vkAhWPehv3Obac2VtwR7A0R7YA/5m
         qsQNBcmz/TQNYDk+YCLwHlShgmkR4ItiJmR5fKQN0ZmqCtjrU/H62KZq2xjxwDDKLB/a
         ww9w2LqsQiAOOkDmgtL/23CULFoD4rpMAy2mrWwbHeZH5GB8tLkgsc8VVatKAoc8r2h1
         BeiQfCjYcLelTsIVZyvdSvgGbiTsxG0FnS1lAEE2nlvRFHY4JbM0OOX2UZzdfAvQ8j2q
         RzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1a7MDC3iCJdmVrF3jQluhMmcCP2I1TbRUytlBXMsKY=;
        b=uOzDB0Riv8JoDn35ld0TQUh11mTyu76GW4Fbp9sIKfUFS9O6KqkYeYyYzMErr1EodC
         sDH9l2qxf/zMsRi+AX6wrUsdqMo+INda5ChZk0cG7avPCQQtsflzSKuCSHHyqgrxNiIS
         hctEkJeLJ0Hd+TqGlr+EWEPqlwdjSAYWNwPwqs4YqpzxcGvlr/7qtQvSrHDpvkfKs4o2
         lHBPYwzNq28zeSUfEkExxXNY7M2EnKmB/A3ltxc88DnbqHle2xa+DlSWLLnnyjCwCPzR
         /BPqPaxHrfyeQ8JEymQsULdfxYS64PHsvnndMNa0wSzQH6ovP+e/bB3BRhDpxacpxCUo
         Igfw==
X-Gm-Message-State: AOAM531JDGH8KQhsM7UC1spfi6E3j6Ndrk1APaLoHXLlkUnHVrK3QPD8
        HjGmbgelL31uLO+Umj7Y8nQMd1e8FdM=
X-Google-Smtp-Source: ABdhPJxRYE0ClrjJgPNVm8dIjbfVf8kQZIPlXUqWSSv7KBOL+NUELIp4AzTMljp5lN04/LEDYgtY8w==
X-Received: by 2002:a05:6402:1d13:: with SMTP id dg19mr4470772edb.217.1602859716987;
        Fri, 16 Oct 2020 07:48:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:1992:7b1c:8dd:2f20])
        by smtp.gmail.com with ESMTPSA id f20sm1745342ejc.90.2020.10.16.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 07:48:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: fix location of error messages
Date:   Fri, 16 Oct 2020 16:48:12 +0200
Message-Id: <20201016144812.68295-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/builtin-arith.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/validation/builtin-arith.c b/validation/builtin-arith.c
index d08c93dab4ee..7aabbcb1bd58 100644
--- a/validation/builtin-arith.c
+++ b/validation/builtin-arith.c
@@ -36,9 +36,9 @@ void test(void (*fun)(void))
  * check-error-start
 builtin-arith.c:10:xx: error: ...
 builtin-arith.c:11:xx: error: ...
-builtin-arith.c:13:xx: error: arithmetics on pointers to functions
-builtin-arith.c:14:xx: error: arithmetics on pointers to functions
-builtin-arith.c:15:xx: error: arithmetics on pointers to functions
+builtin-arith.c:13:29: error: arithmetics on pointers to functions
+builtin-arith.c:14:29: error: arithmetics on pointers to functions
+builtin-arith.c:15:29: error: arithmetics on pointers to functions
 builtin-arith.c:18:xx: error: ...
 builtin-arith.c:19:xx: error: ...
 builtin-arith.c:21:xx: error: ...
-- 
2.28.0

