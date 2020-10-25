Return-Path: <SRS0=+N6z=EA=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1334C5517A
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625182222F
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+qsYTMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416175AbgJYNJa (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416173AbgJYNJ3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 25 Oct 2020 09:09:29 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A05CC0613CE
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:09:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dt13so9549868ejb.12
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLBPnTW0xp6j2mSd+XL9Pevi0ZgADIBjRKi9Suf2Z3I=;
        b=h+qsYTMs+Xeg73Dwm5VGn7Z4ixK96cvC7kRTv6mPF8QEsnFU3t/7aW+VOmIDQGtyen
         RUdX32eAWNMTdhUaUzMWBSQlo9M4rFY3r3C0Gvgf/PkfZz+Nrxnp1Crzt2J8PN489Lq1
         x7zj4u+iu18a6IEjApenFte1oJVQBv7sQOxcwKeyQo9OKKj8Bbvl9OZc+Pop6CRa3Xxq
         dbLwmHtjT93401en8Wi0v+a1JIpshE1yBcQWJHAJ6JC3hLGm6CkRn8CWUo+MF475wdrp
         KpVdTxh6xeY450fVemuQVd5oXu1CXOFXwix663kE5gUH/fxcKdxXDwCkrrhVDIBPt5VN
         P/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLBPnTW0xp6j2mSd+XL9Pevi0ZgADIBjRKi9Suf2Z3I=;
        b=jqrbtSy+iiKK5GnMV4cOqQr3IeqTKGOQRzVXjm4ObUxzJpKfeOnkDAxMz5AuhZjh3J
         6cnj/gg+qp2DjjdnDO/eyEKQU6ECEHg3naa49/EVLQnscK947J8wcFfokkP9AG74f/xj
         zoM4soIOIEUrK2SSFoLQOGXe/XxJBaSNdn27GO+eMRQMjXB8/RKTg1dLkmGvx9cOth3I
         UZkF5c6eiIValluwHO16k+0d/SeEuZ7UvcXSlQIAdzADeFDFRkHRsCep7nFCckJbmq2p
         d4XI9NjE6jk/Dav5uIrgnKsv+CCrzhDfg7AWasDB9OtaEiKbA6pQS8hCGKD8JiK9cwCG
         x8HQ==
X-Gm-Message-State: AOAM5321iZXqERtvkbrY11RDZ9ioTkuBWN4wYkIpW+UY7mkusRBEYI6Q
        0SJ3jQrYH8Fyf8wZ6Ij4HiBx4OrVQYo=
X-Google-Smtp-Source: ABdhPJxU+mqztHMvz03GSmYKD9Dw7ELVvNwNWGKj0ETtz7DmrliZ/KJt90mCuuX6sZAu+VuAvPQQ1A==
X-Received: by 2002:a17:906:1246:: with SMTP id u6mr11124500eja.432.1603631367928;
        Sun, 25 Oct 2020 06:09:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f136:83e9:1c3d:13f2])
        by smtp.gmail.com with ESMTPSA id q3sm3571350edv.17.2020.10.25.06.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 06:09:27 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add helper first_symbol()
Date:   Sun, 25 Oct 2020 14:09:20 +0100
Message-Id: <20201025130921.20693-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025130921.20693-1-luc.vanoostenryck@gmail.com>
References: <20201025130921.20693-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is just a wrapper around first_ptr_list().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib.h b/lib.h
index 0b1d4492e6bd..b4c3db93ab31 100644
--- a/lib.h
+++ b/lib.h
@@ -204,6 +204,11 @@ static inline pseudo_t first_pseudo(struct pseudo_list *head)
 	return first_ptr_list((struct ptr_list *)head);
 }
 
+static inline struct symbol *first_symbol(struct symbol_list *head)
+{
+	return first_ptr_list((struct ptr_list *)head);
+}
+
 static inline void concat_symbol_list(struct symbol_list *from, struct symbol_list **to)
 {
 	concat_ptr_list((struct ptr_list *)from, (struct ptr_list **)to);
-- 
2.29.0

