Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB8C43467
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CB922276
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQkd3ibq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgJSQMl (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbgJSQMl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BB4C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p5so14728877ejj.2
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8cpVPqj17DeUvIsJUVEWFSgZfpNePdbHORULlDxSpwE=;
        b=MQkd3ibqpUIzR/lK+QQvjPPtB8MCdJ4xSgi3TgosziX1DMgFYhXjhv/WyxExGwGaxI
         hfXPi6xEhqUCiB5uecv53NkRBagp0aeiaxyilIWE4YNbyF+kO/QaWj13VjrD+oioghAv
         qnZS9gmh+lfdU4eua4SeF8EQ6B0jhZmBMe9Cm2i3z9elAAie5CJKOUl68mrUwvfFzHqq
         yv4i7XrmTwuLw4waXE2D9mX3x53ljteInReZp00HYTWaZF8FCDzsqwdaeGWdjS7mbzrV
         dWhFyll9dRdKw4LsjBVgz7/z2Gkc8DmzrQWq6+gYePSwxsEHM3D+eV9nanE09yhjPHb+
         bilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cpVPqj17DeUvIsJUVEWFSgZfpNePdbHORULlDxSpwE=;
        b=oCdnIvalGTUivENizZLXKV/LxcaqrI5mXDOIdwyFIx2wtWtn7KZf9cQGYAlRyMX7tr
         naiQMaI9L7Ar91x2gHotU+mfY883BY8xsA92PLfF9agEc9fsXObqfxJO2Bn6YOs/RWNk
         L69q8MjA8c3S/WlxEfbAo0xeTXcKfhNXa7LFfCW4ze9kwkKsJ3kIaFGXavEZyKVXK/gu
         6XorRaniWOOkQU5iE9K9wUoVjth/v+0VmNZEcbqSTopz2b/JRx4jtp3pZoVi+/e68MTo
         D4+Hif4FbhZj1T/Q2nSJJfxB7O6ewMR024Y8NuDsAZfZ2XJaYHWv6BsJwbJR12bqZ/0k
         RaOA==
X-Gm-Message-State: AOAM533jmwJxOTgln0w6Sd0hWFZLOgI4RV4B6zPbghBwomw+0joAwnzS
        T/KlDTF3gJmU57DNcqh0KaIAzHXO1GE=
X-Google-Smtp-Source: ABdhPJxF7/NwuDIm4vMmlvGOsBxo1NphjlsPc795JItWATM/HSc7kUN6r0FQhOg/kMyO6wwYCf2Png==
X-Received: by 2002:a17:906:6545:: with SMTP id u5mr633360ejn.346.1603123959727;
        Mon, 19 Oct 2020 09:12:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 06/12] builtin: __sync_synchronize() too is variadic
Date:   Mon, 19 Oct 2020 18:12:20 +0200
Message-Id: <20201019161226.97429-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This builtin was marked as taking no argument but is in fact
variadic (like all the __sync_* builtins).

Fix this by marking it as being variadic.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin.c b/builtin.c
index 7ff1071d721d..5477eb64aa95 100644
--- a/builtin.c
+++ b/builtin.c
@@ -641,7 +641,7 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__sync_nand_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_or_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_sub_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
-	{ "__sync_synchronize", &void_ctype, 0 },
+	{ "__sync_synchronize", &void_ctype, 1 },
 	{ "__sync_val_compare_and_swap", NULL, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op },
 	{ "__sync_xor_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 
-- 
2.28.0

