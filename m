Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8871C433B4
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Apr 2021 19:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A8D6124B
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Apr 2021 19:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhDDTiF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Apr 2021 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhDDTiE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Apr 2021 15:38:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB416C061756
        for <linux-sparse@vger.kernel.org>; Sun,  4 Apr 2021 12:37:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so10583199eds.7
        for <linux-sparse@vger.kernel.org>; Sun, 04 Apr 2021 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5dsBjy3ZMxZRt/0WTWGyAfNHFkqqfQPUl+UPjFNqYM=;
        b=HP00ZhzR5sKoiZ5w3D38gg08TzvUkqS8Iy7FRD1ozXZLq5rmRn30QqYIlaCksxP6Hf
         0pA8LA92yt/pHD2m3qSfjPdIK77zXGMysh2cxVhuK1DYaNwtYByRRFPq2ZwqKFxECkGc
         h8apNcI/IYr6SpjDDSjkMxM7+4mo+Zdd1YfqQZbCSMBgEhZZaJ44fYiP1gNaGMQU+Ew9
         BFTXP0Jx2UJmxosySS+6p6ppt6N+sK6cI+teer46IRZ2rngb8kbMClooIJq8gdJgnXcw
         Zt5JXiWxCbmuPDCt1fXsx00uliRkkNW7un6qkqYXPSjLZIBPdCBM/ufvkCk7UphKIbma
         waGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5dsBjy3ZMxZRt/0WTWGyAfNHFkqqfQPUl+UPjFNqYM=;
        b=emYp53Do9zcyzFTs70Z2HchDEWl+dToYETrjzrfELvedMxOAsmgrMsNrEx7u6ZI8qi
         VNCd9t2JikCyZK0PDLd+4OTjTPCJ9u9P1DijcWVz5+6DY85bWo537ISCsFGTO1I/d4lO
         GVH3Ji46xuU7JtVRlx1lsKpWgwnYULlJqYZktclvYcYeCpudM5nu+eQq/jwzQUIojaVE
         8MO/5q0AIg22u5Ug+v2IVfnWqfbmPVxOiNpiEi083VqtJ1o6/dHeMNzvYZ/nbAsZGPZw
         tOP+rlU2vJh7Dnq/OnWF7nF28MF8tj5eSbf+uuIkSFgie5/a+zT/vNwji+wjjQirYWsb
         BQQA==
X-Gm-Message-State: AOAM532PiudbB5tPqVrOL6Y2uraEK/zGzLhLFfWkj2NQ78xFt8GY8bkw
        YTmAj4DCd7vq4uDtduzOMiJDmkZ6ouU=
X-Google-Smtp-Source: ABdhPJzT8dYh9RE0VoXdpCXwGMiPCR6Qz16vk5M/wSfK3XD8/obbeYLqMmUS4bzEoyU/yIjX4IzMRQ==
X-Received: by 2002:a05:6402:254f:: with SMTP id l15mr27611866edb.189.1617565078312;
        Sun, 04 Apr 2021 12:37:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b520:40cc:e61c:a906])
        by smtp.gmail.com with ESMTPSA id s11sm9074333edt.27.2021.04.04.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 12:37:57 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix null-pointer crash with with ident same as one of the attributes
Date:   Sun,  4 Apr 2021 21:37:51 +0200
Message-Id: <20210404193751.1986-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

match_attribute() will crash when the token has the same identifier
as one of the attributes but is not an attribute. In this case,
the corresponding symbol_op will be null but this is not checked.
This seems to happen only with old-style declarations.

Fix this by adding the missing null-check.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                     |  2 +-
 validation/knr-attr-crash.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 validation/knr-attr-crash.c

diff --git a/parse.c b/parse.c
index 70be616c45ae..bc1c0602fcb4 100644
--- a/parse.c
+++ b/parse.c
@@ -1653,7 +1653,7 @@ static bool match_attribute(struct token *token)
 	if (token_type(token) != TOKEN_IDENT)
 		return false;
 	sym = lookup_keyword(token->ident, NS_TYPEDEF);
-	if (!sym)
+	if (!sym || !sym->op)
 		return false;
 	return sym->op->type & KW_ATTRIBUTE;
 }
diff --git a/validation/knr-attr-crash.c b/validation/knr-attr-crash.c
new file mode 100644
index 000000000000..176ff5032120
--- /dev/null
+++ b/validation/knr-attr-crash.c
@@ -0,0 +1,12 @@
+typedef int word;
+
+void foo(word x);
+
+void foo(x)
+	word x;
+{ }
+
+/*
+ * check-name: knr-attr-crash
+ * check-command: sparse -Wno-old-style-definition $file
+ */
-- 
2.31.1

