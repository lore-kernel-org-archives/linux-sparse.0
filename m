Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E4C388F7
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160EB20704
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 13:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3y+/Sg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKGNIP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 08:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNIP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 08:08:15 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B3C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 05:08:14 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id t9so667201edq.8
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 05:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8vm+ONZ9o2cEKDPU8ITr7tL9zEuO+DocfIL57b+f+s=;
        b=L3y+/Sg/OBTAOEHS7gmhYTChQBiWlzi923a3OAfhp4rRfLwwPBtNwpO8lAsfqsuEV5
         4o7UtG++n0h7uvIvzKSz38frLX2fVGxMEIE0y3Z5pMge256nNYpgs7e0T01JbVBXLIs9
         7Xx44AFOQ8iE0KYk5FkorYXhddfLfaSrE8JExCamgGKOWlQVdBiPxxT4t14VOiDHVfvX
         arHEykEyqfMiMw/VBxb/ltprnzwv3D6MMm4M0QSGHlZLhdqs+Ql2TszBtv+nYC8JNZFR
         I9xnlw1Ey56tfs1zTRCjhi/sb55nFHK4KBfP9X/4ncJB5icydNwUzAy+rbPKyvNgEp0U
         MUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8vm+ONZ9o2cEKDPU8ITr7tL9zEuO+DocfIL57b+f+s=;
        b=pX9succGQ298pzz5wo12EuGhF4l10TEQ1qdwDl8quq+tY2ClvdNutnHBnbRlwZXhVK
         j1sI1RBEfoufByI8iQP27qUNlcD9oE4v/jho8fxIMICjyoD907AY04NutxbRM+HtKh5T
         RjgoKFXrctEzFqjatKrO++kR2DxE43E6Kenq80Kd0vxqUfpmVrAT2QjHTdfNUndAmFcM
         cCO/jnIrV3gClye6szoZosvt2BkmjSKvEXuBRS/wXc+RMojGDyM5YDpKn3RGJEmtLzzG
         EZbVsFZ6u6Wnh+4b+kMoMEHiY9SAOxsCQ/axa3l5FzSbO9OHmYpHuOoj488Cv+TeIuJ4
         h6pQ==
X-Gm-Message-State: AOAM530u0zlsL0PdRuKBWlI1hsbbP4oEAQ8AGsVv8pY1pyqruFQiV3gs
        0fdkyg8O34C5YKD8tCeT1qW8U03/AnA=
X-Google-Smtp-Source: ABdhPJxofQfzBIUeBRPm/l4QGJ3phmmlOKuTOpyWsVIYe+VO6V1hMaRjiumlbuhhSZQsD9FUe3DjBA==
X-Received: by 2002:aa7:c4c2:: with SMTP id p2mr6984543edr.371.1604754493046;
        Sat, 07 Nov 2020 05:08:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:59a2:5681:b2fc:1a9])
        by smtp.gmail.com with ESMTPSA id p18sm3462576edt.23.2020.11.07.05.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 05:08:12 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add debug helpers: show_insn_bb() & show_insn_entry()
Date:   Sat,  7 Nov 2020 14:08:07 +0100
Message-Id: <20201107130807.12893-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These 2 helpers are just small wrappers around show_instruction()
and show_entry() but can be called even when the instruction is
removed. They're just handy when debugging.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linearize.c b/linearize.c
index c1e3455adb67..d0762f5a3a45 100644
--- a/linearize.c
+++ b/linearize.c
@@ -563,6 +563,15 @@ void show_bb(struct basic_block *bb)
 		printf("\tEND\n");
 }
 
+///
+// show BB of non-removed instruction
+void show_insn_bb(struct instruction *insn)
+{
+	if (!insn || !insn->bb)
+		return;
+	show_bb(insn->bb);
+}
+
 static void show_symbol_usage(pseudo_t pseudo)
 {
 	struct pseudo_user *pu;
@@ -610,6 +619,15 @@ void show_entry(struct entrypoint *ep)
 	printf("\n");
 }
 
+///
+// show the function containing the instruction but only if not already removed.
+void show_insn_entry(struct instruction *insn)
+{
+	if (!insn || !insn->bb || !insn->bb->ep)
+		return;
+	show_entry(insn->bb->ep);
+}
+
 static void bind_label(struct symbol *label, struct basic_block *bb, struct position pos)
 {
 	if (label->bb_target)
-- 
2.29.2

