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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8819C47429
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919C22076A
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx/k+gbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgI3XSo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbgI3XSi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6D3C061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so3542229wrn.10
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFQL3i9zVNObV8k0iWLnJ89/KEx2uauUzxx+FFe+hXs=;
        b=Bx/k+gbKuKN47gLJlE3PyXYwSVKakXUsYE95eG3pb2pp41w287XbaEWwldfvG9Rq4B
         MA4i2tUiu5I/ZK0Hesz2Aqu8VXhRmsIX4btvyVPzHo4eAUckOxXZa/kpoSpPT6k22hWi
         0RiRFEbbKrG/+B/3JkMJBNI0/UcBvTvYNUmjMdwlBiJnx9d0MKo6V2LOTnFtwYMI4IKN
         knDDOpR8vhd3yQKPkN5cmfe+eLxj4aEgqXvq43NEdbM+BrLm6itkTVNaUs5E8o5Jz7LD
         arQCvP8nfunTJOrXOVhiD/D/uyew8dDqndNY5K+Y0uqzWXd/qc/emCHW+6AVL0/aZz79
         QrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFQL3i9zVNObV8k0iWLnJ89/KEx2uauUzxx+FFe+hXs=;
        b=Vy5Tbj3TDrZdEJh6SF6OBBfcZEkQxDZDejk4Oftvm9s0nsgf1gS4K/QUtlfE6sPBuc
         IGcXf2L2WL3peCvhgurnVobXTvPp1l428zPw9PtTlVhO1PTAkKDeEkwD2f0mtJACB31y
         PjLqkgM79/mSPZE7meU6nSvHY0c5m+/K2PtHS4h+R8yrw8I/vnycb3CoxJPZbx2a9E6h
         qt1qsTqq2lB6inPa/GgSvlK9xT4dTEjExcLomyWHH1fnmqjMQTZdAIBIbdTA9qHeW1rr
         tJtoccVe37AbE/ZUPVXm6BDviPF2v//YlIV3c0CZZXbt/X+E2/x9aQhbgKLToS5TUnrT
         86bA==
X-Gm-Message-State: AOAM531bEn8IshKNPyrTngMw4YPsNmz/k192G9BqCSv+Q9qEIzkLn48R
        2Fdz+4mPrBG7xGUpxQgotrWwcSlmDW8=
X-Google-Smtp-Source: ABdhPJyv40LxhvPOWtffzCYMHw2r4m9TufS1gmtVQLz4DpJicKc3E4/cc2I/Ks4SHEm6KNuKI2WfRQ==
X-Received: by 2002:adf:f88b:: with SMTP id u11mr5297252wrp.376.1601507916998;
        Wed, 30 Sep 2020 16:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:36 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/13] flex-array: flexible array members have zero size and alignment is OK
Date:   Thu,  1 Oct 2020 01:18:19 +0200
Message-Id: <20200930231828.66751-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When doing the layout of structures, flexible arrays used to
not align the resulting structure size.

However, the standard specify that while for most purposes
flexible arrays can be handled as if not present, they still
may add some trailing padding (cfr. C11's 6.7.2.1p18).

So, there is no reason to reset the alignment.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c                      | 1 -
 validation/flex-array-align.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/symbol.c b/symbol.c
index 4c93a0fb4880..9acffeea7fad 100644
--- a/symbol.c
+++ b/symbol.c
@@ -127,7 +127,6 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 	if (base_size < 0) {
 		if (!is_array_type(sym))
 			return;
-		info->align_size = 0;
 		base_size = 0;
 	}
 
diff --git a/validation/flex-array-align.c b/validation/flex-array-align.c
index 0cc67ab36997..9f28942a1ee1 100644
--- a/validation/flex-array-align.c
+++ b/validation/flex-array-align.c
@@ -12,7 +12,6 @@ static int foo(struct s *s)
 /*
  * check-name: flex-array-align
  * check-command: test-linearize -Wno-flexible-array-sizeof $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$0x80006
-- 
2.28.0

