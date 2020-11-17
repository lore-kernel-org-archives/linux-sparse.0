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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C8C5519F
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 17:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256B1241A7
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 17:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFzePaWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKQR13 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 17 Nov 2020 12:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgKQR13 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 17 Nov 2020 12:27:29 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A94C0613CF
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 09:27:29 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id oq3so30533613ejb.7
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 09:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMKiq0TF5Xmh71FEBJ2lUnRnaigH9YIcaPFQCmLGy8o=;
        b=nFzePaWNo/FOLzVHkKFvwQLxnsBHs1ycdj1T8RTywOf26+cB2pTEyIBjU4dkbUJUFJ
         ydSkhHq/qRkUZ1jR+8a4Uk9yhXv4YwfNXOjWqrPBhSQNO1OAhh62Q13g58jr6C1QC4BA
         4lBKumn1heGifo0m0y5h7qA2hr5T26/HigAISllkttlu1V9fZ7uruUiEk15HMaSHQKip
         HHXb/auNCy/dmWtSd/NdNnF1sQLzAEHVUt2QOxWqkJ99YUnNiatEyoj/R2uFl2R8YJDP
         krXSFw8czDAPpWyRB0/MmeQ6f6kLOKaORHIt+EE9vXXi6yzE2KxrOZT0XDysxMO8Ze1l
         D56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMKiq0TF5Xmh71FEBJ2lUnRnaigH9YIcaPFQCmLGy8o=;
        b=qTookz0pYgm5NoWQLb0XYtvWlAjHo7hQy4d1BFusNlOXsAV7ThDf6BDPD/nQkNIyOe
         yxxIb5Y99OAo4dApQOZbdwHX3mvPMLne7mEMO4ujuotB7ioXSj8cIF+vTckS69AmQhwZ
         M3RILnwzNZBpujIXx+Wwwf9gYcM7z8PqDO4n4AToLDpSY/ynFQp3pbhXzManIhuBdT9W
         84u58SSwGMrbNgl4jaHQsh8o4Tinc12jY+vcQ5tv5mpObsTIEqP5B3vcjMNMub7keCws
         Rd8fIehaGPBqGbH/i/2uWYeFjtjF3Arghvevr04tObffvUFQzpFAkQkr6E+DwwFHzqJW
         CLBQ==
X-Gm-Message-State: AOAM533kPFGlbGRwf3lYWimOlIzR8E0jrNMO9gqjyduDc14RvMCP9fMT
        Qrl53/XdMySdVPp06AkjLHSr2Fp7meM=
X-Google-Smtp-Source: ABdhPJxR6dGnG1qTQB7rTvwiYhiUaUlgDJZ2JpFvNRQ3Gr7ennDU8+kVNt+6ywtqkvYUcB1lZQaALg==
X-Received: by 2002:a17:906:ee2:: with SMTP id x2mr9429167eji.326.1605634047515;
        Tue, 17 Nov 2020 09:27:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:ec88:97fa:6d80:7ccf])
        by smtp.gmail.com with ESMTPSA id lu33sm11675228ejb.98.2020.11.17.09.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:27:26 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] linearize: remove unneeded forward declarations
Date:   Tue, 17 Nov 2020 18:27:06 +0100
Message-Id: <20201117172706.79905-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These declarations are not needed, so remove them.

A few of the other ones could/should be removed but
it would need to shuffle some code around.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/linearize.c b/linearize.c
index d3c009b36d22..76c116ba112e 100644
--- a/linearize.c
+++ b/linearize.c
@@ -28,12 +28,8 @@ static pseudo_t linearize_expression(struct entrypoint *ep, struct expression *e
 
 static pseudo_t add_cast(struct entrypoint *ep, struct symbol *to, struct symbol *from, int op, pseudo_t src);
 static pseudo_t add_binary_op(struct entrypoint *ep, struct symbol *ctype, int op, pseudo_t left, pseudo_t right);
-static pseudo_t add_setval(struct entrypoint *ep, struct symbol *ctype, struct expression *val);
 static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym);
 
-struct access_data;
-static pseudo_t add_load(struct entrypoint *ep, struct access_data *);
-static pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *initializer, struct access_data *);
 static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *from, struct symbol *to);
 
 struct pseudo void_pseudo = {};
-- 
2.29.2

