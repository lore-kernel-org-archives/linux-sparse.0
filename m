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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C51C47420
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A8E2076A
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3zRqG/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgI3XSo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732169AbgI3XSj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DDDC061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so1081717wmd.5
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjso956F3U82lCvbV8gzVlNNJET9eKYzhAlPBp9cTjw=;
        b=D3zRqG/L+xfVCzOFZ2ogl25sfzXYXIuOaSXOtc9VIBvik8M3LOv34A0imEI5HWF2fv
         SOE2j4y6Li7dHxbJfckktV/+6jhkAODLixcT7Jz61zckaQhJvIgOg2AAROQMu511Pfo/
         e5R1hd3iLzHCqHq+Zgc4d8Q0zlKDmNB+4QIQfjt2HKiQdISW4WqnOBYOOyHz87xGk5kn
         4plCJkROsa3vv2SdhFw1f9wxwZM8QxK/rIzVA3ee2791kbIpe1ifDtuCOgtDCj7gkNCL
         /Gf3TKfH/ZK4fzYO2mBuY/fv4EJymKGig6xCuZDZzycrZ9g7J/w3FHV7wP6pfzZ7F4cp
         MGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjso956F3U82lCvbV8gzVlNNJET9eKYzhAlPBp9cTjw=;
        b=s3/I+p+DlefnANxZC5MQQVWE+LuDHm8cPD2OCD0b+tV47av3p9Zh6HN51KF1lX7QF5
         ywCVssQIxSFlJIRwDTr7LZ491aAsuJfaqNc8jqo9YffHHAw7xSXthnKyLBDgdlIb2vRt
         H/z9Bwkw1roqvssn9KKxvzUhZ0vaF1/k/Dne15AqJi21PzQvzFrmAXBiJosibyZ0BWV0
         m+FSgFF0+RK/13+MQ72B2uGfnCtziOIfVhHMgy9vAC8Q1kpGwGI0lj1W8qEilVHWjvip
         LR1BpUR4qWZk7ThbP5i0k34zPiirYKgYapzdTYy61U+Dd7lGRPuQQLHmhuOjdbP8h/3L
         uviw==
X-Gm-Message-State: AOAM5323FstF8ebLPKevrcS5xkogDk9jYxAdps8mzOThwJGAxokHZNaK
        nWtM13RPL90lkN98kDjdPfTxEbkhwNs=
X-Google-Smtp-Source: ABdhPJzVroMM8rgArVLXilGqFpO28RY2Nrgzixdxo42uc3uqEaxKOKGMDjMmJZE2yz5v9f7tyvehOA==
X-Received: by 2002:a1c:35c1:: with SMTP id c184mr5285857wma.161.1601507917737;
        Wed, 30 Sep 2020 16:18:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:37 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/13] flex-array: detect structures with a flexible array member
Date:   Thu,  1 Oct 2020 01:18:20 +0200
Message-Id: <20200930231828.66751-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is a preparatory step for doing the checks and warnings.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/symbol.c b/symbol.c
index 9acffeea7fad..6633e89de4a9 100644
--- a/symbol.c
+++ b/symbol.c
@@ -87,6 +87,7 @@ struct struct_union_info {
 	unsigned long max_align;
 	unsigned long bit_size;
 	int align_size;
+	struct symbol *flex_array;
 };
 
 /*
@@ -128,6 +129,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 		if (!is_array_type(sym))
 			return;
 		base_size = 0;
+		info->flex_array = sym;
 	}
 
 	align_bit_mask = bytes_to_bits(sym->ctype.alignment) - 1;
-- 
2.28.0

