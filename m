Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8290DC433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5117D64E01
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCFKGd (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCFKGA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 05:06:00 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC33C06175F
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 02:06:00 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id mj10so8744652ejb.5
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 02:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ge3vb5YfD0avE42hELPXbN0GITFSnH5aipvTP7ovtuM=;
        b=GvW+MO/NvPpq/QBobwTPmGgETY3+ahH5wbBGAzECn+bJSJJXO2y71OaKldUmVko0Nu
         AcEhKddfhuJJHtbrTTLyEkOXkkR2cO3eAPVYzpm/FSTSfHQrrxQs1Rwx0pdZDqtwxDvw
         We/3Zhfp2A2JnfRwXznAJwSWAw8ggWUs/onnqU4pVlhHVjpxp0XViRcu4L3Bn+ibcuy5
         p2quwI1ThkxGY/Jbk5iYz6aWleqU0hCk0mEMB7+Pwh+3uqHJ+YYmzszW15IytvcTIwTy
         PaZ/zwtASAw3hl6III0fr7kE8WtW9QhOFuwjSVeU/AHxoNw58MVA6KIfY/Ec9XxGN4u0
         AuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ge3vb5YfD0avE42hELPXbN0GITFSnH5aipvTP7ovtuM=;
        b=EehLjO78TCBIbGChHbtau4ublre1dwNDIPOSTg4+eTHmOPg9FlHZdPrhd6LAHgRzs9
         TFM2TVY8PWQ5wAe2EWRLz50ge3Ycz9fpRXxy/Yc4do41kwvNn0JxIv8SMjWv09nBV9b9
         bpz1GE2fZHX2QeIDSNJwdSqhBc6c3hlZZutnV57S60Oa7z9VdITeemwkjuY3ECiHGDbu
         fClC9addgJRSAUx5ehVTILD1y0Y1Lm3TcvQWLtg8xYUIsHfWEgHuVJCRBkFC9ULqxwgl
         JI4hwuKa4ILfahMHGTzZdcHa9/81vtdC24d45lIy+IbX8gL9uIY4lHhASLXf4COKeTg9
         oNTw==
X-Gm-Message-State: AOAM533B9eHbHtsr/v/vUJdw15jM8h+eovBD3E9ifp/9i+OGSX0fOBdh
        ztwDz0zINbctKeKLaWyEpfFP7f3pRMw=
X-Google-Smtp-Source: ABdhPJygP3NeMmC2Mc/+uP9pRX8x7w1XaeEgs5zTAcwxeIYIsmKpVSMS/8V9g+X14rrJObJwU3RL3Q==
X-Received: by 2002:a17:906:d8c6:: with SMTP id re6mr6018516ejb.311.1615025159100;
        Sat, 06 Mar 2021 02:05:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c537:1c5b:9ed2:3808])
        by smtp.gmail.com with ESMTPSA id i11sm2624020ejf.76.2021.03.06.02.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 02:05:58 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] ptrlist: add pop_ptr_list()
Date:   Sat,  6 Mar 2021 11:05:49 +0100
Message-Id: <20210306100552.33784-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Some algorithms need with a stack or a working list from which the
last element can be removed. The ptrlist API has a function to do
this but it's not typed and thus needs a wrapper for each type
it's used for.

Simplify this by adding a generic (but type-safe) macro for this
while also giving it a nicer name: pop_ptr_list().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ptrlist.h b/ptrlist.h
index 3b952097545f..0b06142252f5 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -67,6 +67,12 @@ extern void **__add_ptr_list_tag(struct ptr_list **, void *, unsigned long);
 		(__typeof__(&(ptr))) __add_ptr_list_tag(head, ptr, tag);\
 	})
 
+#define pop_ptr_list(l) ({						\
+		PTRLIST_TYPE(*(l)) ptr;					\
+		ptr = delete_ptr_list_last((struct ptr_list**)(l));	\
+		ptr;							\
+	})
+
 extern void __free_ptr_list(struct ptr_list **);
 #define free_ptr_list(list)	do {					\
 		VRFY_PTR_LIST(*(list));					\
-- 
2.30.0

