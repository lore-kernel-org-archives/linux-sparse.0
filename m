Return-Path: <SRS0=QBgf=BB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7B1C433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 22 Jul 2020 21:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E1422B43
	for <linux-sparse@archiver.kernel.org>; Wed, 22 Jul 2020 21:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAIfrn8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGVV2V (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgGVV2V (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Jul 2020 17:28:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD000C0619DC
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2020 14:28:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so3894940eje.7
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2020 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIZpSG9182uT5FAv0tsO/0ytptixECeBmYVpBxyNbQQ=;
        b=EAIfrn8XYkgVqC4cxYx2ULWGm+A1BOBRxqYCn0buLuDO4Hp4ISDiK0+UwjV1Uye2GH
         4t5bgFyW8N/FeZdtc89vTAGebsZ2/ILiJ6sC3CXd1HF4EG4P2l0H7RldIt6TRYM0XhOw
         Ug6jr80QllJtQeSaYxWlzo0rQ7/f2g7Zb2EsbwU1lc+S/5suGfytaqv7kasvgpVYTyPn
         XItHj13KuU4K8VovDx1ap4QzTIz2lkWQwk0gBbdUnwwdB66hFIN751WDXdCdfvkjt9W6
         RbLfdn/bcRc9WeTPseT1CyQGFk5aZ3mkVMdXujgfQqEAsEqQaCnqqdDTPe0RzJUD7Rr/
         YNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIZpSG9182uT5FAv0tsO/0ytptixECeBmYVpBxyNbQQ=;
        b=XT/FEr+6o7wRhUu8HKrlmoOoqaD4X5JP5S2k6WzOiKUaUzsiGLnw8hrgmgQbyTq9v1
         VSws/lil7KQqDPr+vr/n3iVSrPHUbzhEChEDMxAXrh471DP/HjgIITMpje52SCLKhulW
         TkXxmTh59ftZNO9zvWrT/rAK05J7jDD1mxxRdbPhGz+w2CV8iMWAC2/CuNMly7gznHE+
         6RxeUD0+cxUDpunamlfhKnD0qhnzF+yE4kNcJyilr2roB2Xm0CJN0jy3k70hQ5IcA37g
         57QtrfHFthncbfc7IzbzeyZuPwx0LTcWVrOZqAueWDYvm2zffZgHg6sbhQ/ys8jgddr7
         LkVw==
X-Gm-Message-State: AOAM533bIe+P2llxJgcOhJIBB7JUrR369ap7G++qAifoys+NQp4GTJR+
        KVMUqsoTHjR9NXwYw7tPEJvPu5gM
X-Google-Smtp-Source: ABdhPJz8zKOIt9qIGeIM5xqAeQZ4NU9xqVIRzoCuUaVNsxPjCf36DrrJ9PGnvvW4x3YNXIBXCgLtPA==
X-Received: by 2002:a17:906:3152:: with SMTP id e18mr1486077eje.137.1595453299210;
        Wed, 22 Jul 2020 14:28:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:905b:ad5c:bc87:c79e])
        by smtp.gmail.com with ESMTPSA id k15sm544973eji.49.2020.07.22.14.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 14:28:18 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] option: accept 'sparse -U ...'
Date:   Wed, 22 Jul 2020 23:28:04 +0200
Message-Id: <20200722212804.36493-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The '-D' flag was fixed to accept whitespace before the argument
but the '-U' flag wasn't. So, fix this now.

Fixes: 7f1011b311e9329f53d73f88de495ea64071eb77
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/options.c b/options.c
index a2e15bb75c0d..f7e81b84d749 100644
--- a/options.c
+++ b/options.c
@@ -782,6 +782,12 @@ static char **handle_switch_s(const char *arg, char **next)
 static char **handle_switch_U(char *arg, char **next)
 {
 	const char *name = arg + 1;
+
+	if (*name == '\0') {
+		name = *++next;
+		if (!name)
+			die("argument to `-U' is missing");
+	}
 	add_pre_buffer("#undef %s\n", name);
 	return next;
 }
-- 
2.27.0

