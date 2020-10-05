Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9548FC4363A
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E428207F7
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbsWGk7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgJEXEM (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgJEXEJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Oct 2020 19:04:09 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCF9C0613CE
        for <linux-sparse@vger.kernel.org>; Mon,  5 Oct 2020 16:04:09 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so14631863eja.2
        for <linux-sparse@vger.kernel.org>; Mon, 05 Oct 2020 16:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8d4b956uWBWf1uHyAFZKP1tokT6f2KpK6KqQnepdCM=;
        b=LbsWGk7kcVh1YnfEhy5c1+VZZcFrSG7JgcZuOZ3eszz+d2D5hEDDhgatJQkb+Xi+IJ
         ELzlrK4rgidRFVRlMY9IggYGc5bo/zIN6xK3L6cJ/kRmIOmYId56fTH0hCWNxDgWce7F
         822BjXqq3+V3A5LfhpR8aVtJZMtjPrpRIzOIGH0dhqN6VvYOAwcKifhK29qkuwU1yBA6
         oU27KdDyLciqmSrZg4nRFA4WLmldHNX+7IaTTrtwEe7HK9/ElgFp1EHFoV2aLtGDMtZG
         6VRt/kRh2sXvXF94cdIs5xRSh+Fkkb8V/cR803XtYEs5hiaspx+FMrkHz6F6bcGThqdc
         IYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8d4b956uWBWf1uHyAFZKP1tokT6f2KpK6KqQnepdCM=;
        b=C7ubPVGZB8McfnVC1uVvlkvWIO9dqEO8myuWzRLPkRAa/+9py0Jf0pZM78wKyrstgE
         ZgUfIynzL2F6K31QccmeiEApEmWfS9+fyKKait27tb1fAsds2RYrOEDzDxwhDA27khP7
         ZSb5n/tl4FCfPSA3Uam3P14tRn6iETzawmu2pY9nwLkT3lVnnHS8/Z6QNfpSW36/S534
         piJYjw+DNhKrd+/KzpCc1FU0SYbCReBrDOxsSV515lpfxlPQpyY+NGPHDQkTYPOwlUAU
         8g2KIEV0yj4Pi6i9wgQn4iLst9dxhloXqvN1B1l/iFLxuRdURjrefXmxer+EYM7aSGA3
         CA2A==
X-Gm-Message-State: AOAM531EQ7MQLrl/MYV6PboLckE+yL3xJDS5pftSd69fXq2RgG8KoGsE
        ayO2NW2U5COgqwV5d9B8a/RNDzMkJts=
X-Google-Smtp-Source: ABdhPJw0DHwIdvg3VKzcjZk1GAK63piO+GDFnxvhyQw9r//surYlOLENFUqX1eV/inF7MD5+AHnEzQ==
X-Received: by 2002:a17:906:c43:: with SMTP id t3mr2077861ejf.219.1601939048131;
        Mon, 05 Oct 2020 16:04:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:414e:4652:8edc:a08f])
        by smtp.gmail.com with ESMTPSA id r9sm673546ejc.102.2020.10.05.16.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:04:07 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] fix evaluation of pointer to bool conversions
Date:   Tue,  6 Oct 2020 01:04:00 +0200
Message-Id: <20201005230401.74777-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005230401.74777-1-luc.vanoostenryck@gmail.com>
References: <20201005230401.74777-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The pointer to bool conversion used an indirect intermediate
conversion to an int because the pointer was compared to 0
and not to a null pointer. The final result is the same
but the intermediate conversion generated an unneeded OP_PTRTOU
instruction which made fail some tests.

Fix this by directly comparing to a null pointer of the same
type as the type to convert.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                         | 2 ++
 validation/linear/bool-cast-lp32.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index c1ef348a475e..2f3dc06f8ccb 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2883,6 +2883,8 @@ static struct symbol *cast_to_bool(struct expression *expr)
 		return NULL;
 
 	zero = alloc_const_expression(expr->pos, 0);
+	if (oclass & TYPE_PTR)
+		zero->ctype = otype;
 	expr->op = SPECIAL_NOTEQUAL;
 	ctype = usual_conversions(expr->op, old, zero,
 			oclass, TYPE_NUM, otype, zero->ctype);
diff --git a/validation/linear/bool-cast-lp32.c b/validation/linear/bool-cast-lp32.c
index 44a650f41e7f..7aab31dd34bf 100644
--- a/validation/linear/bool-cast-lp32.c
+++ b/validation/linear/bool-cast-lp32.c
@@ -12,7 +12,6 @@ static _Bool ffun_e(void)  { return (_Bool)ffun; }
 /*
  * check-name: bool-cast-pointer
  * check-command: test-linearize -m32 -fdump-ir $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: ptrtu\\.
-- 
2.28.0

