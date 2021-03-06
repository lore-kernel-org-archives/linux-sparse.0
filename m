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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F4C433E6
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD6C6501B
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhCFKGd (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCFKGB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 05:06:01 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E66C061760
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 02:06:00 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lr13so8738889ejb.8
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 02:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6enWgGsW2bbhfDC2+kbh/15Shhx2XSxq3naZnv9GAL8=;
        b=BgdYFcWzmwjnrG06DZqS9/UWEINfNS5TnNmLxtQdA9pu5zjPRk7NhlP3KYPUzn2ZtS
         YLIcgwDvqW2wf5nG7Nsnz2N0JViYPcIUFbW7ry+y7zgCGqY+0Po/bE5MVInZqWTp5HzT
         uzxPM8Jwah7NvbMLtPO2tu59bXdDgJfL2fwe53rLeJ2UrDLA9Uxgy5KKLm56ZaLWR9J0
         6e0TgKKdo2o7oddgZGv1wiqeY1K3/O9Y5PdvKSGIDnpxqmUXR+/edyeGq2dLELiyLs6y
         O57TK8HPtqmJScZ6V7uppXTMFO4HHMs7r7/kpCuFh325LT+ZmpBHVwF1/Yq8zkyOVQUV
         dN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6enWgGsW2bbhfDC2+kbh/15Shhx2XSxq3naZnv9GAL8=;
        b=YUfw5Q3TluPwoFyo4LC1M8Cmh1go0wtee9CpiYTQu+N7DY990hUBp5Q8QvRrn6DKN4
         UVukdr4TiPpzbgfYW6boGKG+F+GuVj/RvyJuLF7TBUtdGMbUVtDD4akXvrN+TFWfGHVh
         xnKoKjzASCASCOX6+gacs90gg/0ISgRzP/mqHrd+KfBQTqalW346nQGoOQtwhmiNItqx
         J1ECdzEUHajZiQhXNP1v+EJ7pmIfuM5Gt+4YlzawF+8tTRG629ynaK1v0hUb56VuK7T6
         VSDuqJMuI3aYfAp0qabOzZyfhN4i7yPhNlXOgiZe03hpBnoWUnXomTyzby3wKODS6wTd
         Tiew==
X-Gm-Message-State: AOAM533Hpdh2lmmGbnVQ497ND/XyeBD556OAcL6gsC6VobcuOp/uLWah
        LH3vh8TKYbIAUJMN4HxG+qusKXoVWSY=
X-Google-Smtp-Source: ABdhPJyDu2ib/9/exMYUWt/ZjK3NA5YVULQSRl+uaPDaL/ktNTtUy1oT9sWyW+cmV1WnS3V5liBwTQ==
X-Received: by 2002:a17:906:1155:: with SMTP id i21mr6258303eja.218.1615025159724;
        Sat, 06 Mar 2021 02:05:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c537:1c5b:9ed2:3808])
        by smtp.gmail.com with ESMTPSA id i11sm2624020ejf.76.2021.03.06.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 02:05:59 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] ptrlist: use ptr_list_nth() instead of linearize_ptr_list()
Date:   Sat,  6 Mar 2021 11:05:50 +0100
Message-Id: <20210306100552.33784-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse has a few extra checkers for some functions.
The one for memset has its own helper the retrieve its 3rd arguments.

Remove this helper and use the generic ptr_list_nth() instead.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sparse.c b/sparse.c
index 151eaf4ef5ed..9d62d4fe4fc4 100644
--- a/sparse.c
+++ b/sparse.c
@@ -163,20 +163,9 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
 	/* OK, we could try to do the range analysis here */
 }
 
-static pseudo_t argument(struct instruction *call, unsigned int argno)
-{
-	pseudo_t args[8];
-	struct ptr_list *arg_list = (struct ptr_list *) call->arguments;
-
-	argno--;
-	if (linearize_ptr_list(arg_list, (void *)args, 8) > argno)
-		return args[argno];
-	return NULL;
-}
-
 static void check_memset(struct instruction *insn)
 {
-	check_byte_count(insn, argument(insn, 3));
+	check_byte_count(insn, ptr_list_nth(insn->arguments, 3));
 }
 
 #define check_memcpy check_memset
-- 
2.30.0

