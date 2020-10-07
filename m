Return-Path: <SRS0=ZUDq=DO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48EBC4363D
	for <linux-sparse@archiver.kernel.org>; Wed,  7 Oct 2020 22:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F33521789
	for <linux-sparse@archiver.kernel.org>; Wed,  7 Oct 2020 22:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga7oMk/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgJGWsR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 7 Oct 2020 18:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbgJGWsR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Oct 2020 18:48:17 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F55BC061755
        for <linux-sparse@vger.kernel.org>; Wed,  7 Oct 2020 15:48:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o18so3892419edq.4
        for <linux-sparse@vger.kernel.org>; Wed, 07 Oct 2020 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nh7PkMBSCElOkYPB6x8C5gvF99WWfjyqZuaE0g4D/8=;
        b=Ga7oMk/W2H27rcwF9D9Oijz5nOD9ubhm/wM9KNR7kkRYCugmnfBxCyidPcJvxdoibJ
         h8uCs7XDHx4QPw4poqlzC5///HzwueIwq4Xj7GEOtO4smjNmS06SnmEBftrSK8ps3ECt
         mseLNUKD19ij0MOhVS3+bGZ4/1v0PK8yBHkMyxYuqdrjgztwmR9Tau2qkHvLzNZneRBY
         UejTPlP41G4GZ8Arjgtg55t/qmDapaa62Zj5wJslOCi67uo4nn5NVIn46T0cxGB/t3sp
         rM8stottoCRnHw7gbymSPtacy6pfac1pGvYt9cKJ6hif5XIr8WvNaetFapX2YuIJgZUb
         D/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nh7PkMBSCElOkYPB6x8C5gvF99WWfjyqZuaE0g4D/8=;
        b=hZTE6SmxMNE7oCcObG8Vs3acU4c70FdVQEbZ+1aqaZu1wAc44XSsXATCrPVnXwZAY8
         kfqQANCDTCR8iz5kc6RI/5I3xXlxthKmE8C8EIIy6FAK29vNjTR+zinqJsxdOQ8IPyyE
         qNIdww3AIhCzF9421G945XPGdz5E/q5fga37zOUCNOsnHrRGL8jwxvlU4+3j5XlJ6AnT
         LxPKMZISmwXDRKLO1jEDUEx5Wlf59OzzwAL0KJUMvKCV8NqKTkOv6soiauGwSC5fIWid
         KW0/G097US60a+4WET8xhWbKvONQp8b8MzTUjt468Q1f+ISj7p0Wk+Wg9mFlSRB+fmAe
         AO3Q==
X-Gm-Message-State: AOAM5300lp0H8+Sx7Hwc/34QwBIs0fqNSSFHWNsQom6IUDf+bvytMALn
        EaToW13zEcQA6Fi4+Rdlszo6LGc5dnk=
X-Google-Smtp-Source: ABdhPJyjhmKteHeNdlowql0jcJup481BTYwEgP8iEzGjEParOmaTts7ogjE2JGyANW2zRxVnW7YewA==
X-Received: by 2002:aa7:db82:: with SMTP id u2mr6210414edt.262.1602110895033;
        Wed, 07 Oct 2020 15:48:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9daf:ccef:2e0a:ac1c])
        by smtp.gmail.com with ESMTPSA id c5sm2573888edx.58.2020.10.07.15.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 15:48:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ilya Maximets <i.maximets@ovn.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add helpers is_struct_type() &  is_union_type()
Date:   Thu,  8 Oct 2020 00:48:09 +0200
Message-Id: <20201007224809.3289-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Ilya Maximets <i.maximets@ovn.org>

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/symbol.h b/symbol.h
index e1f5392600ef..e75ea3abfcd3 100644
--- a/symbol.h
+++ b/symbol.h
@@ -425,6 +425,20 @@ static inline int is_array_type(struct symbol *type)
 	return type->type == SYM_ARRAY;
 }
 
+static inline int is_struct_type(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	return type->type == SYM_STRUCT;
+}
+
+static inline int is_union_type(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	return type->type == SYM_UNION;
+}
+
 static inline int is_float_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
-- 
2.28.0

