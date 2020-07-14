Return-Path: <SRS0=VjVX=AZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C02C433E5
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 00:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54562208C3
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 00:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvAxA7EH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGNAAj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNAAi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 20:00:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37126C061794
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 17:00:38 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d18so15339278edv.6
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7NKC35zYu/WqB4Ko2xyV3Qm+R140510PUYkaY2PzcU=;
        b=KvAxA7EHps6UjjEOS+x0969Abjc+U4KMhHWcCoaLTsOKgFvOosAJ/DyzQ0MZG3u6Qs
         ty7oP2WY1s15rh65P4JiMANJ2LMiUnXXq4Ml72HxfbiveIbySI3LTNWToyXRpeKHzwvi
         b6KL/2faBf/ZtUz60NL/3lQlcZyftLaGa5jp231LDWox2wPVe3ahRI6SnQSgVYpfsZDa
         h54r96lWPx46PUHgxZ89jaGZ6/dQP9upU2Dj7tAOKWRJftnBnFgNtihPrBuLkhUo/Izi
         uVno3HIZQAxVlslDmTd5z8ziKbkXSCg+pPS5Ei3MxRw9Aot8n8XksUucVSKZ2GcglI3V
         mzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7NKC35zYu/WqB4Ko2xyV3Qm+R140510PUYkaY2PzcU=;
        b=sPZPRHd5R56kRTYm1pVPyXVtnCT9pe04iLQ2EwHYM3SD6o/njN5vydr+Gx4nQyMxa+
         KngDq6UoxraS8ukUGRbG47U5G3QdhX6hYoBE0aZW1g3R62P6gPNmzcADGVduB31BklP9
         eTPo+u6tJ8hMwmNKDlSDGIWYhLzu5S7m9QAvmrJVAd2g4sRCA0m0pPrsXIeDwnMzxyay
         uw0iN6hk25vbFlRFFHsang+JTbZigONkN4dPbPRj7E3QytQ3iT6oiuebL4Zk64nPI65K
         tP9V+QuHutOFCuAEL/XMS8M/p18F8czjL1Ym11klZIbMtL/iHJX6i4UUz49oYcdG9maW
         tnHA==
X-Gm-Message-State: AOAM5309LJRBuubfEdFwkeSkxdmOTTS2pYKjA5XFQlqzr6LkvTCtXTtc
        fxk5yDnn7rPuY8gBM4NNbPRZMDhq
X-Google-Smtp-Source: ABdhPJwMYWT2D6FyMkl32GGEn2Al8VdsRnBmfXGWnAtRHTdFiDd7yNDdc8DfUb9ap8zc25q9kukpcA==
X-Received: by 2002:a50:cd1a:: with SMTP id z26mr1922899edi.120.1594684836788;
        Mon, 13 Jul 2020 17:00:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:5931:bb22:b701:e8f6])
        by smtp.gmail.com with ESMTPSA id z5sm7959443ejw.114.2020.07.13.17.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 17:00:36 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] warn on empty initializations
Date:   Tue, 14 Jul 2020 02:00:30 +0200
Message-Id: <20200714000030.85886-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714000030.85886-1-luc.vanoostenryck@gmail.com>
References: <20200714000030.85886-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently sparse accepts an empty initialization like:
	int a = ;

Make this an error.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                        | 5 ++++-
 validation/empty-initializer.c | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index a9222e7cbf08..d0a41b14b914 100644
--- a/parse.c
+++ b/parse.c
@@ -3117,7 +3117,10 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	for (;;) {
 		if (!is_typedef && match_op(token, '=')) {
-			token = initializer(&decl->initializer, token->next);
+			struct token *next = token->next;
+			token = initializer(&decl->initializer, next);
+			if (token == next)
+				sparse_error(token->pos, "expression expected before '%s'", show_token(token));
 		}
 		if (!is_typedef) {
 			if (validate_decl)
diff --git a/validation/empty-initializer.c b/validation/empty-initializer.c
index 0ca763f699a0..950679991401 100644
--- a/validation/empty-initializer.c
+++ b/validation/empty-initializer.c
@@ -2,7 +2,6 @@ static int i = ;		// KO
 
 /*
  * check-name: empty-initializer
- * check-known-to-fail
  *
  * check-error-start
 empty-initializer.c:1:16: error: expression expected before ';'
-- 
2.27.0

