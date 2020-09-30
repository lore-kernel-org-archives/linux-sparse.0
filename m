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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF99C47426
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218142075F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTgpRsmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbgI3XSo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbgI3XSi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C406DC0613D0
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k10so3556525wru.6
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ke5S1b+rZNOHOoWlqdl7RMz+CTpsSeIWhrOWtW03TZM=;
        b=GTgpRsmHFzvnSlvzKSCS1KP6NLIPV+2vN8GsjARJ46yZ+jFM8GyLYuLo7qLlvZyopk
         udKSFPcAt7zwiTM0tloPbfP/kFgrhtBFfOtccVl1HvUoDjseU8hTv/J8uWZfEto9/+19
         1t7K4XyMHRgHlbUxBstgOYm+iegc286DRIQZhUjYPRQ/N4OFAgAKeugTf3JoruNV01hI
         18vtQOWuQ1IYL3c6a6G2PgRrZBkB//hZpzbC1St7IDMJSVsbykiCma6vjIc4vJrMBtP/
         6HGc7/Ra0+qEtriFYEFCn9OSSEA5TI6UGD35eLMuzfBxJThBu6M4i54RNmwXkj7e446v
         5VYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ke5S1b+rZNOHOoWlqdl7RMz+CTpsSeIWhrOWtW03TZM=;
        b=TSc2joAelD1xlPOReEcTkykzM4XU4EGT6U34wR8V06skOjYDSNhMjOuKowbVEOWsLT
         WdRqORdJvKeJ4/eDdaDRBmrm0pV81bcPIdU8DLVtneIFlsqCZAfI0G30lx6PAxswa6W4
         aKsvLsDLdcLrKNSLnJdo04X6Jjm4i+FvJvo9Vkh0BxfeRiQelLepficACmdUfDcYyeZJ
         AfOhftSH5LYHBLoTefIsvOb/r/i9I4Uj6ndr9xx+YWXgsDjWFSrftVnCE9oLB6Qnj2dH
         QzaMCrf0hEf1ZNFEMP1JDfN3KKxANFyvn7k5dEwbj5efc86+OKrMqESg8AIaZ8wge2Cj
         xG4w==
X-Gm-Message-State: AOAM5334A1xDnwrI0fKu+5eS8NY0apJUBQGt5SVcFed3YmpmCeydtR8e
        shQJucxiINPdp14j1jq/mMw6GuaV+rE=
X-Google-Smtp-Source: ABdhPJzOKNjSJT7dSYekk6OfCpuiKwsCZPQYF5wARTSQseI6Qg+F9hZsAlKigCggAiZTOBVwXm6d3Q==
X-Received: by 2002:adf:df87:: with SMTP id z7mr5647077wrl.239.1601507916298;
        Wed, 30 Sep 2020 16:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/13] flex-array: do not lay out invalid struct members
Date:   Thu,  1 Oct 2020 01:18:18 +0200
Message-Id: <20200930231828.66751-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Do not bother trying to lay out invalid struct members,
ignore them as it will avoid to special case them later.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/symbol.c b/symbol.c
index 365351a0a756..4c93a0fb4880 100644
--- a/symbol.c
+++ b/symbol.c
@@ -121,10 +121,12 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 	base_size = sym->bit_size; 
 
 	/*
-	 * Unsized arrays cause us to not align the resulting
-	 * structure size
+	 * If the member is unsized, either it's a flexible array or
+	 * it's invalid and a warning has already been issued.
 	 */
 	if (base_size < 0) {
+		if (!is_array_type(sym))
+			return;
 		info->align_size = 0;
 		base_size = 0;
 	}
-- 
2.28.0

