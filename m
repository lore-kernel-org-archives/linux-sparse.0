Return-Path: <SRS0=2q2/=EF=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76722C00A89
	for <linux-sparse@archiver.kernel.org>; Fri, 30 Oct 2020 15:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EACC2083B
	for <linux-sparse@archiver.kernel.org>; Fri, 30 Oct 2020 15:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkd/fiOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgJ3Pgv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgJ3Pgv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 30 Oct 2020 11:36:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CC7C0613CF
        for <linux-sparse@vger.kernel.org>; Fri, 30 Oct 2020 08:36:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg9so7055643edb.12
        for <linux-sparse@vger.kernel.org>; Fri, 30 Oct 2020 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qES/tqy5Qj4+53t4HOrr7dBdFErqjsctn3WqAvJv2P8=;
        b=Gkd/fiOD/NrhXYyF+AL0XVpqi0AnhJMLFko1XM1P4lovOS/iK6wN9thrVH3/gDHq3O
         fCvBJ62hHl+9n94rKyDh4LxKZQV18B8gHd7Qbw08rJsw5UZ3dr9LmcTPIY63bxKS6VkU
         28fqolSmd5+S5IHHn7m959wm91Rlwlq5tOh+qIrXzdl/zJttMmnrjfGifxmIZtCxOOTy
         PgGnMMhe48NiupvBp0ucougpRcgdMZoXtqcsBcbabyrZ/MOd4Jlj1tfd+ZBSBhit+6Dh
         XnXc5Qc5kx0/fRYBGN4Uu5RoYyGJFf54nm0DP5TkgD8inToL2cW7Hgc7juFeqJxJ1U1k
         pwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qES/tqy5Qj4+53t4HOrr7dBdFErqjsctn3WqAvJv2P8=;
        b=UlTnS0viUoou7fSoReUHzdo14+WfxyHdkryZ+3wCEEvHzSwwRNq0AhnCfNYm2t/6Ls
         H4dErncLLiVD1PIgEgCGa6IKd2KhMC+vhIQSV6PVZZiDyB0MFhGymZ76oBh2mbT2FgSi
         3hxiohnP2Hyfkyx7MZ0Em81erY/7kbrNeKPNP5W7pFLArX3DkJ6IV1L2DoYCoOrfS59j
         Wwnhzrr3KOZyatIG2/FXzyvQ7naRDMyiU2fPK3K6da5GvwTy46B02eDqDGUARMO2kzpS
         cn/lYSatO8JdnGy5DgeLiW5fsDVl9T+g5SBHhX1b4loCQLeEFJGSCu75wIO0gAwcrXTs
         hYAQ==
X-Gm-Message-State: AOAM530XgGbiCyPuMPHb6NExgb/sjXjLasqMLxKl2Ltl5iCiYF2XDmfm
        ZMo7sJOabWoghDrMLZl/RJyrppejJrs=
X-Google-Smtp-Source: ABdhPJzqoDmgdoKplnCDJ5TSERH6RYkQD89qW23wCdnxa8iPT3lvXPR4mvPCeY6YdN2tTw4PbOwgOg==
X-Received: by 2002:a05:6402:1d82:: with SMTP id dk2mr2921454edb.299.1604072209547;
        Fri, 30 Oct 2020 08:36:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:29f3:92a7:2520:4dda])
        by smtp.gmail.com with ESMTPSA id ce13sm3317043edb.32.2020.10.30.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:36:48 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix usage count in linearize_fma()
Date:   Fri, 30 Oct 2020 16:36:45 +0100
Message-Id: <20201030153645.19042-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When linearizing __builtin_fma(), the arguments were just
assigned but the corresponding usage was not tracked.

Fix this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linearize.c b/linearize.c
index 85d370de5728..bf9b6ecdc92e 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2591,11 +2591,11 @@ static pseudo_t linearize_fma(struct entrypoint *ep, struct expression *expr)
 	struct expression *arg;
 
 	PREPARE_PTR_LIST(expr->args, arg);
-		insn->src1 = linearize_expression(ep, arg);
+		use_pseudo(insn, linearize_expression(ep, arg), &insn->src1);
 		NEXT_PTR_LIST(arg)
-		insn->src2 = linearize_expression(ep, arg);
+		use_pseudo(insn, linearize_expression(ep, arg), &insn->src2);
 		NEXT_PTR_LIST(arg)
-		insn->src3 = linearize_expression(ep, arg);
+		use_pseudo(insn, linearize_expression(ep, arg), &insn->src3);
 	FINISH_PTR_LIST(arg);
 
 	add_one_insn(ep, insn);
-- 
2.29.1

