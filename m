Return-Path: <SRS0=CK19=DQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C3EC433DF
	for <linux-sparse@archiver.kernel.org>; Fri,  9 Oct 2020 16:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCDBF22261
	for <linux-sparse@archiver.kernel.org>; Fri,  9 Oct 2020 16:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGRIDqWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbgJIQIx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQIx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 9 Oct 2020 12:08:53 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11726C0613D2
        for <linux-sparse@vger.kernel.org>; Fri,  9 Oct 2020 09:08:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c22so13887020ejx.0
        for <linux-sparse@vger.kernel.org>; Fri, 09 Oct 2020 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Eb76PDPzPSUeZvLljxkVtP293IzAnoAYkllSeL+7z0=;
        b=OGRIDqWbKhh0JyczGfPjEUiUrzKJ81CCP8j8lt0kRtGsCQZ4oAJ/qnMxnhRTw4sxXz
         CBZqPfJc5PJ1DiSBU59aCpflNu7AI4QwAxAVY0tRqsl35uD6I+oij/lupqqJPPEM6dmu
         k8lkQzfVekXzvd3cbn7tyfldxdxTm8oll2o7lBT1LsldjagEQA0jL6SekkffAR2vTa+e
         TDNI3VIaeQyobXhIq8n8uNIxJ/eJdSrNu+fwHw8+cf+05fwwTN4HpLngbWsT+iIhNbEp
         T/NnW3FoJlzFXGv+aDlbT3hbVPim4+aZS1FMWgnnzPxoUJTypPHjBHUuadgTNfYI4h/D
         ADuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Eb76PDPzPSUeZvLljxkVtP293IzAnoAYkllSeL+7z0=;
        b=ePnfGa10T90KNh8H/ovoZ4aV4ByaL8KeI1yDb3dbZO14LwKnt6xQwRtaHP3/vSFemW
         rGzWyAX/Go74amEBgw3nwsyTnZdhJ1YotVswsyK6jN/S+eN6TudWAE3pdtsR3AFNeSA9
         wefvslk6aZ9rjcs/Q2wBmTtvs2obkDJ0v0CLPNue5jpP43zS8trVKEE3elmoAucPWRCt
         IkepxKhokWGLk2F0VJq578/MkfECWMueBU5T58/tHjiL/nDWb6f+/yTtjbtGGUuuP8Nm
         RomZwMz4Mr5Xuo/2BZRAL5kzsBejLYEU2Hnvy+M1/GtvuLmlkM2wS6G9l5DsnqwwQs73
         gcKw==
X-Gm-Message-State: AOAM530ofY+LnbENt8B+uZigbvD/psMe9LgDPtlAl2DEbo9wgY9/JB/W
        xPA4Ms8Wr64zhIVLTP8jddKgGoT5n4s=
X-Google-Smtp-Source: ABdhPJxQSQDO3bFBYPcMnvbbyStOqebCdWrzyQb+mVTVVFSMgJjRQDMPnsxGW/xsxgHgVkhFeuQYWA==
X-Received: by 2002:a17:906:314d:: with SMTP id e13mr15310647eje.412.1602259731505;
        Fri, 09 Oct 2020 09:08:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b916:75c5:e328:ad7c])
        by smtp.gmail.com with ESMTPSA id t25sm6336246edt.24.2020.10.09.09.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:08:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] flex-array: fix location for nesting of flexible members
Date:   Fri,  9 Oct 2020 18:08:46 +0200
Message-Id: <20201009160846.23744-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The warning about the nesting of flexible array members is
given with the location of the outer struct or union but
that is not very interesting. What is needed is the location
of the member causing this nesting.

So, fix the warning message to use the member's location.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c                       | 2 +-
 validation/flex-array-nested.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/symbol.c b/symbol.c
index 9ae827c1d764..5e7f07969f96 100644
--- a/symbol.c
+++ b/symbol.c
@@ -200,7 +200,7 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 		if (has_flexible_array(member))
 			info.has_flex_array = 1;
 		if (has_flexible_array(member) && Wflexible_array_nested)
-			warning(sym->pos, "nested flexible arrays");
+			warning(member->pos, "nested flexible arrays");
 		fn(member, &info);
 	} END_FOR_EACH_PTR(member);
 
diff --git a/validation/flex-array-nested.c b/validation/flex-array-nested.c
index 63767683c56a..a82cbfc9c8e2 100644
--- a/validation/flex-array-nested.c
+++ b/validation/flex-array-nested.c
@@ -23,7 +23,7 @@ static int foo(struct s *s, union u *u)
  * check-command: sparse -Wflexible-array-nested $file
  *
  * check-error-start
-flex-array-nested.c:6:8: warning: nested flexible arrays
-flex-array-nested.c:10:7: warning: nested flexible arrays
+flex-array-nested.c:7:18: warning: nested flexible arrays
+flex-array-nested.c:11:18: warning: nested flexible arrays
  * check-error-end
  */
-- 
2.28.0

