Return-Path: <SRS0=8Fyo=DL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF15C4363C
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Oct 2020 16:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FB12068D
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Oct 2020 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRUJlndp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJDQNc (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgJDQN0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 12:13:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707FBC0613CE
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 09:13:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d81so1138940wmc.1
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t1qRtzB2152SDiuCx7/mNks8hIErVLRMflD+dO7jgpE=;
        b=vRUJlndpxLjNvn9cqoe/T753eu1BdnEJ0Or4Izk3yevny9vE8J10Hb/vWnwPNALcwc
         OtL8ZbCPYebT86TVnQrPf5KBlTdx39xMOSl0H9SUnUTWKEuRFQvuN93vIsFCguu3jx7s
         XqUj9kcyS3gSAxP30vV+hpF8+8gRAtst8Jk3yhbdbETdzJkSQFCWiD2QqYm8BtK0ASza
         BDOUJl2nZuugJltKPnhwe/wqZIka9VnLN0hiurhR8lgSqGfEwc9OUqxgTWB5Cx129JLr
         gEJgMX7Gz4T8Aidr3ndTj8xrZY/xfgFRXdfMmmqXm8p6djbo7xqayhg+64SoOqjh5ECD
         xmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t1qRtzB2152SDiuCx7/mNks8hIErVLRMflD+dO7jgpE=;
        b=KyGmZBsKZqWTgo9vc2vr+sDLZY/Jdkc7owzjFW5YtspiSPaATtQl2IrsBFypyFGm3a
         c7coPMnNmvBsecFvnMDiJFdoxngKyJ6jg8+ijiFyatXlSiNoDKGKM87nG84GdYObGt9/
         JFxA/fuaAGxBS0BxqlKqmDbG6sGwGExU2+jJN40Na+BjeuakKii6yl2nGIDt4FHt56NH
         Hrtp0k3jwTdHzYrucg95ySOCBWv0izJxF/t/qr8ElHwUYtjNj2Ax3puHvIhq3E+swkEl
         m9N4VHlMmnqtJkZcw3yVh1dVDHxdrKepb0YVRz2SbugIlFg1/i1I7+pQtaMjqeSFNn7w
         3K4Q==
X-Gm-Message-State: AOAM533Adole9dzc/9h+YiPY4J6x5rJQC9PzdStborq2R9OsUJ1ur4uT
        IycQj9XdHR5Pw3cs1nsHdIh01RL25HE=
X-Google-Smtp-Source: ABdhPJwAXIykpEX05ivSgmzS9EqDFSBKThf5zVkF/uUo/GD77OR6HI7f04e58VsTVr7gz1KklNvg+g==
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr12398894wmh.103.1601828004858;
        Sun, 04 Oct 2020 09:13:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id c25sm9236201wml.31.2020.10.04.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 09:13:24 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add helper get_nth_expression()
Date:   Sun,  4 Oct 2020 18:13:21 +0200
Message-Id: <20201004161321.75380-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This will be used for -Wformat.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib.h b/lib.h
index b35debc83288..957586dbd80a 100644
--- a/lib.h
+++ b/lib.h
@@ -199,6 +199,11 @@ static inline struct expression *first_expression(struct expression_list *head)
 	return first_ptr_list((struct ptr_list *)head);
 }
 
+static inline struct expression *get_nth_expression(struct expression_list *head, unsigned int n)
+{
+	return ptr_list_nth_entry((struct ptr_list *)head, n);
+}
+
 static inline pseudo_t first_pseudo(struct pseudo_list *head)
 {
 	return first_ptr_list((struct ptr_list *)head);
-- 
2.28.0

