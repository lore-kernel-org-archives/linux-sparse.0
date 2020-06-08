Return-Path: <SRS0=Ikw0=7V=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3FDC433DF
	for <linux-sparse@archiver.kernel.org>; Mon,  8 Jun 2020 23:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006FB2068D
	for <linux-sparse@archiver.kernel.org>; Mon,  8 Jun 2020 23:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqcbp5C6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgFHXfo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbgFHXdz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 8 Jun 2020 19:33:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A0C08C5C2
        for <linux-sparse@vger.kernel.org>; Mon,  8 Jun 2020 16:33:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so20278850eja.7
        for <linux-sparse@vger.kernel.org>; Mon, 08 Jun 2020 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLnoGcSBwNc4Mqd/XZ48U5iNY6S2peGrF0slnahvhu4=;
        b=Sqcbp5C635bL+rtbeFedAdZA/3FodD1uXiu0ECRLXQ6KIWQqpthCjm1a7UyWeyIY3F
         w+Bj0zB2AYJIA5VqSbdCgDuYvtuykLYLsbx1E0hCelBQDStuYXnbcpb5bG2Lf7lbjh7k
         cUdPKtTmc9D2Q3LjTdk4Y7nnCHOlcMfUK/72geRJlWfSU7ofAKlYh3gjswJGMg3eSAe8
         +8xMo7XGdfesdR6xPd1VwlaHL069rA3Ykh6N97dbnTwfrNXLcUmPH+SX0OiHZup8Yri/
         4iy1uufWV+YlxsDdvnZ5pgvCnX4a0IQhQmC266TBk5+sARSoHRBwcOskCJKejqQy/8R4
         HbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLnoGcSBwNc4Mqd/XZ48U5iNY6S2peGrF0slnahvhu4=;
        b=FubpMqQy76NA2EcmO5aa17Nlx/rvIvZAFAZAFe0vFYbv3wq+RM73xMcIYSYm7ss8Y+
         a/rTaN3QWjcO2YyuALzIRZgJe8zL4eCzVTp6AhQlNUixszDqrgTOW/gPJDnaKpMkr9Ma
         EtO6ejUbXH9wFAOZW7YjlseCHyzNL7Y3q1PIIk1xFhFn+12yZNB92sttjjlqqNqWXbyi
         onT4svKiXRbiKZYLB9PFjI6Fg76wawe8UdckNggV3b4gBMDQhPR2F9waxuAlPcAAmjdu
         33K4CHMf9FTSYEuYZrq3tptv72fHeN3Rqp4ovW5YY83DnEIIdmedd935pXzdwppvDRyW
         oKpw==
X-Gm-Message-State: AOAM5326Il6YKX6PGr+MHHR/2dDIxPQrLcTycUC5Y+/SGFeBMpODxYBR
        xFBtb0bPqjbbuQgQ0glslHlQ7LYe
X-Google-Smtp-Source: ABdhPJwwDGuibHt9htnmTFzyllWh63iRFTqkOU97C4EqBhomKy65lxdJ0Kwh2q1mPX3WEKD9t9FdzA==
X-Received: by 2002:a17:906:b28e:: with SMTP id q14mr22614830ejz.484.1591659232859;
        Mon, 08 Jun 2020 16:33:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:e5c2:dcb5:e6a2:428e])
        by smtp.gmail.com with ESMTPSA id v29sm14008225edb.62.2020.06.08.16.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 16:33:52 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] pre-process: remove unneeded declaration of show_token_sequence()
Date:   Tue,  9 Jun 2020 01:33:48 +0200
Message-ID: <20200608233348.66209-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200608233348.ZgBBcKqIg80hGu31gMyKiNSAXWa3lS_ZTWEdt_MjCas@z>

Remove this declaration which follows the definition.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index d96035e2339f..e6becf233eba 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1585,8 +1585,6 @@ static int handle_ifndef(struct stream *stream, struct token **line, struct toke
 	return preprocessor_if(stream, token, arg);
 }
 
-static const char *show_token_sequence(struct token *token, int quote);
-
 /*
  * Expression handling for #if and #elif; it differs from normal expansion
  * due to special treatment of "defined".
-- 
2.27.0

