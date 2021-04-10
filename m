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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A4EC433B4
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63AE61028
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhDJNbI (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhDJNbI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 09:31:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E3C061762
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hq27so12888270ejc.9
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1CyvQ3rcA3EwKZ3tbg1dtAI0Np9tyHVPkeNJqPwGVU=;
        b=B9fF6SOWTLKc84Pzhcld1RK8KvZI/Ie7L6KJto5RiV/qAKsWH/Q31CqHNeP30OQBw3
         Gv4JU9Hf7zvZ/oGlYhU/rpzyzkLGJvZFegV2PNnpdtsRbxlO7h9BdtFqhZPVw4Pw0Fid
         tYKqXt5i7MoMz71TwUZthtAJzqzagDVGwy9q2DdQ2FcKAQEB7JOTrHEKVS9uoksdoWCL
         JXu0FtYtN1GX9fbXY2A5avAUU3dPlFlK3tAOmJNon2OgUBOV+1K/iLiUH79ufsOnsiRT
         evolouEDKfz5kf8F7nNr2tItHBAhndmMo3m46jE9TdRheRO2RoJxGw2RajXr/cmtJ1qK
         6ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1CyvQ3rcA3EwKZ3tbg1dtAI0Np9tyHVPkeNJqPwGVU=;
        b=bJf30xQ4UPeZgKmlDDWwwd6sT39dODl0iesYPutKYrO5TE6GGESzpkcfJqGi5AIjN8
         aR+Zn4WOy3+z2RGYggaa2Cq6qQXjfeqPuiyQNKttXUKlv7RuFjrTHFRy/kP5Z6P1MgGG
         ZsL21Z2tndhq4Q+n0zBhNGqorSIIVyAixyltVP0gulxt0+cUMZPkrK1C+cNxr/VN+c33
         j6wuDbOlSe0bQP8IjIOlfs2UbQJvyc6p1AvpDbaoOpbnsW0xl6F5etQ7GMqP690hZqQS
         OZ9313hOhqD/weSVymHyknfuf1+8cBNjUuv3X39S3JWmUYI7VfD+AvnQHtBuPaB4/Wix
         zjbA==
X-Gm-Message-State: AOAM530HOiQq4aq3B7tLQvjD+xXDVwcw08eT6OZ6+0N4a7YkSHKfARMd
        gLrSMIe1L+srY95b8ZAkC9MAIeYRlBs=
X-Google-Smtp-Source: ABdhPJzYAEDvz1aEOxqJsylExaEFAAlheQzj7LE9rz7mmv/cZ1MuCj/fieh64qa5g9fvlDw3xo8Hfw==
X-Received: by 2002:a17:906:6683:: with SMTP id z3mr20289630ejo.390.1618061452244;
        Sat, 10 Apr 2021 06:30:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f96a:804d:4fe5:372f])
        by smtp.gmail.com with ESMTPSA id g26sm2594910ejz.70.2021.04.10.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:30:51 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/8] export declare_builtins()
Date:   Sat, 10 Apr 2021 15:30:38 +0200
Message-Id: <20210410133045.53189-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
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

