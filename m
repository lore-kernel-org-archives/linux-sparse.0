Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DAFC388F2
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91501222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7Wfz3DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438668AbgJTVKh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438663AbgJTVKe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:34 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989B9C0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:34 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id v19so170867edx.9
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJtWYwTJqDaS8m6q91fqVTWHCO0pCI93o75eNtQni0A=;
        b=A7Wfz3DHRQTzSR1reVV9obx4SR+9lMNsJ9kMXXPENOJkI7hjK8E0F6JQhZZC5aDLRz
         8K6DJXPvBLnrvfw1aSQ60vFD56J6P7yt8taYvbvbVdgLpUKzsXxdr+Z2XKO0U3iy3Ff5
         RrD9vGfdZXP+YpwsH1JAhLmu+gaD7Xa7KmboOT5Wgv55NMf+TykCVEvfm/ZY3A/5ofIR
         zmwj568/fAM4NaOhMyGW890iNhw9CFeSRIEk0FOt7Ujp7N0pbn9iDJ67kzsTufae261S
         SoqUVQK+VAVLo6FZ0ie2oo2qtZtIljJvi6Hfsm/VdLg1xDNQ9REshBWo1OSQKu5BUait
         2KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJtWYwTJqDaS8m6q91fqVTWHCO0pCI93o75eNtQni0A=;
        b=QAOnbDkFO5O9S7dLRR4arxCTvr38TXnKVdcY8MTa69KoeeqQqNOsbzXPBheswoJXVp
         2AlLIUTEA+XTjvS7/nl+CtaAjbUXSuvrNcg9Vl91dDsl4Kvg7WQ8wk8EPBKqH57Wuupf
         51wE4GMv2UOO56z4P2JG9hTTXX2rx7cPxQ3KkM60N1jCy1CofIfj2/b/LIGyL/brvNr6
         Lwpdld4h2wLloO0eohFbzLIdrM6SFAYquttqH8lgDveP7tbM/Lmspu9S+LBWXBjIb6k1
         VviZWeTQ0gMIV5ZKpvHHqg8I4E/PZLSek9H+Fw1p67C2i6w2pAE5gJ0OxaxOS0sykoeE
         8l+A==
X-Gm-Message-State: AOAM531uKLpPqQKCAqIgKVJC7lIpZ/atZnTstrZBAFKXU40AuypMmLvl
        BnxcaWBJIVz3peGn1pcAzWwRBS9w/yw=
X-Google-Smtp-Source: ABdhPJzRKkiiIblClOIuEZQMjwB3sLh70Dl8Tp6tlmj5WhGVZpUeZk1o4BmDPA8yeI5Rs7l6Whj2Rw==
X-Received: by 2002:aa7:d7d9:: with SMTP id e25mr4784236eds.253.1603228233065;
        Tue, 20 Oct 2020 14:10:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:32 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/22] sub: canonicalize (0 - x) into -x
Date:   Tue, 20 Oct 2020 23:10:09 +0200
Message-Id: <20201020211021.82394-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Not really a simplification in itself but it make some other
simplification a little easier (already because there is one
argument less to be matched).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                           | 4 ++++
 validation/optim/simplify-zero-sub.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index f837b003efd4..aa0357d9e285 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1174,6 +1174,10 @@ static int simplify_constant_leftside(struct instruction *insn)
 		if (!value)
 			return replace_with_pseudo(insn, insn->src1);
 		return 0;
+	case OP_SUB:
+		if (!value)			// (0 - x) --> -x
+			return replace_with_unop(insn, OP_NEG, insn->src2);
+		break;
 	}
 	return 0;
 }
diff --git a/validation/optim/simplify-zero-sub.c b/validation/optim/simplify-zero-sub.c
index cc8fe7a3159b..70ce7c908844 100644
--- a/validation/optim/simplify-zero-sub.c
+++ b/validation/optim/simplify-zero-sub.c
@@ -3,7 +3,6 @@ int zero_sub(int x) { return 0 - x; }
 /*
  * check-name: simplify-zero-sub
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: neg\\..* %arg1
-- 
2.28.0

