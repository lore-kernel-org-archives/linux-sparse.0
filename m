Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D49CC388F9
	for <linux-sparse@archiver.kernel.org>; Fri, 13 Nov 2020 06:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3AFD20B80
	for <linux-sparse@archiver.kernel.org>; Fri, 13 Nov 2020 06:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwyrRTWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKMG4x (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 13 Nov 2020 01:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgKMG4x (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 13 Nov 2020 01:56:53 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF05AC0613D1
        for <linux-sparse@vger.kernel.org>; Thu, 12 Nov 2020 22:56:52 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id v4so9466622edi.0
        for <linux-sparse@vger.kernel.org>; Thu, 12 Nov 2020 22:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AbCfdepnyo6A5KxUQQHzrVVzPXeQr17e1L7HrcNEhc=;
        b=GwyrRTWVzLkGUkG8eFHZbSjrqfw1e90R7sWvXtNEr5mZLd4S/n1DZFTKP1yVsR1bL/
         RyJcXaPAWSC8fzj1MEUU3/W6aS+zkcLRuL+vVxN1omT+1IscSENJ0d4g7baP5U/xlcxF
         w5FrIH7McBkc77FxFem1x+UkzjlSwGmlTmJtMd95zMZl/KlyPicaC58I1mDfliJsDpUq
         f2jiZHDj1bb31MedMchcQtdtlc+HoOKZV0byiJePsodzlqFKz4kFXI9TMY3B9EJG2Zi8
         yv4oZWGlDFp9hsmjfJ2mA0Qgm1BFCta70FXEnnRUu2aB4e9BHK4v/F3jxfG5uEgzL/Xa
         vykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AbCfdepnyo6A5KxUQQHzrVVzPXeQr17e1L7HrcNEhc=;
        b=lqlNnCXjzGYCrzFsmptGiYQSh/JLDvNHwUrkJQsIQGNBhjW2mBm6SrOzxdfkPnpfFH
         R7PPINvrZs7oHB/PAz8N63A4REpYyrUEkPj5I9jQwxFl5rRcGEAnwiDhwAnzcaiTqkIf
         Al77XIm1lds4giCVAJzQslWF1TTJfMqR7mBCwbZc55w+q3gFqy9kaboONOvY4zbmKtj0
         WVp3SzHB5WG2uKppgqkFuaMJmeG9LQlcGsJLVLf5jR4sdqe8cpnySObF2HxlhgKRJ0fV
         aadSfVsTt5gl4YgZgklDbl1I4OLs1Y59gCX5BNSZiYh47Z6tUw8SFLE/d2FQC1bJnWj/
         XHdA==
X-Gm-Message-State: AOAM5324kFj22xNfS+3Xv7MwktZwZvj63aXl01uHcmG2m/VDWMotby+R
        /EF9KBpT2yjXD6qE2Kxr0oUUgx5kzj8=
X-Google-Smtp-Source: ABdhPJzrV8l53nOJyyPCMHKMmd8Dlg+DJC771mXKB0qU6zspdyQXy8b0TMtiqbJdtvg+UBxuNKIcNw==
X-Received: by 2002:aa7:d9c2:: with SMTP id v2mr1047018eds.95.1605250611221;
        Thu, 12 Nov 2020 22:56:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b8ad:4918:8d1f:1912])
        by smtp.gmail.com with ESMTPSA id u17sm2985233eje.11.2020.11.12.22.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 22:56:50 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: add some doc about using NULL or VOID in ptrlists
Date:   Fri, 13 Nov 2020 07:56:45 +0100
Message-Id: <20201113065645.28764-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ptrlist.c b/ptrlist.c
index 3af0b2c5fbaa..0f0b3f6d818f 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -7,6 +7,18 @@
 ///
 // Pointer list manipulation
 // -------------------------
+//
+// The data structure handled here is designed to hold pointers
+// but two special cases need to be avoided or need special care:
+// * NULL is used by {PREPARE,NEXT}_PTR_LIST() to indicate the end-of-list.
+//   Thus, NULL can't be stored in lists using this API but is fine to
+//   use with FOR_EACH_PTR() and its variants.
+// * VOID is used to replace a removed pseudo 'usage'. Since phi-nodes
+//   (OP_PHI) use a list to store their operands, a VOID in a phi-node
+//   list must be ignored since it represents a removed operand. As
+//   consequence, VOIDs must never be used as phi-node operand.
+//   This is fine since phi-nodes make no sense with void values
+//   but VOID is also used for invalid types and in case of errors.
 
 #include <stdlib.h>
 #include <string.h>
-- 
2.29.2

