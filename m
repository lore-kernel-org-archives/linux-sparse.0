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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD06AC4741F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B43C2075F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRQ0ef45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgI3XSn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732173AbgI3XSm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F58C0613D0
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g4so3570902wrs.5
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Y31UCU3wbqyJz2tZFq95U1yNF1X6XoMI8S2Ky/MzvY=;
        b=oRQ0ef45Ip08rSLeOymOwL4Mg4L3TpKnV40jy5xcuMYM0XfZOjrjfOyIrumjQGvYRq
         s2b6JGx+Bqkl2kraWtyeHbTIZukezLUWKBZn1bFHurud4KACpyv0gJl2i4VMWdwo4+Qc
         eujBiyKq6x3q/419dVmwlczVu5vtCgrBb6LGYpxpoTehGODev6oWdFpSASV1iY9Jq4Sm
         aFPF84cnd2z+FfkQQMhkOBInSvjEelTrWv1kdX4Fjalgc7BwfDDntxaW6MVzY0JzPepl
         YbvO36M1H832tyqPKzRi1cHHWzwFT5vbTmCrPWGBztsO5hWAsdIhX1EU5liT48p2Whbw
         qH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Y31UCU3wbqyJz2tZFq95U1yNF1X6XoMI8S2Ky/MzvY=;
        b=f74/sKYjI9GvZB4jtv7n6R6WB3PHykRurOb5A1GVZ0GP6U/7/329Hd0NOKXo4sSsW5
         Y9Ybkxpm1lmz4ZJ/DfANsVVUMt7YY2TlyZkwvCQ/ajloA+NEZ9oOu5jqikHq7KX3+q2C
         s9BYBt3/98QTE161R0n1dq1FF9rDQKmghx0tjvy4MTD65B7stOoGFptbmfmGvZcauvVp
         m5m6NKFCDn2YpGNWrG/WsPgw3FlCNPd7s3K5UjFd+oAKGNfKNYAAicc48hV2R7l3KTya
         c8wsFLLdmiRAu7nOoTiIF1/xrKwbDCchMFXYlFgHwhtDPNnB/Xm+lc4HG4XIgtDt7z38
         VjMA==
X-Gm-Message-State: AOAM531/+MV4FeR27yH8ZuXrDI9tb9prRCZlg1LEajy4PZKYRUGD3Dci
        hoP7/6S3EOk1i1ZxgoUw4hp3qR685F0=
X-Google-Smtp-Source: ABdhPJybVayQD6e1w3EcBgkqk0BTejDJu1UAY2ON4xcejzB8XiAAub13wEuKqK99f5J3p8j7A1LwVQ==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr5381463wrp.112.1601507921031;
        Wed, 30 Sep 2020 16:18:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/13] flex-array: add helper has_flexible_array()
Date:   Thu,  1 Oct 2020 01:18:24 +0200
Message-Id: <20200930231828.66751-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This will make later checks easier & clearer.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/symbol.h b/symbol.h
index 287df0a3a0ee..c9e6c7fe4439 100644
--- a/symbol.h
+++ b/symbol.h
@@ -507,6 +507,13 @@ static inline int is_extern_inline(struct symbol *sym)
 		is_function(sym->ctype.base_type);
 }
 
+static inline int has_flexible_array(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	return type->has_flex_array;
+}
+
 static inline int get_sym_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
-- 
2.28.0

