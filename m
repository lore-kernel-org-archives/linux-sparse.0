Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E40BC4727F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99EC2075F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq1C3L1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbgI3XSn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732171AbgI3XSm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0298CC061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so3561820wrt.3
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B46//BeD53v0CzUMVYJoHKCEFQGG8ONWyP2hBCQWACE=;
        b=Aq1C3L1JGM+oHq/vOeE86PnVA3w0TYL4abUbf0ORWhxuKARU119cB1DaHSA/Jz23CE
         FKgQ7cSL6ZKTeEFmD8Ft9CM55wuvM3hhep799mCH8/WsvNIVsf1tDILLmSZas4XUbetR
         zTouDAmRXoyLjIsohYfOkW7KhT7ztCadr5f356njm7voQehH2Gl56ChYx8Eia7poL0NV
         uKqMDalbYNBEVbQuFDUhj0vWFgWpGxX894mKNJEFscYLBUDUEaQE97Y1LTW6u2/Cqkh7
         TqTiSmN/AhNxxOVwWwUTaMUedtTHwW/pYZNGyDFVGu4SgnXQ2fiP+rnOCvtS3tfP5E+I
         UYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B46//BeD53v0CzUMVYJoHKCEFQGG8ONWyP2hBCQWACE=;
        b=j67tUIkSVy1UvWpw2w83W9SD11r3HzYtUxvoz97JY4hl2MGnbTQk3mY1Npd0rqmn4a
         p26Ubs5bbxaPXKyGiWPSp+zNNjdi5b8xamV9BBnJ7GzPii5PO9JkVA5qCcYJFcwat5al
         KmkNJwHaWzzs8mrZtjD0+eDZ9/3Oz+wt1VbJGbVTkIcGnJIpDBSzlQbFrjvwGFebElaO
         2uWN+qyKTeo7qWak4ni5P894NOO8ePbtlBd6AOXXGouIVsz3zj+tv/IhiHWu1jud2yLo
         TyF0pq2UpJAQqMwDXEFVckKXRHFKZJlt0z/tocGiICBkwAa1SuPZvciJIc/cP+Bfb516
         0n5w==
X-Gm-Message-State: AOAM53018qps+8e554sldom4lykxdgWbNBQYNp13xq7/ny9+mLJ4ctAc
        U25pNWTOG53QpqRhy5n+BiNR/ezPRjU=
X-Google-Smtp-Source: ABdhPJyOgZgPQ9tpGGO4c/T3aKhMAXGVYE0QAb3f/CDsZ3Aib/Cv1NNkN4I7SRCIFFL9Fwfmq3C0cA==
X-Received: by 2002:a5d:4486:: with SMTP id j6mr5310387wrq.278.1601507919490;
        Wed, 30 Sep 2020 16:18:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/13] flex-array: warn if flexible array is not last
Date:   Thu,  1 Oct 2020 01:18:22 +0200
Message-Id: <20200930231828.66751-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Flexible array members must be the last in a structure.
Warn if it is not the case.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c                      | 2 ++
 validation/flex-array-error.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/symbol.c b/symbol.c
index e578b1a840a3..b4c5e471372b 100644
--- a/symbol.c
+++ b/symbol.c
@@ -186,6 +186,8 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 			sparse_error(member->pos, "member '%s' has __auto_type", show_ident(member->ident));
 			member->ctype.base_type = &incomplete_ctype;
 		}
+		if (info.flex_array)
+			sparse_error(info.flex_array->pos, "flexible array member '%s' is not last", show_ident(info.flex_array->ident));
 		examine_symbol_type(member);
 
 		if (member->ctype.alignment > info.max_align) {
diff --git a/validation/flex-array-error.c b/validation/flex-array-error.c
index 89601e42daf6..2b7e6953050c 100644
--- a/validation/flex-array-error.c
+++ b/validation/flex-array-error.c
@@ -18,7 +18,6 @@ static int foo(struct s *s, union u *u)
 
 /*
  * check-name: flex-array-error
- * check-known-to-fail
  *
  * check-error-start
 flex-array-error.c:3:14: error: flexible array member 'f' is not last
-- 
2.28.0

