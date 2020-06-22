Return-Path: <SRS0=te3q=AD=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6185C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 22 Jun 2020 22:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FF22073E
	for <linux-sparse@archiver.kernel.org>; Mon, 22 Jun 2020 22:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luQkJlKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgFVWjB (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgFVWjB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jun 2020 18:39:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459AC061573
        for <linux-sparse@vger.kernel.org>; Mon, 22 Jun 2020 15:39:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id y6so14925760edi.3
        for <linux-sparse@vger.kernel.org>; Mon, 22 Jun 2020 15:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmXkXhvb56a+O+Cf1od6o810RfNCiKE5avBRNms9uxg=;
        b=luQkJlKMO7xbvQonXz0BHUa0KlHH7vgJjdcjOhIsLFxOTSnKeQcvaSxwgJquHSqMWC
         Pi7TAuI+CQYkArjFHu1eIjlXMoEMIMSZ17O2tL9+ba0+PxVSBPibJIC2Q52Q/R0JRS7W
         waxFFqp7wr0q/sCjNVp32e6mexAKW7hcVLo6oJkC8CsUVUiAx0vpGWelc62p/97BMs4R
         BdDSqzpj4YimMD56Lzoirm6CmsxkEnfc9w0HSgRNIvMkV7TkcMfWBT/XRRIm9PnkOW5j
         kUo/5eQU0FaUgcllDgfoYv4FUIVK+3S0bS0uySqoZp0iAqsHFJNAJtUB1fnQakyYG7EL
         7QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmXkXhvb56a+O+Cf1od6o810RfNCiKE5avBRNms9uxg=;
        b=bb0WQE4KcS6DkvdSUW5wakXG4bBJBeyxFQdtXbLpEYbVWK0ysprNkfdyyvSEyed8JE
         CTGImC9Ly/HQzchD0ckCclp6h3wh696aPkCcD2l2A1nQiAnI6wHZfn7YHGN7OjL9UbuK
         xINOvUUffa3C+zHTyjmDzFpYRNjG9kJy3XDHfMLuAQHTxTFzthvuq4eRMCLsfZhl6Kgy
         hFQsKDRCGNXl/lIuyOF5xfxvnFrrq07HKy05cM/jqbD/vo7frMte/AP84n2tZjnmzRSF
         ubMSReIlzBbR9D0wVfvyxxnrE8EZ71YS0SUBXK7Cg0hRXf30dLgearB5TxVZ/cVSafP6
         5LzQ==
X-Gm-Message-State: AOAM531RLqh1ruscDuQZUULNCgRNVKxzeAPQ2CDQhXbP6KVI4p8KmwTL
        10q9LYuZfLWE030oMpoU95LOKlGI
X-Google-Smtp-Source: ABdhPJxFib1Am/5S0yquUqw8MPv+ArupVe4FJPgL655sGgqCoU3zSyFRCI8fOdkrFC2WfLlucjbZ5Q==
X-Received: by 2002:aa7:c752:: with SMTP id c18mr18756969eds.55.1592865539425;
        Mon, 22 Jun 2020 15:38:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:1000:aea:1de2:ed50])
        by smtp.gmail.com with ESMTPSA id p4sm3939980eja.9.2020.06.22.15.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:38:58 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] gensel: remove unneeded test/uninitialized warning
Date:   Tue, 23 Jun 2020 00:38:54 +0200
Message-ID: <20200622223854.87802-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200622223854.Yhubpa68MicfkfWKfPmfv0HhiS6MZpKXStxlkZ88lbs@z>

When evaluation generic selections, it is tested if the type in
the selection is a SYM_NODE or not, but:
* all these are SYM_NODE
* the variable for the base type would be uninitialized
  if not a SYM_NODE.

So, remove the test and unconditionally set the base type.

Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index aa0f208006bb..461c2547285f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3304,9 +3304,7 @@ static struct symbol *evaluate_generic_selection(struct expression *expr)
 		if (!evaluate_symbol(stype))
 			continue;
 
-		if (stype->type == SYM_NODE)
-			base = stype->ctype.base_type;
-
+		base = stype->ctype.base_type;
 		if (base->type == SYM_ARRAY && base->array_size) {
 			get_expression_value_silent(base->array_size);
 			if (base->array_size->type == EXPR_VALUE)
-- 
2.27.0

