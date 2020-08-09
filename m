Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179DCC433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03F9206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uI5xDRLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgHIQwx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgHIQwj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:52:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699BC061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:52:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m20so4742869eds.2
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdNMUVTt26n4fObuK/xOFzbTHs9Qfp13B3VkPljDZ44=;
        b=uI5xDRLU6uSL+AXeChPCgFUs3hT6rtmaGBKQt6OVLxSz6I44UfqxEL9p9mdKyNieC0
         Ba+QG7c5ivCSeI6SN94mhd5IKa/XI2ZcUtTHIXN2WWMa1ufYNdXYRVgLURjVF19jHKQF
         B33JHJBOwTRDdWbu8T6X5s1+ag74f3aWsNpOmZynDroJJj4xLNhzpZH9j4aHtCRar1cg
         ncLEwHvKFhzvsZhII60S0dc3xvZy6E5UFg0CTewDB0gqr22N1A7xogKbZft1y3s609O5
         BWfUfOd9AFi5L42xW3fsYObv+MY78jjlJt+UeMAzAOT0lzfPA8s67pBswUyNH+0J7V5Y
         eM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdNMUVTt26n4fObuK/xOFzbTHs9Qfp13B3VkPljDZ44=;
        b=sSrDSoA/LjTM8s4ISELS3VKMwucTQPM1zCyupzUhFxFOFg6RGcdSjnZVVXoK1UZtCc
         UL7aaCkaTEFTQkEJf/vfnUPl5NsITqdoN9QNxPyDTbGBibPojbl8nFcF/QjbpONejGrv
         1WHI3xatvVm1beoz/cnxASflaTSNighjOEgIgWtGyHHeeJjjQdaae+at8ZHbq7WLmWYG
         zneQpA4UVdvWEn1LS9RqJSWtAwyh7tCCP1LxAb/CWJ05jl/IPtyPd32OPSpy8x4jJpwG
         +ldujS1KNCRlIKHvkn+IPesThYtaSkrD0xE2d78g3s6hg9C2HUTDL+yd1RnP8yjJFgfR
         LmAQ==
X-Gm-Message-State: AOAM531JxSpM1pvojUYQ+ft1khVY00PSVbX4sEvEj0XtJxKIn+Wk52JJ
        lBiNtwk/GD7mLk+ne1Iom/HUJz3C
X-Google-Smtp-Source: ABdhPJzQw6/vLcC6A6FotARrY+AYuKJJ6B1EJunZAAiWdeYSoW3clRaFZei6dQSt3R2BV4EawxAUAA==
X-Received: by 2002:a05:6402:1c85:: with SMTP id cy5mr5023360edb.6.1596991957702;
        Sun, 09 Aug 2020 09:52:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id j11sm10810427ejx.0.2020.08.09.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:52:37 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/8] show-mod: no ending space when showing a single modifier
Date:   Sun,  9 Aug 2020 18:52:23 +0200
Message-Id: <20200809165229.36677-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
References: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index cc5dbd522b3e..cc46f1a6c5a6 100644
--- a/parse.c
+++ b/parse.c
@@ -1151,7 +1151,7 @@ static struct token *attribute_aligned(struct token *token, struct symbol *attr,
 static void apply_mod(struct position *pos, unsigned long *mods, unsigned long mod)
 {
 	if (*mods & mod & ~MOD_DUP_OK)
-		warning(*pos, "duplicate %s", modifier_string(mod));
+		warning(*pos, "duplicate %s", modifier_name(mod));
 	*mods |= mod;
 }
 
-- 
2.28.0

