Return-Path: <SRS0=rhKz=BZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA4C433E1
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0262053B
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBf/q0el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgHOWFP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgHOVuw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:52 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4D0C02B8FA
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 06:45:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p24so12762142ejf.13
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xm9KYEgJXBX6qkTAXai8Xg2/NW/IG+mOqmP9e7f4ZBY=;
        b=VBf/q0elN4xW+AHN0Via07zUxPPuet7N4pjFNTQcwbNf+OMZGap6k1gWe+JLuq8F+S
         Vun33/s7WY7wS9VU2o9gRpkH0aXHODHsffHLmmKaMYXshMr0CYxAtJopqG2i7p52W3l4
         OQ5F+0qOjmo+TxdUZw2R0V3ynjYIIJ/NBQUS6fACCJe23HnSrxeCM8jJZqEosUzq2bPD
         lSNAu5ecfKjaDb5uizjcb/hTbR7HjBXIpjYQFZ/zD+5BxvYxUkRMzkxakiNSi967sQf9
         SKWguRvwQ7BZ9PVtFg3dG0Xh6rUDYwIGtBrIcshr3HGxhGqMFiTXoIwOf0xtkNLws64Y
         Y6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xm9KYEgJXBX6qkTAXai8Xg2/NW/IG+mOqmP9e7f4ZBY=;
        b=gj3usCzOAz0UkkuRIjVoPQbQ6DEZ4BHk18eNQLuOd72rTIGcN6l5MSVGndfVdQkx62
         V49HQnPoYC+/+/WT+BIeftpPGfwznsl2HvaLQq719T0sFYI++lR1Vd/XLfNe1emQ+5j4
         dFL+JBIClb8wqrpZDuXFSR+0muvKZW2njNesfeGlNF9HXn0JwLK26Lz+wK/IQY3oZ6Fc
         wHZIfb4Ha4eA0p1DMIqD6XkgpGnsOP0DzPr2D0jY5L/STHzWrabU8EY74M4F0dQhW8TQ
         MTumWlvytST+F7ewlB90C9E+OlklTXw5V26cDDzIKJOwyGx8fYfUgAlBFz6b5Wkcr56E
         +stA==
X-Gm-Message-State: AOAM532egbgyAhh4z1kd285ULW4rAI7U1dnSiyzs6ueXogznYvoJMCuF
        eFMaKJpKDgH5M/iUEmOWyGHnvr8crxQ=
X-Google-Smtp-Source: ABdhPJy15VP+F43sHgmI3qIjQTtccKx39JcEeMAoQmYt2MzkCDKWYAqpVfOimC8ElqxGFCErlRAlRQ==
X-Received: by 2002:a17:906:54d3:: with SMTP id c19mr7427440ejp.408.1597499117143;
        Sat, 15 Aug 2020 06:45:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:818c:70d:debe:a811])
        by smtp.gmail.com with ESMTPSA id e14sm8993905edl.86.2020.08.15.06.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 06:45:16 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cleanup: remove unneeded predeclaration of evaluate_cast()
Date:   Sat, 15 Aug 2020 15:45:11 +0200
Message-Id: <20200815134511.98842-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

evaluate_cast() is predeclared in the middle of the file but
is not used before it's defined.

So, remove this unneeded predeclaration.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 63a9390b5ee7..447020aa7fe4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2198,8 +2198,6 @@ static int is_promoted(struct expression *expr)
 }
 
 
-static struct symbol *evaluate_cast(struct expression *);
-
 static struct symbol *evaluate_type_information(struct expression *expr)
 {
 	struct symbol *sym = expr->cast_type;
-- 
2.28.0

