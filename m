Return-Path: <SRS0=XrIr=DV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFD7C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EE8206DD
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbmgY2xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgJNJY1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbgJNJUM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:12 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2AC0613B8
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 15:06:19 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so1101083edk.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGlaUHvFNaQxLyI5NB2yzrHHwBSp6QUJHHpNu7Fx3w4=;
        b=tbmgY2xdFBFdacGltgXuriXgWmA1T0nvW0E5NdadrdIA8ynJkR995/PF7vEG+cDbPd
         2RipVgjwxhCGXZlMoj4lP9CBDcxX1h6jl2ERqpcjMYtjPGx6kRCBMI8revI4K7PyDPY8
         l54GShyLb7CEbJyJUBFxM/pVNdqCvWYZsQ0vIqn4wajvLgiP37fEFh5uwQ6FZygteBgf
         r4WrYS6uGcJsQ2XkYAlgvu4/XVmiwoJbOmdv9qcKHWyGdxcKTd7lvBy2z9fvoN3Hjvme
         GzhojdDozEaypqA/dOekXIC98u/oY5j8pvl2PmqTVAoVVGLKnXSFbyLYTRAFbY/DjUEl
         WeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGlaUHvFNaQxLyI5NB2yzrHHwBSp6QUJHHpNu7Fx3w4=;
        b=lHH2++rL3yIFHgOa5drx7p5StPySexPB8vOK1LlZ8chy5NY8legw0ozyGCmOZnWr5K
         KxYFIoOvAKD/VxClOkL4tCE3CA74ibXLtHvS4yqFH70jP+D9vaRMuzICYQaypGy9VtFL
         cSIEdanC4veI5GAJbrUXaKTPWBT3wi37tgf/mN+njRF/FR+FFzOb0q6Hxl5CjGqKzGc6
         mADyU0fHIWkVIdpZwczjaSvcNjLctVCZ9NW70jdno2Wbe50XXSNSPx0JDkMclUOGn+ms
         9pZXb7FpgIfiZsKMry1Qciobrso6d+0Xk7uTnMaY/yuU3F0EhQK7Uj1pWR0VtoK+o8zT
         qlZg==
X-Gm-Message-State: AOAM533+SvPzAhdvadRFifW2aFNHU0qqWvZCizm8jesDuTKjNdvJ1RS1
        T05uiOdE7t1QRNheZ7n1OrSnPlOF8jk=
X-Google-Smtp-Source: ABdhPJwBtknjJcQgVpUKTUMiAUiaVnWFIgYReONSqr1V3kEDYX49I37urkWzcIAaRXyGeoEwH5CNBw==
X-Received: by 2002:a05:6402:2207:: with SMTP id cq7mr1859908edb.359.1602626778313;
        Tue, 13 Oct 2020 15:06:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id h22sm577892ejc.80.2020.10.13.15.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 15:06:17 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] flex-array: fix typo in warning message
Date:   Wed, 14 Oct 2020 00:06:13 +0200
Message-Id: <20201013220613.7433-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/symbol.c b/symbol.c
index 5e7f07969f96..b758ca415583 100644
--- a/symbol.c
+++ b/symbol.c
@@ -200,7 +200,7 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 		if (has_flexible_array(member))
 			info.has_flex_array = 1;
 		if (has_flexible_array(member) && Wflexible_array_nested)
-			warning(member->pos, "nested flexible arrays");
+			warning(member->pos, "nested flexible array");
 		fn(member, &info);
 	} END_FOR_EACH_PTR(member);
 
-- 
2.28.0

