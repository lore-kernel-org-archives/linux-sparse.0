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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC79C5519F
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 22:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81090246DC
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 22:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHllwfNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKRWq0 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 17:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgKRWq0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 17:46:26 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C3C0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 14:46:26 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id oq3so5081424ejb.7
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 14:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfjBWVkTUsSBLBxac6eyV/x+VRhfyMqnrTJrrG1HdR8=;
        b=oHllwfNsMF18T/3zy9kQrgTw0gepYmq4YrWNXgfdqyhsOMjH1xKCrLX4ZkP8D8OHLK
         9++X+Sa+ylEY/R0X6yft1Kvf1WRYxaAeMNWCb4J56P4ApD/5oh6GK1SrTMPzTn+GsWmS
         17W8aKJdZeFUfv1yE5VmURz91b7PYVZCW4pAtZPnI8dANOgWdkpXTu4Oku3hq7rWMAfy
         SwktpZxb2SzCUS9fMyyKA/vSkpOdxM67QhWSKYPFXzjUUzG55yE0aVvLZajVj/c6fJTe
         TKtViDf4hhV1ZWFXCE6kEsFL8Qxs2sQWDSG3nhFJbgWApph95YwcOijmRMAsws4gF32l
         coeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfjBWVkTUsSBLBxac6eyV/x+VRhfyMqnrTJrrG1HdR8=;
        b=Y/64zl4lvtaiJzYXSCuJGK09p9V6DuD3xNOTLdw6ThJc4jD3bssXt39KGkp6kqUL6d
         rGkOks2JvKiBTBVi6HH2O7lfON5H9//uUO5Iqv/6OxSidq/huBBkbPW7vTBLf+3BA+hs
         PmzRvlIrle51vDZS+lQhQ/wfM6pqN/dO/t7auER2rFOmX57uEZHgzMAqzcVDKPPmdPjm
         aWRqqCFEfkq+1xhFv3E5fuq1ZfedmzhfHljSzkQEA8xDiO3q9Hhf1xGolalNJ40rXBhL
         +jN67IZbjF66FpdPxgR7qz3Ky1aZ4tXckjEUH7ecNvFV17bEtUq0nnNgF2ItEllXP4k7
         wP8w==
X-Gm-Message-State: AOAM5325uba+x2/imlmCB0zo0mYZ/BkPnhVQn6kyiJHZ9RQ6A65Taq2L
        +HdfG/xnPooBN2n32se4VP1tJ7J7qW4=
X-Google-Smtp-Source: ABdhPJzTARUeHwvJg/kIhugZ8zB1+wgTlqZPXIF2if3sLrK5mijK5PF7ZdBTZmoNHj5tIugA1H7Lqg==
X-Received: by 2002:a17:906:7043:: with SMTP id r3mr25071383ejj.287.1605739584869;
        Wed, 18 Nov 2020 14:46:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:491a:3e51:301b:6e24])
        by smtp.gmail.com with ESMTPSA id hj13sm13666760ejb.125.2020.11.18.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 14:46:24 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] simplify unrestricted postop
Date:   Wed, 18 Nov 2020 23:46:20 +0100
Message-Id: <20201118224620.11674-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The '++' and '--' operator used in evaluate_postop() are
'restricted' operators. It's thus unneeded to call restricted_unop()
on them as it will always return '1'.

It's also unneeded to test for TYPE_RESTRICT since it will also bes
tested in unrestrict().

So, simply call unrestrict() unconditionally.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index c39f9ec73da9..3567f702b8ac 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1919,8 +1919,7 @@ static struct symbol *evaluate_postop(struct expression *expr)
 		return NULL;
 	}
 
-	if ((class & TYPE_RESTRICT) && restricted_unop(expr->op, &ctype))
-		unrestrict(expr, class, &ctype);
+	unrestrict(expr, class, &ctype);
 
 	if (class & TYPE_NUM) {
 		multiply = 1;
-- 
2.29.2

