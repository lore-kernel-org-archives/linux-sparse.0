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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B68C4741F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C672075F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt/547lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgI3XSo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbgI3XSk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA328C061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x23so1094675wmi.3
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpPjPLvLkMQo3d30mXkfg7bcBPKMGRWxEg96TVxlw58=;
        b=Lt/547luXqfB9/Jm9jvWPq/AbMSDhv55kUlX8NIAMvlBD7Jw853Ai33QVOpoczTJ/0
         hxfD+pLaY3SXP1ozGh7nalVVL51D/5vWSwOGQ9dy8Kkmou60DQII0F1vh0Pg+7Nnv3ar
         prP2CxojKqSbA3IDnZaaNaiDCmhqIYdL2pE1f3dDBPgeH6VqyTvWa1cF7XOduY+5JQbh
         rPYaeRKVRQ6yOdzQv0pqnKWCQi/XVM0Wlq1oGg4kTBaNDsYwR9DkreRK/5YAqM2LIwMG
         M4cVpO8RoHcJh8z2r9lhOqZW+lXlC00QQ8Gh8BtolJM70wzgI2eVMDfmkDWxR44H+zy3
         LvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpPjPLvLkMQo3d30mXkfg7bcBPKMGRWxEg96TVxlw58=;
        b=mLKIawvYrEseH6YsX7dlcV2q0A6Wt+XHQZbls3nyI2DvSVbGbAlMkTlz4I31/uy3wd
         POcwBK38EDXNScwVE2sCGdgysDx3cLEzGzqxVFZ7DMX261Gz4qYOGquItjGYalyf4CQs
         qc82jFiJdNqPFmKGXEZJ7e6oud4aqrPIyvwtpeQ/FKVVRrnuZ2zlyQHBDTZUcchE+t3R
         +LJMX/mrCPBQ7dX4JQSWjWxlFE0eItzDH3F7MKYCMDpG4OO1MpW5q4uzi+9hmmRbTGVi
         JRQEGA8AcUfpMRlFKSAHMC1AU9pUMJ47Z0bBHB+MAWdvuyGGnxDK21hX6uhc0gaENWl5
         je2A==
X-Gm-Message-State: AOAM531OvmLOT4ZnmqeX4+XDIsECu+P8vbAfi3Rp/mKH2QvRjyEj+sBN
        F+n8dl/lG2xiJNAueTIxst1PYlQ6RqU=
X-Google-Smtp-Source: ABdhPJxRdLlQkkpeGGWJN3p8psCoZ/6+FzBallW2fTBilf7KY9xWzjoFsG1H5HHEqjmRZQ0Rb0/bWA==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr5027956wml.147.1601507918502;
        Wed, 30 Sep 2020 16:18:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/13] flex-array: warn on flexible arrays in unions
Date:   Thu,  1 Oct 2020 01:18:21 +0200
Message-Id: <20200930231828.66751-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Flexible array members are not allowed in unions.
So, warn if one is present.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/symbol.c b/symbol.c
index 6633e89de4a9..e578b1a840a3 100644
--- a/symbol.c
+++ b/symbol.c
@@ -95,6 +95,9 @@ struct struct_union_info {
  */
 static void lay_out_union(struct symbol *sym, struct struct_union_info *info)
 {
+	if (sym->bit_size < 0 && is_array_type(sym))
+		sparse_error(sym->pos, "flexible array member '%s' in a union", show_ident(sym->ident));
+
 	if (sym->bit_size > info->bit_size)
 		info->bit_size = sym->bit_size;
 
-- 
2.28.0

