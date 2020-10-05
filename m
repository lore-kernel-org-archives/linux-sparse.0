Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3193C4363C
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAB82073A
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmBpanVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgJECAP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgJECAO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 22:00:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F171C0613CE
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 19:00:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o5so7701027wrn.13
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 19:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+9lZLwYpN0V305kUch8/+ndJnDuSCSGvACGMwx84qc=;
        b=kmBpanVUrQZWCKahOZ1k3Y0g9F8T2hVJMZiP7z7Pi5GiiAMgBdlRlF6YHY7WZ/vnVN
         0VY4xHnUCKlo5RxO6q4x4/kisfNcGz3+3QFwKD0lRF62PtFDK/xfzDVZW7F45oOihATf
         NQljLBo3KS90GXwIa/yJqkACqO+wDHUJ7jw5n2yRARWQwk7eRqxRxwgr86NVStfbENFR
         eZS7j4/DsC4XyCRX6veC0KAm+z5kwhUlgS0WekSNO7j6WnuwWHnwISuKKeazyinGyDit
         xCwCuuZR/K8Eq7u3aar007Cvlv7iO3g3zFw1vkWrAEd9XWRD+8M5+aCUTuhCJ3O/JdsN
         sDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+9lZLwYpN0V305kUch8/+ndJnDuSCSGvACGMwx84qc=;
        b=EXD8EURaurKWvHTnu/2h4PoyY3LKFSWJk5zE3Qf5GLuNlt8STskiydtsDGmJOKB/6k
         40bW9S/2WfwlvG4jN0DgKlJIstaP9d4Lbke8FWLZ2voSBBe3PGo3x50Vk3hGviCDeh9u
         ri8nCm5b0ZzgUB46/Gr9uPs8QnoNT4SlhCA455cCQBsvMylC2TeYjN/lsKutKAQW/bfT
         W+4czkNezlQv/Esl8uxSAsj6vbNuICvukw8g0yc+PR4wRccBdv78T9jdYIaf5R7kFvcJ
         fGTf8Aj6SQcZk7a1eHgUCh6VmLJ9Tp2bl01+VpsrDK9GFTMxt8WXwh7kcfYSsZrdm+4r
         c2oQ==
X-Gm-Message-State: AOAM533K1QRxAlwRDke12HNkywDLcOnlvd3iC3S0IRt4w+VzXuifzwMs
        +VyssknwP3hHweIS5rVAT2AsgpZDfsQ=
X-Google-Smtp-Source: ABdhPJxZa0JVlA/lP1T2CkgGo6L37TR0M8d1vWFSB/TDnFWeqbFzVCjhSkkxFGdlVM3EUcLVL/RNWg==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr148002wrs.127.1601863211877;
        Sun, 04 Oct 2020 19:00:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id b189sm5541132wmb.37.2020.10.04.19.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:00:11 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/8] call verify_format_attribute() unconditionally
Date:   Mon,  5 Oct 2020 03:59:59 +0200
Message-Id: <20201005020002.1108-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c      | 4 +---
 verify-format.c | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index fb3c0adb2220..35ced8cb6fb5 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2388,9 +2388,7 @@ int evaluate_arguments(struct symbol *fn, struct symbol_list *argtypes,
 	} END_FOR_EACH_PTR(expr);
 	FINISH_PTR_LIST(argtype);
 
-	if (fn && Wformat)
-		verify_format_attribute(fn, head);
-
+	verify_format_attribute(fn, head);
 	return 1;
 }
 
diff --git a/verify-format.c b/verify-format.c
index 939605f55ef5..2eaba6653686 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -452,6 +452,8 @@ void verify_format_attribute(struct symbol *fn, struct expression_list *args)
 	struct expression *init;
 	const char *fmt_string;
 
+	if (!fn || !Wformat)
+		return;
 	if (!fn->ctype.format.index)
 		return;
 
-- 
2.28.0

