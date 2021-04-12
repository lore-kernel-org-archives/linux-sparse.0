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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DABC433B4
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4395A6135C
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbhDLVVl (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbhDLVVk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A60C061574
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u21so22571932ejo.13
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1CyvQ3rcA3EwKZ3tbg1dtAI0Np9tyHVPkeNJqPwGVU=;
        b=BzbNi0EnHya8fd592cvfB02nNIXKteBsa15WcAk09v1pqQKWeU/Yobe7HSFfn6g/xl
         6PPwOT2BXgH878Bs5yjBOIIbNSOGPd9mN98OgT6iTxkWCWevICsIGddeVJiyrMWjaS5q
         vesaHdXQl9rZnOTDpqY15w9067h24tm7iLDVnOjaDnGZPwv+IrjGJDyGimc5hXrycs04
         q+JlEUTZJ+ks/PN9SD98//4R7fdMjlGX5cuYojIEdH5XQRys71RKq4CeUS5s47KciycN
         m+EdQeH9DqoZUzos8L5fQQZc3TtGLB2LDWHU9skjM88KVH97QVn5ViwBRc411xOLJ/0c
         NbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1CyvQ3rcA3EwKZ3tbg1dtAI0Np9tyHVPkeNJqPwGVU=;
        b=M5mhU3qfnL7bzD2SdQDoHOzukNVEozKqjsZ16LLFS+Tbv4NdHaIow4z5GJUCEPrDZx
         jMydKcwy0nCQ/+ZrogZcb5+8NPqmhocZnd84a5D4h6e1t/VU4oMETiaUbXSFRPzR2/fq
         m4Hs8cberrauit5aNgjO9S0QmqdxaLrHVk91QKKDihK3Xmaiv9s3vKfH4vSX5CPsZcBq
         j4SZcsddisaxr1TaFBv7/v7uzMgklj4PHl7vO72Y4lqyXRouO1sr7xMg+O/3qdkbP99z
         Q+zV+TPtmiQCIA4mWi7io+qf5RdCZS6aNIgPady5jMZQzJJm06/FOfPXc4hOQ7ll37Nj
         VwAw==
X-Gm-Message-State: AOAM530czNxu5CeM6yukp8wJPAqpySXMx1Rk6tz5Tnj7ECQJpp3YsUR8
        o9kyng2Uw7lqtzVizQc1CG22rFGg+es=
X-Google-Smtp-Source: ABdhPJzw9ZID3oW31o4aUAN5CF5sI3vSz4/L8yEaRPoxURg6STMcPLBYwz3HGiEUAVdZzhoQiUNNpw==
X-Received: by 2002:a17:906:aad9:: with SMTP id kt25mr28461857ejb.364.1618262480939;
        Mon, 12 Apr 2021 14:21:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6903:692b:54da:df0c])
        by smtp.gmail.com with ESMTPSA id g11sm7744156edt.35.2021.04.12.14.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:20 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/8] export declare_builtins()
Date:   Mon, 12 Apr 2021 23:21:04 +0200
Message-Id: <20210412212111.29186-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Make declare_builtins() extern so that it can be used from other files.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 2 +-
 builtin.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin.c b/builtin.c
index c7e7da3b1b7b..ff03dbab9a06 100644
--- a/builtin.c
+++ b/builtin.c
@@ -559,7 +559,7 @@ static void declare_builtin(int stream, const struct builtin_fn *entry)
 	}
 }
 
-static void declare_builtins(int stream, const struct builtin_fn tbl[])
+void declare_builtins(int stream, const struct builtin_fn tbl[])
 {
 	if (!tbl)
 		return;
diff --git a/builtin.h b/builtin.h
index d0d3fd2ccf87..9cb6728444fe 100644
--- a/builtin.h
+++ b/builtin.h
@@ -12,4 +12,6 @@ struct builtin_fn {
 	struct symbol_op *op;
 };
 
+void declare_builtins(int stream, const struct builtin_fn tbl[]);
+
 #endif
-- 
2.31.1

