Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D36C5DF9D
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8238206B5
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL93C50U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbgJWQjt (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbgJWQjt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B9AC0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ce10so3243627ejc.5
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrmJwZ7vwOVEFFus+2k4PeGjuYRscMVXc0R45L9gDs4=;
        b=IL93C50U+b9Kdy97PiSQwZq7yqXEiHNtA9eTU0mHA1KMplFeKDzFDpf3qfzCyvykvm
         Z3LYrZXO9qQBqZGsBGOdnZs5aeP0EJTPUygRe330ScKfMj7F6oHvCeOGtLQ2X0Tuhl+3
         pLZWNWzkSzwwNmISwgd7JEBrCm0QJWegv2G9AHJ4gviyjQ9aivPqwli6Hj4kg5FLldNS
         axXlNbFrF4P0hvHGDTVUVm7tTAl8mR/Fo8gzDpWnmQvIbA6+pCSTuAEPwM1cdEA4i+dB
         Fa23DA0h+Bq8q/B3dNgR14IzbC+9kOhUQ9I8UvkTvwqNs+TAdXxZMkl1S/NJtWgSUV7s
         OZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrmJwZ7vwOVEFFus+2k4PeGjuYRscMVXc0R45L9gDs4=;
        b=LSlrS3BgSlHo/eonKsRAEazrt6BvwVD08lpxR1nFTulAZ0EMx5j8wK7OdGCD0tTY85
         0lRb5xzabkBx/h6sgaxE0qU8rX3SxIirqyPAK5n7XrwOMsbcUhdP5fGeN4CUhsbHGnzL
         AjP5n4mmDgLQGz14+vPYTb6kvUiiLKGxdjMJ6Aed9ttWqP+So7EMVztVn2nVh4EjT0y1
         4n4NhNAx8BGDxsdtyzEcgQwngLk6c+51BPKeqF7yGrbyhxYcYfDuYwe9IBDBj87Sai+c
         9WnYdK9+r2k9D2nrIbB4TmNiJZ/S37C9GVZeh/b0PNDmVDjoj3dx/puE6qbHsEI5goUN
         Z01w==
X-Gm-Message-State: AOAM530S4YUGCz8LGM5OCEUEcYAbRYkZvyZq96E1o4RLo07X+VXy7faj
        PazKfJHBYbts8bFGAJDmg7IYpwf5KpY=
X-Google-Smtp-Source: ABdhPJyXmCKEVwG1BQq8DzTvNSq5CRSvN+5XBgJqc7HKqJNr/JUyOJTWjifuslDfMDvk55mknDQ0gA==
X-Received: by 2002:a17:906:7696:: with SMTP id o22mr2013222ejm.269.1603471187297;
        Fri, 23 Oct 2020 09:39:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:46 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] unop: simplify -(~x) --> x + 1
Date:   Fri, 23 Oct 2020 18:39:35 +0200
Message-Id: <20201023163939.58359-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
References: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 4 ++++
 validation/optim/simplify-neg-not.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index fd486172e6e8..8f6b821dcf8c 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1478,6 +1478,10 @@ static int simplify_unop(struct instruction *insn)
 			return replace_pseudo(insn, &insn->src1, src);
 		case OP_NEG:		// -(-x) --> x
 			return replace_with_pseudo(insn, def->src);
+		case OP_NOT:
+			insn->opcode = OP_ADD;	// -(~x) --> x + 1
+			insn->src2 = value_pseudo(1);
+			return replace_pseudo(insn, &insn->src1, def->src);
 		case OP_SUB:		// -(x - y) --> y - x
 			insn->opcode = OP_SUB;
 			use_pseudo(insn, def->src1, &insn->src2);
diff --git a/validation/optim/simplify-neg-not.c b/validation/optim/simplify-neg-not.c
index 4bd0abfb0628..e92352cfeeec 100644
--- a/validation/optim/simplify-neg-not.c
+++ b/validation/optim/simplify-neg-not.c
@@ -3,7 +3,6 @@ int foo(int x) { return -(~x) == x + 1; }
 /*
  * check-name: simplify-neg-not
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$1
-- 
2.28.0

